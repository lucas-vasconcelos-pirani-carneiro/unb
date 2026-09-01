.text
	li a7, 5 # Ler um inteiro
	ecall
	
	# Truque de de Brian Kernighan
	# Pegue o número e subtraia 1 dele próprio.
	# Faça uma operação E lógico (AND) entre o número atual e o resultado da subtração (n & (n - 1)).
	# Repita o processo até o número zerar, contando quantas vezes o ciclo rodou.
	
	li s1, 0 # i = 0
	mv t0, a0
	
	beq t0, zero, Exit
	
	Loop:
		addi t1, t0, -1
		and t0, t0, t1
		
		addi s1, s1, 1
		
		beq t0, zero, Exit	
		j Loop
		
	Exit:
		mv a0, s1
		li a7, 1 # Imprimir um inteiro
		ecall
		
		li a7, 10 # Encerrar o programa
		ecall
		