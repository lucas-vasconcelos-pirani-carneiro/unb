# Questão 01. Fazer uma função recursiva que percorre uma árvore binária, imprimindo os dados na ordem de percorrimento. 
# O caminhamento deve ser em profundidade.Os nós da árvore são representados por 3 palavras adjacentes na memória: 
# dado, ramo esquerdo, ramo direito. Dado é um inteiro. Os ramos são os endereços das subárvores à esquerda e à direita 
# do nó. Observe a descrição em assembly na caixa de resposta, ali está definida a árvore utilizando rótulos no RARS.
# O assembly inclui ainda uma macro para escrever o dado armazenado no nó da árvore apontado por a0, parâmetro utilizado 
# na recursão para percorrer a árvore. Além disso, as constantes ESQ e DIR são fornecidas para permitir a leitura dos 
# aponteiros para as ramificações à esquerda e direita, respectivamente.
# Acrescente a função recursiva stree abaixo do código fornecido na caixa de entrada.

# lw t0, ESQ(a0): Pega o endereço do filho da esquerda

.data
	no0:	0 no1 no2
	no1:	1 no3 no4
	no2:	2 0   no7
	no3:    3 no5 0
	no4:    4 0   no6
	no5:    5 0   0
	no6:    6 0   0
	no7:    7 no8 no9
	no8:    8 0   0
	no9:    9 0   0

.eqv	ESQ 4
.eqv	DIR 8

.macro proc
	mv a1, a0
	lw a0, 0(a1)
	li a7, 1
	ecall
	mv a0, a1
.end_macro 

.text
    	#li a7, 5
    	#ecall
	la a0, no0
	jal stree
	li a7, 10
	ecall
	
# inclui código de stree abaixo	
stree:
	beq a0, zero, caso_base # a0 == 0
	
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)

	proc # raiz
	
	# raiz.esq
	lw a0, ESQ(a0)
	jal stree 
	
	# Recupera o endereço da raiz do nó atual
	lw a0, 0(sp)
	
	# raiz.dir
	lw a0, DIR(a0)
	jal stree 

	lw ra, 4(sp)
	addi sp, sp, 8
	ret
	
caso_base:
	ret

