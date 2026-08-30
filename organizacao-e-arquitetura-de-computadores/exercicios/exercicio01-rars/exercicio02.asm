.text
	li a7, 5 # Lê um inteiro e coloca-lo em a0
	ecall
	
	mv t0, a0 # t0 <-- a0
	
	li a7, 5 # Lê um inteiro e coloca-lo em a0
	ecall
		
	add a0, a0, t0 
	
	li a7, 1 # Imprimir um inteiro que está em a0
	ecall
	
	li a7, 10 # Termina a execução do programa
	ecall
	