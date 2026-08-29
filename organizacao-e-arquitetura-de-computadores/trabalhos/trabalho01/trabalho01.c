#include <stdio.h>
#include <stdint.h>

#define MEM_SIZE 1024
#define DATA_SEG 512

int8_t mem[MEM_SIZE];

int32_t lb(uint32_t reg, int32_t kte){
    uint32_t endereco_memoria = reg + kte;
    
    return (int32_t) mem[endereco_memoria];
}

int32_t lbu(uint32_t reg, int32_t kte) {
    uint32_t endereco_memoria = reg + kte;
    
    return (uint8_t) mem[endereco_memoria];
}

int32_t lw(uint32_t reg, int32_t kte){
    uint32_t endereco_memoria = reg + kte;
    
    uint8_t byte0 = mem[endereco_memoria]; 
    uint8_t byte1 = mem[endereco_memoria + 1]; 
    uint8_t byte2 = mem[endereco_memoria + 2]; 
    uint8_t byte3 = mem[endereco_memoria + 3]; 
    
    return ((uint32_t) byte3 << 24) | ((uint32_t) byte2 << 16) | ((uint32_t) byte1 << 8)  | (uint32_t) byte0;    
}

void sb(uint32_t reg, int32_t kte, uint8_t byte){
    uint32_t endereco_memoria = reg + kte; 
    mem[endereco_memoria] = byte;
}

void sw(uint32_t reg, int32_t kte, uint32_t word){
    uint32_t endereco_memoria = reg + kte;
    
    int8_t byte0 = word & 0xFF; 
    int8_t byte1 = (word >> 8) & 0xFF; 
    int8_t byte2 = (word >> 16) & 0xFF; 
    int8_t byte3 = (word >> 24) & 0xFF; 
    
    mem[endereco_memoria] = byte0;
    mem[endereco_memoria + 1] = byte1;
    mem[endereco_memoria + 2] = byte2;
    mem[endereco_memoria + 3] = byte3;
}

void teste_lb(void)
{
    mem[100] = (int8_t)0xEF;
    mem[101] = (int8_t)0xAD;
    mem[102] = (int8_t)0x7C;
    mem[103] = (int8_t)0x7B;

    printf("lb(100, 0) = 0x%08x\n", (uint32_t)lb(100, 0));
    printf("lb(100, 1) = 0x%08x\n", (uint32_t)lb(100, 1));
    printf("lb(100, 2) = 0x%08x\n", (uint32_t)lb(100, 2));
    printf("lb(100, 3) = 0x%08x\n", (uint32_t)lb(100, 3));
}


void teste_lbu(void)
{
    mem[100] = (int8_t)0xEF;
    mem[101] = (int8_t)0xAD;
    mem[102] = (int8_t)0xAC;
    mem[103] = (int8_t)0xAB;

    printf("lbu(100, 0) = 0x%08x\n", (uint32_t)lbu(100, 0));
    printf("lbu(100, 1) = 0x%08x\n", (uint32_t)lbu(100, 1));
    printf("lbu(100, 2) = 0x%08x\n", (uint32_t)lbu(100, 2));
    printf("lbu(100, 3) = 0x%08x\n", (uint32_t)lbu(100, 3));
}


void teste_lw(void)
{
    /* Inicialização direta da memória */
    mem[100] = (int8_t)0xEF;
    mem[101] = (int8_t)0xAD;
    mem[102] = (int8_t)0xAC;
    mem[103] = (int8_t)0xAB;

    printf("lw(100, 0) = 0x%08x\n", (uint32_t)lw(100, 0));
}


void teste_sb(void)
{
    sb(100, 0, 0x11);
    sb(100, 1, 0x22);
    sb(100, 2, 0x33);
    sb(100, 3, 0x44);

    printf("mem[100] = 0x%02x\n", (uint8_t)mem[100]);
    printf("mem[101] = 0x%02x\n", (uint8_t)mem[101]);
    printf("mem[102] = 0x%02x\n", (uint8_t)mem[102]);
    printf("mem[103] = 0x%02x\n", (uint8_t)mem[103]);
}


void teste_sw(void)
{
    sw(100, 0, 0x11223344);

    printf("mem[100] = 0x%02x\n", (uint8_t)mem[100]);
    printf("mem[101] = 0x%02x\n", (uint8_t)mem[101]);
    printf("mem[102] = 0x%02x\n", (uint8_t)mem[102]);
    printf("mem[103] = 0x%02x\n", (uint8_t)mem[103]);
}


int main(void)
{
    int teste;

    scanf("%d", &teste);

    switch (teste)
    {
        case 1:
            teste_lb();
            break;

        case 2:
            teste_lbu();
            break;

        case 3:
            teste_lw();
            break;

        case 4:
            teste_sb();
            break;

        case 5:
            teste_sw();
            break;

        default:
            printf("Teste invalido\n");
            break;
    }

    return 0;
}
