# Tradução

## Introdução
**Sintaxe** de uma LP é a <u>forma</u> de suas expressões, instruções e unidades de programa:
- Descreve a **sequência de símbolos** que tornam válido um programa,
- Em uma linguagem natural é o arranjo de palavras como elementos em uma sequência para mostrar o relacionamento entre elas.
- É o **conjunto de regras** que determinam quando uma **sentença é bem formada** (wff).
 
**Semântica** de uma LP é o <u>significado</u> de suas expressões, instruções e unidades de programa.

Quem deve usar as definições de uma LP:
- Outros projetistas de linguagens,
- Implementadores,
- Programadores (usuários da linguagem)

Definições Básicas:
- **Sentença:** <u>String de caracteres</u> sobre um alfabeto, `unicode`.
- **Linguagem:** conjunto de sentenças.
- **Lexema:** Unidade de <u>menor nível sintático</u> de uma linguagem. 
    - *, 
    - for, 
    - begin.
- **token:** Categoria de lexemas. 
    - Identificador.
- Símbolos (tokens) são **combinados** em sentenças para formar um programa.

### Regras sintáticas são suficientes? Não!

Anos 60: para projetar LP só era necessário uma sintaxe formal, tipo **BNF** (***Backus-Naur Form***).

```
<inteiro> ::= <sinal><digito> | <inteiro><digito>

::= significa é gerado por 
| siginifica ou
```

Em expressões **ambíguas**, as regras sintáticas **não** são suficientes para determinar as interpretações corretas:

- Associativa: 1 - 2 - 3  = -4 ou 2 = -4, `<digito> ::= 0|1|2|3|4|5|6|7|8|9`.
- Precedência: 2 + 3 * 4  = 20 ou 14 = 14
- Tipos: x = 2.45 + 3.67 = 
    - 5, se x e + são inteiros 
    - = 6, se x inteiro e + real  
    - = 6.12, se x e + são reais

**Declarações, sequência de controle, operações, ambiente de referência**, etc, são necessários.
- Inteiro é produzido por sinal seguido de dígito ou inteiro seguido de dígito

## Critérios gerais sintáticos
**Propósito principal** da sintaxe: Prover notação para comunicação entre o 
programador e o processador da linguagem.

**Propósitos secundários** da sintaxe:
- **Legibilidade:** ler e entender facilmente,
- **Capacidade de escrita:** facilitar a programação,
- **Facilidade de verificação:** facilitar o exame da exatidão do código,
- **Facilidade de tradução:** facilitar trabalho do tradutor,
- **Ausência** de ambiguidade.

### Legibilidade
Pela inspeção do programa, as estruturas dos algoritmos e dos dados **DEVEM** ficar aparentes, **sem necessitar consultar** documentação adicional:
- O facilita a legibilidade: Comandos estruturados palavras chaves, comentários, declarar dados, op.Mnemônicos, campo-livre, variedade de construções sintáticas.

#### Exemplo: Cobol (auto-documentado)
```cobol
IDENTIFICATION DIVISION. 
PROGRAM-ID. SUM-OF-PRICES. 
AUTHOR. T-PRATT.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
SOURCE-COMPUTER. SUN.
OBJECT-COMPUTER. SUN.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ARQ-ENTRADA ASSIGN TO INPUT.
    SELECT ARQ-SAIDA ASSIGN TO OUTPUT.

DATA DIVISION. 
FILE SECTION.
FD ARQ-ENTRADA  LABEL RECORD IS OMITTED. 
01 ITEM-PRECO.
    02  ITEM      PICTURE   X(30).
    02  PRECO  PIC             9999V99. 
FD ARQ-SAIDA. 

01 LINHA-IMPRESSORA  PIC X(80). 
WORKING-STORAGE  SECTION.
77 TOTAL            PIC 9999V99, VALUE 0, USAGE IS COMPUTATIONAL. 
77 CONTADOR   PIC  9999, VALUE 0, USAGE IS COMPUTATIONAL.                               

01 LINHA-TOTAL. 
    02 FILLER VALUE  'SOMA  = ' PIC X(12). 
    02 TOTAL-SOMA PIC   $$,$$$,$$9.99. 
    02 FILLER   PIC  X(15), VALUE  '  TOTAL DE ITENS   '.
    02 TOTAL-CONTADOR  PIC  ZZZ9. 

01 LINHA-SAIDA.
    02 CONTADOR  PIC  Z,ZZ9.
    02 ITEM               PIC X(30).
    02 FILLER           PIC X(05), VALUE SPACES.
    02 PRECO           PIC $,$$9.99.

PROCEDURE DIVISION.
INICIA.    
    OPEN INPUT ARQ-ENTRADA  AND OUTPUT ARQ-SAIDA. 
LEDADOS. 
    READ ARQ-ENTRADA AT END GO TO FINALIZA. 
    ADD PRECO  OF ITEM-PRECO TO  TOTAL. 
    ADD 1 TO  CONTADOR.
    MOVE CORRESPONDING  ITEM-PRECO      TO   LINHA-SAIDA.  
    MOVE CONTADOR             TO  CONTADOR  OF  LINHA-SAIDA. 
    WRITE LINHA-IMPRESSORA FROM LINHA-SAIDA.
    GO TO LEDADOS.
FINALIZA.
    MOVE   TOTAL  TO   TOTAL-SOMA.
    MOVE   CONTADOR TOTAL-CONTADOR. 
    WRITE  LINHA-IMPRESSORA FROM LINHA-TOTAL. 
    CLOSE  ARQ-ENTRADA  AND  ARQ-SAIDA. 
    STOP RUN.
```

#### Contra exemplo: programas Lisp ou Mumps
```lisp
; ARQ-ENTRADA COM ZERO OU MAIS REGISTROS (LISTA), CADA QUAL CONTENDO ITEM E PRECO.
; LE ARQ-ENTRADA E GRAVA SEUS REGISTROS NO ARQ-SAIDA, TOTALIZANDO OS VALORES.
; ULTIMO REG: TOTAL DE REGISTROS GRAVADOS E TOTAL DE VALORES ACUMULADOS

(DEFUN PROCEDIMENTO(ARQ-ENTRADA  ARQ-SAIDA)

( (PROBE-FILE ARQ-ENTRADA) 
    (OPEN-INPUT-FILE        ARQ-ENTRADA)
    (OPEN-OUTPUT-FILE   ARQ-SAIDA)
    (SETQ CONTADOR  0   TOTAL  0)
    (LOOP 
        (TERPRI)  ; MUDA DE LINHA
        ((NULL (SETQ ITEM-PRECO (READ)))  ; EOF
            (PRINT  (PACK*  “QTE DE ITENS =  " CONTADOR "     VALOR TOTAL = " TOTAL))
        )
        (INCQ CONTADOR 1)    ;  INCREMENTA CONTADOR ITENS LIDOS
        (INCQ TOTAL (NTH 1 ITEM-PRECO))  ; ADICIONA O VALOR DO ITEM AO TOTAL
        (PRINT (PACK* "ORDEM " CONTADOR  "   ITEM= " (CAR ITEM-PRECO)
        "    VALOR =  "  (CDR ITEM-PRECO)))  )
    (CLOSE-OUTPUT-FILE  ARQ-SAIDA)
    (CLOSE-INPUT-FILE  ARQ-ENTRADA) ) )
```

### Facilidade de escrever
**Características sintáticas** que facilitam escrever um programa:
- Enfatizar estruturas sintáticas **concisas** e **regulares**. 
    - `i++;`
    - `for (<exp1>; <exp2>; <exp3>) <comando>;`
- Convenções sintáticas **implícitas:**
    - **Declaração implícita** de inteiro (I-N ) e real em `Fortran`.
    - Regras de **associatividade** e **prioridade** de avaliação implícitas de operadores (+, -, /, *).
- Comandos estruturados, operadores mnemônicos, campo-livre, tamanho livre de identificadores, etc.

#### Exemplo: Fortran, C, C++ 
```fortran
    PROGRAM MAIN
C   DADO DUAS MATRIZES QUADRADAS A E B, OBTER  C = A + B
    PARAMETER (MAX=99)
    INTEGER T
    REAL  A (MAX,MAX), B (MAX,MAX), C (MAX,MAX)
10  WRITE(6, 100)  MAX
100 FORMAT(" ENTRE COM A DIMENSAO DAS MATRIZES. O MAXIMO EH = ", I5)
    READ (5, 200) T
200 FORMAT(I5)
    IF (T.LE.0.OR.T.GT.MAX) GO TO 500
    PRINT *, "ENTRE COM OS VALORES  DA  MATRIZ  A"
    READ *, (A(L,K) , L=1,T, K=1,T) 
    PRINT *, "ENTRE COM OS VALORES  DA  MATRIZ  B"
    READ *, (B(L,K),L=1,T, K=1,T)
    DO 400 K=1,T
        DO  300 L=1,T 
300         C(L,K) = A(L,K) + B(L,K)
400     CONTINUE                
    PRINT *,  (C(L,K), L=1,T,K=1,T) 
    GO TO 800
500 WRITE(6, 600) MAX
600 FORMAT( "DIMENSAO ERRADA. MENOR QUE ZERO OU MAIOR QUE ", I5)
    GO TO 10
800 STOP
    END
```

#### Contra exemplo: Pascal, Cobol
```pascal
Program somatrizes (input,output,infile);
const max=99;
type mat_real = array [1..max, 1..max] of real;
var infile: text; a,b,c: mat_real; l,k,t: integer;

begin
    writeln ('Entre com a dimensão das matrizes quadradas. Valor máximo é ‘, max:5);
    repeat readln (t);
        if (t <=0) or (t>max) 
        writeln ('valor da dimensão invalido');
    until (t >0) and (t < max); 
    
    writeln ('entre com o valores da matriz A, por linha');
    
    for l:=1 to t do { lê a matriz A}
        for k:=1 to t do  read (a[l,k]) ;  
    
    for l:=1 to t do         {lê a matriz B} 
        for k:=1 to t do
        begin read (b[l,k]) ;    
            c[l,k] := a[l,k]+b[l,k] 
        end;
    
    for l:=1 to k do 
        begin writeln;
            for k:=1 to k do  
                write (c[l,k]:10:2);
        end; 

end. { fim do programa}
```

### Facilidade de Verificação
As estruturas sintáticas da LP devem **facilitar o exame da exatidão** do código gerado:
- Envolve aspectos sintáticos e semânticos. 
- Entender automaticamente cada comando é fácil.
- O processo de criar um programa correto é extremamente difícil. 
- Há necessidade de técnicas para provar matematicamente a corretude de um programa.

**Exemplo:** Linguagens declarativas puras.  
**Contra exemplo:** Linguagens imperativas.

### Facilidade de tradução
A construção de tradutores é **facilitada** pela:
- **Regularidade** das estruturas sintáticas.
- **Pequena variedade** de estruturas.

**Exemplos:** `Lisp`, `Haskell`, `Hugs`, `ML` pela simplicidade de suas estruturas são ruins de ler e escrever mais fáceis de traduzir.

**Contra exemplos:** `Cobol`semântica simples, fácil de ler, ruim para escrever e difícil de traduzir devido a variedade de estruturas (comandos e declarações).


### Ausência de ambiguidade
Idealmente, cada construção sintática deve ter uma ((única interpretação)): 
- Nem sempre acontece nas LP, pois uma **estrutura ambígua** permite duas ou mais **interpretações diferentes**.

A interpretação de uma estrutura sintática isoladamente não traz problemas. 

A ambiguidade aparece quando são consideradas combinações entre as **diversas estruturas sintáticas** permitidas pelas regras da LP.

#### Exemplos
1. **Chamada de funções** e **referência a arrays** em `Fortran`: 
- A(I,J) é chamada de função ou referência ao elemento Aij do array A?

2. Aninhamento de if
- `if <bexp> then <comando1> else <comando2>` (ok)
- `if <bexp> then <comando1>` (ok)
- `if <be1> then if <be2> then <comando1> else comando2;`  (?) 
    - O else poderia ser do primeiro ou do segundo if não está claro

Algol: Uso de **begin** e **end**.

C e Pascal: Regra arbitrária: else se refere ao then mais próximo.

Ada: Uso de **endif**.

## Elementos Sintáticos

**Conjunto de caracteres:** Ao projetar a sintaxe de uma LP, a primeira escolha é o <u>conjunto de caracteres</u>. (**tendência é usar Unicode?**)

**Identificadores:** Uma <u>cadeia de letras e dígitos</u>, começando com uma letra, é largamente aceito.

**Símbolos de operadores:** Usual adotar uma combinação de <u>caracteres especiais</u> para alguns operadores e identificadores para outros.

**Palavra-chave:**
- **Identificador** usado como uma <u>parte fixa</u> de um comando. 
- **Palavra-reservada** **não** pode ser usada pelo programador. 
- Palavras opcionais (**noise**): <u>melhorar</u> a legibilidade.

**Comentários:** Texto inserido no programa com propósito de documenta-lo. 
- Linha de comentário (toda a linha), com campo fixo.
    - `Fortran`: C (na coluna 1) seguido do comentário.
- Delimitado por caracteres especiais (mais de uma linha).
    - `C`:  /* comentário sem limites de linhas */ 
    - `Pascal`:  (* comentário *) ou { comentário }
- Inicia em qualquer posição, indo até o final da linha.
    - `LISP`: ; seguido do comentário. 
    - `ADA`: - seguido do comentário.
    - `C++`: // seguido do comentário. 
    - `Fortran 90` ! seguido do comentário.

**Espaço em branco:** Tem papel <u>sintático</u> e é usado como separador, exceto se em uma string.

- `Cobol`: move       x to y  = move x to y
- `Pascal`:

```pascal
while b < c   do    b := b+1; 
st := `João e Maria` + `  `  +  `são casados`; 
```
    
- `Lisp`: (defun mdc(a b)(cond ((= b 0) a) (T (mdc b (mod a b))) ))

### Delimitador e agrupamento (brackets)
- Marca o **início** ou **fim** de **unidade sintática** comando, expressão, etc
- Aumentam a legibilidade, facilitam a análise sintática e removem ambigüidades.
- Chaveamento (***brackets***) são **pares de delimitadores**. 
    - (...), begin...end

### Sintaxe de campo fixo 
**Estritamente:** Cada elemento do comando precisa aparecer numa **dada posição** da linha de entrada.
- Versões antigas da linguagem `Assembler`, `JCL`, etc. 

**Parcialmente:** Alguns elementos do comando tem **posição fixa** outros são livres.
- `Fortran`, `Cobol`.

**Livre:** Os elementos do comando podem **começar em qualquer lugar da linha de entrada** e os elementos na sequência **podem ser separados por um ou mais espaços**. 
- `Algol`, `Pascal`, `C`, etc.

### Expressões
São funções que **acessam os objetos de dados** e retornam algum valor.

São os **blocos básico de construções** de comandos.

Em linguagens imperativas, em combinação com o comando de **atribuição**, permitem **alterar o estado da máquina**. 
- Ex: `A = cos(x)+y^2;`

Em linguagens **funcionais**, o **fluxo de controle** é feito pela avaliação de expressões, ou funções. 
- Em Lisp, um programa é uma **expressão simbólica**.

```lisp
(mapcar '(lambda(x) (* x x)) '(1 2 3 4 5 6 7 8))
```

### Comandos
É o principal elemento sintático das linguagens **imperativas**. 

As linguagens **funcionais puras não** possuem comandos; elas são **declarativas**. 

Os comandos podem ser simples ou compostos (estruturados ou aninhados).

A **sintaxe dos comandos** influi na ortogonalidade, legibilidade e facilidade de escrita de uma linguagem.

`Cobol` tem uma sintaxe de comandos prolixa, muito específica para cada tipo de comando.
