.text
	li a7, 5
	ecall
	
	li s1, 0
	li s2, 32
	
loop:
	blez s2, exit
	
	andi t0, a0, 1  # Marcaramento para testar um bit
	add s1, t0, s1
	
	srai a0, a0, 1
	
	addi s2, s2, -1
	j loop
	
exit:
	mv a0, s1
	
	li a7, 1
	ecall
		
	li a7, 10
	ecall
