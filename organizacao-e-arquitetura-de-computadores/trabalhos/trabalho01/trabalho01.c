#include <stdio.h>
#include  <stdint.h>
#define MEM_SIZE 16384

int8_t mem[MEM_SIZE]; // Memória é um array de 16KBytes

// sb(reg, kte, byte): Escreve o byte passado como parâetro na memória.
void sb(int32_t reg, int32_t kte, int8_t byte){
    int32_t endereco_memoria = reg + kte; 
    mem[endereco_memoria] = byte;
}

// lb(reg, kte): lê um byte da memória e o converte para um inteiro de 32 bits estendendo o sinal do byte. Retorna o inteiro de 32 bits. 
int32_t lb(int32_t reg, int32_t kte){
    int32_t endereco_memoria = reg + kte;
    int8_t byte_lido; 

    byte_lido = mem[endereco_memoria];

    return (int32_t) byte_lido;
}

// lbu(reg, kte): lê um byte da memória e o converte para um inteiro de 32 bits sem sinal (valor  positivo). Retorna o inteiro de 32 bits.
uint32_t lbu(int32_t reg, int32_t kte){
    int32_t endereco_memoria = reg + kte;
    uint8_t byte_lido; 

    byte_lido = mem[endereco_memoria];
    return (uint32_t) byte_lido;
}

// lw(reg, kte): lê uma palavra de 32 bits da memória e retorna o seu valor. 
uint32_t lw(int32_t reg, int32_t kte){
    int32_t endereco_memoria = reg + kte;
    
    uint8_t byte0 = mem[endereco_memoria]; 
    uint8_t byte1 = mem[endereco_memoria + 1]; 
    uint8_t byte2 = mem[endereco_memoria + 2]; 
    uint8_t byte3 = mem[endereco_memoria + 3]; 
    
    return (byte3 << 24) | (byte2 << 16) | (byte1 << 8) | byte0;
    
}

// sw(reg, kte, word): escreve os 4 bytes de word na memória, colocando o menos significativo no endereço especicicado e os outros nos endereços de byte seguintes.
void sw(int32_t reg, int32_t kte, uint32_t word){
    int32_t endereco_memoria = reg + kte;
    
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

int main(){
    sb(7, 0, 0xaa); 
    int32_t word = lb(7, 0); 
    printf("word_10 = %d\n",  word); 
    printf("word_x = 0x%08x\n", (uint32_t)word);

    printf("------------------------------\n");

    int32_t word1 = lbu(7, 0); 
    printf("word_10 = %d\n",  word1); 
    printf("word_x = 0x%08x\n", (uint32_t)word1);
    
    printf("------------------------------\n");

    teste_lb();
    
    return 0;
}
