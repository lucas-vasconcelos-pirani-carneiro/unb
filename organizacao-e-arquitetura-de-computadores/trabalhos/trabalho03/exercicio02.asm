# Questão 02. Desenvolver um código que lê da console dois strings, concatena eles e imprime o string resultante na saída. 
# Terminar o programa com a chamada de exit. Lembre que o syscall que lê strings da entrada inclui automaticamente um new line (\n) ao final, 
# que deve ser removido para a concatenação.
# Exemplo:
# Brasilia
#  DF
# Brasilia DF

.data
	str1:  .space 100
	str2:  .space 50
	nl:	.word 10

.text 
	lw t1, nl # t1 == '\n'
	
	li a7, 8  
	la a0, str1 # a0: Endereço do buffer de entrada
	li a1, 50 # a1: Número máximo de caracteres a ler
	ecall 
	mv s1, a0 # s1: &str1[i]
	
	li a7, 8  
	la a0, str2 # a0: Endereço do buffer de entrada
	li a1, 50 # a1: Número máximo de caracteres a ler
	ecall 	
	mv s2, a0 # s2: &str2[i]
			
loop:
	lb t0, 0(s1) # t0 = str1[i]
	beq t0, t1, concat # str1[i] == '\n'
	addi s1, s1, 1
	j loop
	
concat:
	lb t0, 0(s2) # t0 = str2[i]
	beq t0, t1, fim_programa # str2[i] == '\n'
	sb t0, 0(s1) # str2[i] = t0
	
	addi s2, s2, 1
	addi s1, s1, 1 
	j concat

fim_programa:
	#addi s1, s1, 1 
	sb zero, 0(s1) # str1[i] = 0

	# Imprimir a String
	la a0, str1
	li a7, 4
	ecall
	
	# Encerrar o programa
	li a7, 10 
	ecall
