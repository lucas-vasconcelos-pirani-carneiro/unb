# Exercícios 01 - Rars

### Questão 01
Leia um inteiro do teclado e escreva-o na console. Termine o programa com a chamada do sistema.

**Obs:** Consultar o "Help" do RARS, aba Syscalls, para ver como realizar as chamadas do sistema para implementar as funções solicitadas.

**Solução:**
- Utilizamos `a7 = 5` para realizar a leitura de um inteiro. Após `ecall`, o valor digitado é armazenado em `a0`.
- Em seguida, utilizamos `a7 = 1` para imprimir o inteiro que está em `a0`.
- Por fim, utilizamos `a7 = 10` e `ecall` para encerrar o programa.

```asm
.text
	li a7, 5 # Lê um inteiro do teclado e coloca em a0 
	ecall 
	 
	li a7, 1 # Imprime na tela um inteiro que está em a0
	ecall
	
	li a7, 10 # Termina o programa com a chamada do sistema.
	ecall
```

### Questão 02
Leia dois inteiros do teclado e escreva o resultado da sua soma na console. 

Termine o programa com a chamada do sistema.

**Solução:**
- O primeiro inteiro é lido com `a7 = 5` e armazenado em `a0`.
- Como uma nova leitura também utilizará `a0`, movemos o primeiro valor para `t0`.
- Realizamos a segunda leitura, que coloca o segundo inteiro em `a0`.
- Utilizamos add para somar `a0` com `t0`. O resultado fica em `a0`.
- Utilizamos `a7 = 1` para imprimir o resultado e `a7 = 10` para encerrar o programa.

```asm
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
```

### Questão 03
Ler uma sequência de inteiros do teclado, somá-los e imprimir o resultado. 

O primeiro número lido indica o número de inteiros que devem ser lidos e somados.

Termine o programa com a chamada do sistema.

**Solução:**
- Utilizamos `t0` para armazenar o contador `i` e `t1` para armazenar a quantidade de números que devem ser lidos `n`.
- Utilizamos `s1` para armazenar a soma e o inicializamos com `0`.
- Primeiro, lemos `n` e armazenamos seu valor em `t1`.
- No início do loop, utilizamos bge para verificar se `i >= n`. Caso seja verdadeiro, o programa vai para `Exit`.
- Caso contrário, lemos um novo inteiro, adicionamos seu valor à soma armazenada em `s1` e incrementamos `i`.
- Quando todos os números forem lidos, movemos a soma para `a0` e utilizamos `a7 = 1` para imprimi-la.

```asm
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
    li a7, 1 # Imprimir um nímero inteiro
    ecall
    
    li a7, 10 # Terminar o programa
    ecall

# Solução Proposta
.text
	li a7, 5
	ecall
	mv t0, a0
	add s0, zero, zero
lass:
	ble t0, zero, fim
	ecall
	add s0, s0, a0
	addi t0, t0, -1
	j lass
fim:
	mv a0, s0
	li a7, 1
	ecall
	li a7, 10
	ecall
```


### Questão 04
Ler um inteiro do teclado e determinar se é um número par ou ímpar.

Imprimir na tela "Eh par" ou "Eh impar" em resposta. 

Termine o programa com a chamada do sistema.

**Solução:**
- Um número par possui o último bit igual a `0`, enquanto um número ímpar possui o último bit igual a `1`.
- Para verificar apenas o último bit, utilizamos um **mascaramento com 1**, através da instrução `andi`.
- A instrução `andi t0, a0, 1` realiza `a0 AND 000...0001`.
- Se o resultado for `0`, o número é **par**. Se for `1`, o número é **ímpar**.
- Utilizamos `bne` para verificar se o resultado é **diferente de zero** e, nesse caso, desviar para `Impar`.
- Para imprimir uma string, utilizamos `a7 = 4`, colocando em `a0` o **endereço da string**.

```asm
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

# Solução Proposta
.data
ehpar: 	 .string "Eh par"
ehimpar: .string "Eh impar"

.text
	li a7, 5
	ecall
	andi a0, a0, 1
	beqz a0, par
	la a0, ehimpar
	j fim
par:	
	la a0, ehpar
fim:
	li a7, 4
	ecall
	li a7, 10
	ecall
```

### Questão 05

Transformar os caracteres minúsculos de uma frase em maiúsculos.

Procedimento:

1. Ler uma frase do teclado (chamada do sistema). Não usar caracteres especiais ou acentuados e restringir-se a um máximo de 30 caracteres.
2. Percorrer a frase e transformar as letras minúsculas em maiúsculas.
    - Não altera letras maiúsculas, dígitos ou caracteres especiais.
3. Imprimir a frase resultante na tela. 
Termine o programa com a chamada do sistema.

O objetivo é transformar as letras minúsculas de uma string em letras maiúsculas.

- A string é armazenada em um espaço de memória.
- `s1` funciona como um ponteiro para a posição atual da string.
- `lb` lê um byte da memória.
- É necessário verificar se o caractere está entre `'a'` e `'z'`.
- Em ASCII, a diferença entre uma letra minúscula e sua correspondente maiúscula é `32`.
- Portanto, podemos fazer:

```text
caractere - 32
```

- Depois de alterar o caractere, usamos `sb` para armazená-lo novamente na memória.
- O processamento termina quando encontramos o byte `0`, que representa o final da string.


```asm
.data

rsp:  .space 30
size: .word 30

.text

# Seu código abaixo:
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

# Solução Proposta
.data
rsp:  .space 30
size: .word 30

.text
	
	li a7, 8
	la a0, rsp
	la a1, size
	lw a1, 0(a1)
	ecall
	
	la s0, rsp	
Loop:	
	lbu s1, 0(s0)
	beq s1, zero, fim
	mv a0, s1
	jal eh_min
	addi s0, s0, 1
	beq a0, zero, Loop
	addi s1, s1, -32
	sb s1, -1(s0)
	j Loop
	
fim:	
	li a7, 4
	la a0, rsp
	ecall
	li a7, 10
	ecall
	
eh_min:
	slti t0, a0, 123
	li   t1, 96
	slt  t1, t1, a0
	and  a0, t0, t1
	ret
```

### Questão 06
Ler um inteiro do teclado e imprimir o número de bits em 1 em sua representação binária. 

Encerrar o programa com a chamada do sistema.

Para contar quantos bits `1` existem na representação binária de um número, foi utilizado o algoritmo de Brian Kernighan.

A ideia principal é:

```text
n = n & (n - 1)
```

Essa operação remove exatamente um bit `1` do número.

Portanto:

- Inicializamos um contador em `0`.
- Enquanto `n` for diferente de `0`:
  - Calculamos `n - 1`.
  - Fazemos `n & (n - 1)`.
  - Incrementamos o contador.
- Quando `n` chega a `0`, o contador contém a quantidade de bits `1`.

```asm
.text
    li a7, 5 # Ler um inteiro
    ecall
    
    li s1, 0 # i = 0
    mv t0, a0 # t0 <-- a0
    
    beq t0, zero, Exit
    
    Loop:
        addi t1, t0, -1
        and t0, t0, t1
        
        addi s1, s1, 1
        
        beq, t0, zero, Exit
        
        j Loop
    
    Exit:
        mv a0, s1 # a0 <-- t0
        li a7, 1 # Imprimir um inteiro
        ecall 
        
        li a7, 10 # Terminar o programa
        ecall

# Solução Proposta
.text

	li a7, 5
	ecall
	
	li  t0, 1
	add t1, zero, zero
	li  t2, 32 
loop:
	blez t2, fim
	addi t2, t2, -1
	and  a1, a0, t0
	srli a0, a0, 1
	add  t1, t1, a1
	j loop
fim:
	li a7, 1
	mv a0, t1
	ecall
	
	li a7, 10
	ecall
```

### Questão 07
Leia 3 inteiros do teclado, por ordem, a, b e c. Calcule e imprima o resultado da expressão: `a + b*c`

Termine o programa com a chamada do sistema.

A expressão que deve ser calculada é:

```text
a + b * c
```

- Ler `a` e guardar em `t0`.
- Ler `b` e guardar em `t1`.
- Ler `c` e guardar em `t2`.
- Multiplicar `b * c`.
- Somar o resultado com `a`.
- Colocar o resultado em `a0` e imprimir.

É importante lembrar que cada leitura precisa de uma syscall `ReadInt` seguida de `ecall`.

```asm
.text
	li a7, 5
	ecall 
	 
	mv t0, a0 # t0 = a
	
	li a7, 5 
	ecall
	
	mv t1, a0 # t1 = b
	
	li a7, 5
	ecall
	 
	mv t2, a0 # t2 = c 
	
	mul t1, t1, t2
	add a0, t0, t1
	
	li a7, 1
	ecall 
	
	li a7, 10
	ecall

# Solução Proposta 
.text
	li a7, 5
	ecall
	mv t0, a0  # a
	ecall
	mv t1, a0  # b
	ecall
	mv t2, a0  # c
	mul t2, t1, t2
	add t0, t0, t2
	mv a0, t0
	li a7, 1
	ecall
	li a7, 10
	ecall
```

### Questão 08
Ao ler um string do teclado com a chamada de sistema a7 = 8, a função retorna o string com o caracter nova linha ('\n') ao final. 

Faça uma função que recebe o endereço em memória de um string em a0 e substitui o caracter '\n' por zero, indicando o fim do string.

Escreva apenas a função. A entrada e saída é feita no cabeçalho da resposta.

Parâmetros da função:
- a0 : endereço do primeiro caracter do string
- a1 : código do caracter nova linha ('\n')


O objetivo é criar uma função que percorra uma string e substitua o caractere de quebra de linha (`'\n'`) por `0`, transformando-o no terminador da string.

A função recebe:

- `a0` → endereço da string.
- `a1` → código do caractere que deve ser procurado.

O código ASCII de `'\n'` é `10`.

Durante a função:

- `lb` lê um caractere da string.
- Se o caractere for igual a `a1`, encontramos o `'\n'`.
- `sb zero, 0(a0)` substitui o `'\n'` por `0`.
- Caso contrário, avançamos o ponteiro em 1 byte e continuamos procurando.

#### Uso da pilha

Como estamos utilizando uma função chamada com `jal`, o endereço de retorno fica armazenado em `ra`.

A função salva esse endereço na pilha:

```asm
addi sp, sp, -4
sw ra, 0(sp)
```

No final, o endereço é recuperado:

```asm
lw ra, 0(sp)
addi sp, sp, 4
ret
```

Dessa forma, a função consegue retornar corretamente para o ponto em que foi chamada.

```asm
.data 
str:	.space 32
nl:	    .word 10

.text
	li a7, 8
	la a0, str
	li a1, 30
	ecall
	
	lw  a1, nl
	jal limpa
	
	li a7, 4
	la a0, str
	ecall
	
	li a7, 10
	ecall
	
limpa:
	addi sp, sp, -4
	sw ra, 0(sp)

Loop:
	lb t0, 0(a0)
	beq t0, a1, L1
    
	addi a0, a0, 1
	j Loop
	
L1:
	sb zero, 0(a0) # str[i] = 0
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret

# Solução Proposta
.data 
str:	.space 32
nl:	    .word 10

.text
	li a7, 8
	la a0, str
	li a1, 32
	ecall
	
	lw  a1, nl
	jal limpa
	
	li a7, 4
	la a0, str
	ecall
	
	li a7, 10
	ecall
	
limpa:
	lbu t1, 0(a0)
	beqz t1, fim
	bne t1, a1 segue
	sb zero, 0(a0)

segue:
	addi a0, a0, 1
	j limpa

fim:
	ret
```
