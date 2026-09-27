# Questão 03. Uma aproximação do valor da hipotenusa de um triângulo retângulo pode ser obtida pela expressão:
# hipo(a,b) = max((0,875x + 0,5y), x), onde x = max(a, b) e y = min(a, b) e a e b são inteiros positivos.
# Implemente as funções max e min, que recebem como parâmetro dois inteiros em a0 e a1 e retornam o respectivo resultado em a0.
# Implemente  um código que lê dois catetos do teclado (números inteiros) e calcula a expressão hipo(a, b) no assembly do RV.
# Imprima o resultado na tela e encerre o programa com a chamada do sistema. 
# Dicas: as operações fracionárias devem ser implementadas com instruções de deslocamento (shift) e subtração. 

.text
	li a7, 5
	ecall
	mv a1, a0
	
	li a7, 5
	ecall	
	
	# a1: a, a0: b
	
	jal hipo
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall

hipo:
	addi sp, sp, -4
	sw ra, 0(sp) # Endereço de retorno de jal hipo
	
	mv t0, a0 # t0 = a0 (parâmetro)
	
	jal min
	mv s1, a0 # s1 = y = min(a,b)

	mv a0, t0 # a0 = t0 (parâmetro)
	jal max
	mv s2, a0 # s2 = x = max(a,b)

	srli t1, s1, 1 # t1 = 0,5y
	
	srli t2, s2, 3 # t2 = x/8
	sub t2, s2, t2 # t2 = x - x/8 = 7x/8 = 0,875x
	
	add a0, t1, t2 # a0 = 0,875x + 0,5y 
	mv a1, s2
	
	jal max
	
	lw ra, 0(sp)
	addi sp, sp, 4

	ret

max:
	bge a0, a1, max_ret
	mv a0, a1
	ret
	
max_ret:
	ret

min:
	bleu a0, a1, min_ret 
	mv a0, a1
	ret 

min_ret:
	ret

