#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define get_bit(word, index) (word >> index)&1
#define set_bit(word, index, val) ((word & ~(1 << index)) | ((val&1) << index))
#define get_field(word, index, mask) (word >> index)&mask
#define set_field(word, index, mask, value) (word & ~(mask << index)) | (value << index)
#define get_byte_0(w) (w & 0xFF)
#define get_byte_1(w) ((w>>8) & 0xFF)
#define get_byte_2(w) ((w>>16) & 0xFF)
#define get_byte_3(w) ((w>>24) & 0xFF)

#define ADDR_INSTR 0x0000
#define ADDR_DATA  0x2000
#define MEM_SIZE   16384

int32_t breg[32];
uint32_t	pc,				// contador de programa
            sp,				// stack pointer
            gp,				// global pointer
            ri,				// registrador de intrucao
            code_size,      // numero de instruções do programa
            code_limit;     // endereço limite
uint32_t	opcode,		// codigo da operacao
            rs1,		// indice registrador rs
            rs2,		// indice registrador rt
            rd,			// indice registrador rd
            shamt,		// deslocamento
            funct3,		// campos auxiliares
            funct7;		// constante instrucao tipo J

int32_t		imm12_i,	// constante 12 bits
            imm12_s,				// constante 12 bits
            imm13,					// constante 13 bits
            imm20_u,				// constante 20 bis mais significativos
            imm21,					// constante 21 bits
            imm32;                  // constante de 32 bits: o imediado da instrução

enum INSTRUCTIONS ins_code;
char stop_prg;
enum OPCODES {
    LUI         = 0x37,		AUIPC = 0x17,	// atribui 20 superiores
    ILType      = 0x03,						// Loads
    BType       = 0x63,						// branch condicional
    JAL         = 0x6F,		JALR = 0x67,	// jumps
    StoreType   = 0x23,					    // store
    ILAType     = 0x13,						// logico-aritmeticas com imediato
    RegType     = 0x33,                     // Tipo R, operações com registradores
    ECALL       = 0x73                      // Chamada do sistema
};
enum FUNCT3 {
    BEQ3=0,		BNE3=01,	BLT3=04,	BGE3=05,	BLTU3=0x06, BGEU3=07,
    LB3=0,		LH3=01,		LW3=02,		LBU3=04,	LHU3=05,
    SB3=0,		SH3=01,		SW3=02,
    ADDSUB3=0,	SLL3=01,	SLT3=02,	SLTU3=03,
    XOR3=04,	SR3=05,		OR3=06,		AND3=07,
    ADDI3=0,	ORI3=06,	SLTI3=02,	XORI3=04,	ANDI3=07,
    SLTIU3=03,	SLLI3=01,	SRI3=05
};
enum FUNCT7 {
    ADD7=0,	SUB7=0x20,	SRA7=0x20,	SRL7=0, SRLI7=0x00,	SRAI7=0x20
};
enum FORMATS { RType, IType, SType, SBType, UType, UJType, NullFormat, NOPType };
enum INSTRUCTIONS {
    I_add,	I_addi, I_and,  I_andi, I_auipc,
    I_beq,	I_bge,	I_bgeu, I_blt,  I_bltu,
    I_bne,  I_jal,	I_jalr, I_lb,	I_lbu,
    I_lw,   I_lh,   I_lhu,  I_lui,  I_sb,
    I_sh,   I_sw,   I_sll,  I_slt,  I_slli,
    I_srl,  I_sra,  I_sub,  I_slti, I_sltiu,
    I_xor,	I_or,	I_srli, I_srai,  I_sltu,
    I_ori, I_ecall, I_xori, I_nop
};

void init();
void fetch ();
void decode ();
int read_reg(int index);
void input_code_data(void);
int32_t get_imm32(enum FORMATS);
enum INSTRUCTIONS get_instr_code(uint32_t opcode, uint32_t func3, uint32_t func7);
enum FORMATS get_i_format(uint32_t opcode, uint32_t func3, uint32_t func7);
void execute ();
void step();
void run();

int8_t mem[MEM_SIZE];

int32_t lb(uint32_t reg, int32_t kte) {
    uint32_t address = reg + kte;
    return (int32_t)mem[address];
}
int32_t lbu(uint32_t reg, int32_t kte) {
    uint32_t address = reg + kte;
    return (uint8_t)mem[address];
}
int32_t lw(uint32_t reg, int32_t kte) {
    uint32_t address = reg + kte;
    uint32_t word;
    word = ((uint32_t)(uint8_t)mem[address])
           | ((uint32_t)(uint8_t)mem[address + 1] << 8)
           | ((uint32_t)(uint8_t)mem[address + 2] << 16)
           | ((uint32_t)(uint8_t)mem[address + 3] << 24);
    return (int32_t)word;
}
void sb(uint32_t reg, int32_t kte, int8_t byte) {
    uint32_t address = reg + kte;
    mem[address] = byte;
}
void sw(uint32_t reg, int32_t kte, int32_t word) {
    uint32_t address = reg + kte;
    mem[address]     = word & 0xFF;
    mem[address + 1] = (word >> 8) & 0xFF;
    mem[address + 2] = (word >> 16) & 0xFF;
    mem[address + 3] = (word >> 24) & 0xFF;
}
void init() {
    pc = 0;
    ri = 0;
    code_limit = code_size * 4;
    stop_prg = 0;
    sp = 0x3ffc;
    gp = 0x1800;
}
void fetch() {
    ri = lw(pc, 0);
    pc = pc + 4;
}
void decode() {
    int32_t tmp;
    opcode = ri & 0x7F;
    rs2 = (ri >> 20) & 0x1F;
    rs1 = (ri >> 15) & 0x1F;
    rd = (ri >> 7) & 0x1F;
    shamt = (ri >> 20) & 0x1F;
    funct3 = (ri >> 12) & 0x7;
    funct7 = (ri >> 25);
    imm12_i = ((int32_t) ri) >> 20;
    tmp = get_field(ri, 7, 0x1f);
    imm12_s = set_field(imm12_i, 0, 0x1f, tmp);
    imm13 = imm12_s;
    imm13 = set_bit(imm13, 11, imm12_s & 1);
    imm13 = imm13 & ~1;
    imm20_u = ri & (~0xFFF);
    imm21 = (int32_t) ri >> 11;            // estende sinal
    tmp = get_field(ri, 12, 0xFF);        // le campo 19:12
    imm21 = set_field(imm21, 12, 0xFF, tmp);    // escreve campo em imm21
    tmp = get_bit(ri, 20);                // le o bit 11 em ri(20)
    imm21 = set_bit(imm21, 11, tmp);            // posiciona bit 11
    tmp = get_field(ri, 21, 0x3FF);
    imm21 = set_field(imm21, 1, 0x3FF, tmp);
    imm21 = imm21 & ~1;                    // zero bit 0
    ins_code = get_instr_code(opcode, funct3, funct7);
    imm32 = get_imm32(get_i_format(opcode, funct3, funct7));
}
int read_reg(int index) {
    if (index == 0)
        return 0;
    return breg[index];
}
enum FORMATS get_i_format(uint32_t opcode, uint32_t func3, uint32_t func7) {
    switch (opcode) {
        case 0x33 : return RType;
        case 0x03: case 0x13: case 0x67: case 0x73:
            return IType;
        case 0x23 : return SType;
        case 0x63 : return SBType;
        case 0x37 : return UType;
        case 0x6F: case 0x17 : return UJType;
        default:
            printf("Undefined Format");
            return NullFormat;
            break;
    }
}
enum INSTRUCTIONS get_instr_code(uint32_t opcode, uint32_t funct3, uint32_t funct7) {
    switch (opcode) {
        case LUI: return I_lui;
        case AUIPC: return I_auipc;
        case BType:
            switch (funct3) {
                case BEQ3: return I_beq;
                case BNE3: return I_bne;
                case BLT3: return I_blt;
                case BGE3: return I_bge;
                case BLTU3: return I_bltu;
                case BGEU3: return I_bgeu;
            }
            break;
        case ILType:
            switch (funct3) {
                case LB3: return I_lb;
                case LH3: return I_lh;
                case LW3: return I_lw;
                case LBU3: return I_lbu;
                default:
                    break;
            }
            break;
        case JAL: return I_jal;
        case JALR: return I_jalr;
        case StoreType:
            switch (funct3) {
                case SB3: return I_sb;
                case SH3: return I_sh;
                case SW3: return I_sw;
                default: break;
            }
            break;
        case ILAType:
            switch (funct3) {
                case ADDI3: return I_addi;
                case ORI3:  return I_ori;
                case ANDI3: return I_andi;
                case XORI3: return I_xori;
                case SLTI3: return I_slti;
                case SLTIU3: return I_sltiu;
                case SLLI3: return I_slli;
                case SRI3:
                    if (funct7 == SRLI7) return I_srli;
                    else return I_srai;
                default: break;
            }
            break;
        case RegType:
            switch (funct3) {
                case ADDSUB3:
                    if (funct7 == SUB7) return I_sub;
                    else return I_add;
                case SLL3: return I_sll;
                case SLT3: return I_slt;
                case SLTU3: return I_sltu;
                case XOR3: return I_xor;
                case OR3:  return I_or;
                case AND3: return I_and;
                case SR3:
                    if (funct7 == SRA7) return I_sra;
                    else return I_srl;
                default: break;
            }
            break;
        case ECALL:
            return I_ecall;
        default:
            printf("\n\nInstrucao Invalida (PC = %08x RI = %08x)\n", pc, ri);
            break;
    }
    return I_nop;
}

void execute() {
    switch (ins_code)
    {
        // Instruções do Tipo R
        case I_add:
            if (rd != 0)
                breg[rd] = (int32_t)breg[rs1] + (int32_t)breg[rs2];
            break;

        case I_sub:
            if (rd != 0)
                breg[rd] = (int32_t)breg[rs1] - (int32_t)breg[rs2];
            break;

        case I_and:
            if (rd != 0)
                breg[rd] = breg[rs1] & breg[rs2];
            break;

        case I_or:
            if (rd != 0)
                breg[rd] = breg[rs1] | breg[rs2];
            break;

        case I_xor:
            if (rd != 0)
                breg[rd] = breg[rs1] ^ breg[rs2];
            break;

        case I_sll:
            if (rd != 0)
                breg[rd] = (uint32_t)breg[rs1] << (breg[rs2] & 0x1F);
            break;

        case I_srl:
            if (rd != 0)
                breg[rd] = (uint32_t)breg[rs1] >> (breg[rs2] & 0x1F);
            break;

        case I_sra:
            if (rd != 0)
                breg[rd] = (int32_t)breg[rs1] >> (breg[rs2] & 0x1F);
            break;

        case I_slt:
            if (rd != 0)
                breg[rd] = ((int32_t)breg[rs1] < (int32_t)breg[rs2]) ? 1 : 0;
            break;

        case I_sltu:
            if (rd != 0)
                breg[rd] = ((uint32_t)breg[rs1] < (uint32_t)breg[rs2]) ? 1 : 0;
            break;
        
        // Instruções do Tipo I
        case I_addi:
            if (rd != 0)
                breg[rd] = (int32_t)breg[rs1] + imm12_i;
            break;

        case I_andi:
            if (rd != 0)
                breg[rd] = breg[rs1] & (uint32_t)imm12_i;
            break;

        case I_ori:
            if (rd != 0)
                breg[rd] = breg[rs1] | (uint32_t)imm12_i;
            break;

        case I_xori:
            if (rd != 0)
                breg[rd] = breg[rs1] ^ (uint32_t)imm12_i;
            break;

        case I_slti:
            if (rd != 0)
                breg[rd] = ((int32_t)breg[rs1] < imm12_i) ? 1 : 0;
            break;

        case I_sltiu:
            if (rd != 0)
                breg[rd] = ((uint32_t)breg[rs1] < (uint32_t)imm12_i) ? 1 : 0;
            break;

        case I_slli:
            if (rd != 0)
                breg[rd] = (uint32_t)breg[rs1] << shamt;
            break;

        case I_srli:
            if (rd != 0)
                breg[rd] = (uint32_t)breg[rs1] >> shamt;
            break;

        case I_srai:
            if (rd != 0)
                breg[rd] = (int32_t)breg[rs1] >> shamt;
            break;

        case I_jalr:
            if (rd != 0)
                breg[rd] = pc;
            pc = (breg[rs1] + imm12_i) & ~1u;
            break;

        case I_lb:
            if (rd != 0)
                breg[rd] = lb(breg[rs1], imm12_i);
            break;

        case I_lbu:
            if (rd != 0)
                breg[rd] = lbu(breg[rs1], imm12_i);
            break;

        case I_lh:
            if (rd != 0) {
                uint32_t address = (uint32_t)breg[rs1] + (uint32_t)imm12_i;
                uint16_t v = (uint16_t)(((uint16_t)mem[address]) |
                                       ((uint16_t)mem[address + 1] << 8));
                breg[rd] = (int16_t)v;
            }
            break;

        case I_lhu:
            if (rd != 0) {
                uint32_t address = (uint32_t)breg[rs1] + (uint32_t)imm12_i;
                uint16_t v = (uint16_t)(((uint16_t)mem[address]) |
                                       ((uint16_t)mem[address + 1] << 8));
                breg[rd] = (uint32_t)v;
            }
            break;

        case I_lw:
            if (rd != 0)
                breg[rd] = lw(breg[rs1], imm12_i);
            break;

        // Instruções do Tipo U
        case I_auipc:
            if (rd != 0)
                breg[rd] = (pc - 4) + ((uint32_t)imm20_u); // Não sei pq mas é sem o << 12
            break;

        case I_lui:
            if (rd != 0)
                breg[rd] = imm20_u;
            break;
        
        // Instruções do Tipo SB
        case I_beq:
            if (breg[rs1] == breg[rs2])
                pc = pc - 4 + imm13;
            break;

        case I_bne:
            if (breg[rs1] != breg[rs2])
                pc = pc - 4 + imm13;
            break;

        case I_bge:
            if ((int32_t)breg[rs1] >= (int32_t)breg[rs2])
                pc = pc - 4 + imm13;
            break;

        case I_bgeu:
            if ((uint32_t)breg[rs1] >= (uint32_t)breg[rs2])
                pc = pc - 4 + imm13;
            break;

        case I_blt:
            if ((int32_t)breg[rs1] < (int32_t)breg[rs2])
                pc = pc - 4 + imm13;
            break;

        case I_bltu:
            if ((uint32_t)breg[rs1] < (uint32_t)breg[rs2])
                pc = pc - 4 + imm13;
            break;

        case I_sb:
            sb(breg[rs1], imm12_s, (int8_t)breg[rs2]);
            break;

        case I_sh:
            {
                uint32_t address = (uint32_t)breg[rs1] + (uint32_t)imm12_s;
                uint16_t v = (uint16_t)breg[rs2];
                mem[address] = (uint8_t)(v & 0xFF);
                mem[address + 1] = (uint8_t)((v >> 8) & 0xFF);
            }
            break;

        case I_sw:
            sw(breg[rs1], imm12_s, breg[rs2]);
            break;

        // Instruções do Tipo UJ
        case I_jal:
            if (rd != 0)
                breg[rd] = pc;
            pc = pc - 4 + imm21;
            break;

        // Instruções do sistema
        case I_ecall:
            switch ((int)breg[17]) {  // a7
                case 5: {
                    int x;
                    scanf("%d", &x);
                    breg[10] = x;   // a0
                    break;
                }
                case 1:
                    printf("%d", breg[10]);  // a0
                    break;
                case 10:
                    stop_prg = 1;
                    break;
                default:
                    break;
            }
            break;

        default:
            break;
    }
}

void step() {
    fetch();
    decode();
    execute();
}

int32_t get_imm32(enum FORMATS iformat) {
    switch (iformat) {
        case RType:     return 0;
        case IType:     return imm12_i;
        case SType:     return imm12_s;
        case SBType:    return imm13;
        case UType:     return imm20_u;
        case UJType:    return imm21;
        default:        return 0;
    }
}

void reset_state(void) {
    for (int i = 0; i < 32; i++) breg[i] = 0;
    for (int i = 0; i < MEM_SIZE; i++) mem[i] = 0;
    pc = 0;
    ri = 0;
    stop_prg = 0;
    opcode = 0;
    rs1 = rs2 = rd = 0;
    shamt = 0;
    funct3 = 0;
    funct7 = 0;
    imm12_i = imm12_s = imm13 = imm20_u = imm21 = 0;
}

void run() {
    init();
    while ((pc < code_limit) && !stop_prg)
        step();
}

int main(void) {

   init();

    /* Valores iniciais */
    breg[1] = 100;
    breg[2] = 30;

    /* Instruções em memória */
    sw(0,  0, 0x002082B3);  /* add   x5, x1, x2   */
    sw(0,  4, 0x40208333);  /* sub   x6, x1, x2   */
    sw(0,  8, 0x123453B7);  /* lui   x7, 0x12345  */
    sw(0, 12, 0x00001417);  /* auipc x8, 0x00001  */

    /* Executa as instruções */
    step();   /* add   */
    step();   /* sub   */
    step();   /* lui   */
    step();   /* auipc */

    /* Resultados esperados */
    printf("%d\n", breg[5]);          /* 130 */
    printf("%d\n", breg[6]);          /* 70  */
    printf("0x%08X\n", breg[7]);      /* 0x12345000 */
    printf("0x%08X\n", breg[8]);      /* 0x0000100C */
    
    return 0;
}
