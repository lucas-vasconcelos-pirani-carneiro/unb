######################## Cabeçalho da resposta - não alterar ###################
.data 
str:	.space 32
nl:	.word 10

.text
	li a7, 8
	la a0, str
	li a1, 30
	ecall
	
	lw  a1, nl
	jal limpa # Cria um novo endereço de retorno
	
	li a7, 4
	la a0, str
	ecall
	
	li a7, 10
	ecall
	
######################## Escreva a função limpa a seguir #######################	
limpa:
	addi sp, sp, -4
	sw ra, 0(sp)

Loop:
	lb t0, 0(a0) # t0 = str[i]
	beq t0, a1, L1 # t0 == '\n'
	
	addi a0, a0, 1 # i++
	j Loop # Não cria um novo endereço retorno
	
L1:
	sb zero, 0(a0) # str[i] = 0
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
	