.data
ehpar: 	 .string "Eh par"
ehimpar: .string "Eh impar"

.text
	li a7, 5 # Ler um inteiro do teclado n 
	ecall
	
	andi t0, a0, 1 # Faz o mascaramento usando ...000001, t0 = 0: Par, t0 = 1: Impar
	
	bne t0, zero, Impar
	
	la t1, ehpar
	mv a0, t1
	
	li a7, 4 # Imprimir a string
	ecall 
	
	li a7, 10 # Terminar o programa
	ecall
	
	Impar:
		la t1, ehimpar
		mv a0, t1
	
		li a7, 4 # Imprimir a string
		ecall 
		
		li a7, 10 # Terminar o programa	
		ecall
