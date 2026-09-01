.data

rsp:  .space 30
size: .word 30

.text
	# Para ler uma string precisamos colocar em a0 e a1: 
	# a0: Endereço do buffer de entrada 
	# a1: Número máximo de caracteres a ler
	
	la s1, rsp
	mv a0, s1
	
	la t0, size
	lw t1, 0(t0) 
	mv a1, t1
	
	li a7, 8 # Ler uma string
	ecall
	
	li s2, 'a'
	li s3, 'z'
	
	Loop:
		lb t0, 0(s1)
		beq t0, zero, Exit # Verifica se chegou ao fim da string
		
		bge t0, s2, A
		
		addi s1, s1, 1
		j Loop 	

	A:
		ble t0, s3, Minuscula
		
		addi s1, s1, 1
		j Loop
	
	Minuscula:
		addi t0, t0, -32 # Transforma para maiuscula
		sb t0, 0(s1)
		
		addi s1, s1, 1
		j Loop		 
			
	Exit: 
		li a7, 4 # Imprimir uma string
		ecall
		  
		li a7, 10 # Termina a execução do programa
		ecall
	