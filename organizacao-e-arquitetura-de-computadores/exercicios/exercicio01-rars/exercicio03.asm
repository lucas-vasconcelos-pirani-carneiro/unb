.text
	li t0, 0 # i = 0	
	
	li a7, 5 # n: número de inteiros que devem ser lidos e somados. 
	ecall
	
	mv t1, a0 # t0 <-- a0 (n)
	
	Loop: 
		bge t0, t1, Exit # t0 (i) > t1 (n)
		
		li a7, 5 # Lê um inteiro 
		ecall
		
		add s1, s1, a0 # Soma dos números lidos
		addi t0, t0, 1 # i++
		
		jal Loop # Volta para o loop
	
	Exit:
		mv a0, s1 # a0 <-- s1
		li a7, 1 # Imprimir um número inteiro
		ecall
		
		li a7, 10 # Terminar o programa
		ecall
		