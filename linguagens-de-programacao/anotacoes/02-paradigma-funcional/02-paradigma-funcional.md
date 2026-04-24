# Paradigma Funcional - Linguagem Hugs
- Programar em uma LP exige pensar com os **significados** das suas **construções**.
- Cada **paradigma** (visão) tem construções que lhe são peculiares:
  - **Procedural** (ou imperativo): Solução <u>algorítmica</u> (passo a passo).
  - **Funcional:** Declara a solução como <u>valores a retornar</u>.
    - Usa extensivo de recursão.
  - **Relacional** (ou lógico): Declara a solução como <u>relação</u> entre <u>entidades</u> do discurso.
  - **Orientado a objetos:** Descreve o problema em <u>termos do próprio problema</u>, ao invés de descrevê-lo em termos de um algoritmo que o computador vai rodar.

### Linguagens Declarativas

- Realizam o processamento **simbólico**. 
- Processam **listas** (ES).
- Bloco básico de construção: **funções**.
- Declaram o problema fazendo sua **especificação** (não
  resolvendo <u>passo a passo</u>).
- Implementam funções complexas e metas programas.
- Tratam **símbolos** e **operações** da **lógica matemática** com
  relativa facilidade.

## Introdução à Linguagem Hugs98

- **Referência:** Hugs98 User Manual
  **Autores:**
  - Mark P. Jones
  - John C. Peterson
- https://www.haskell.org/hugs/

### Ambiente Hugs

- É um interpretador com o ciclo que lê, avalia e exibe resultados.
- **Funções primitivas:** Lidas do `Prelude`.
  - Se a função está no preludio ela pode executa-la.

- **Funções globais:** São visíveis, ocupam espaços na memória.
- **Funções locais:** Não permanecem na memória, são usadas e descartadas.
- As funções são definidas pelo usuário:
    - Usando expressões `let` ou `where`
  - Carregadas de um **arquivo de texto**.

- **Ordem de execução** são as chamadas das <u>funções</u>.
- `=` : Sinal de **reescrita** o que tiver ao lado direito será **substituindo** pelo o que está no lado esquerdo, reduzindo a complexidade.
- As funções sem nome são chamadas de **Lambda**.

- Interpretador:

![interpretador-hugs](img/02-hugs/interpretador-hugs.png)

### Comandos do Prelude (Hugs)

| Comando               | Descrição                                                |
| --------------------- | -------------------------------------------------------- |
| `:?`                  | Exibe a lista de comandos disponíveis                    |
| `:type <expr>`        | Mostra o tipo de uma expressão                           |
| `:load <filenames>`   | Carrega módulos/arquivos especificados                   |
| `:also <filenames>`   | Carrega arquivos adicionais sem remover os já carregados |
| `:reload`             | Recarrega o último conjunto de arquivos                  |
| `:project <filename>` | Usa um arquivo de projeto                                |
| `:edit <filename>`    | Abre um arquivo para edição                              |
| `:edit`               | Edita o último módulo utilizado                          |
| `:browse <modules>`   | Lista nomes definidos em um módulo                       |
| `:find <name>`        | Abre o arquivo contendo a definição do nome              |
| `:names [pat]`        | Lista nomes atualmente no escopo                         |
| `:info <names>`       | Mostra informações sobre nomes                           |
| `:module <module>`    | Define o módulo para avaliação de expressões             |
| `<expr>`              | Avalia uma expressão                                     |
| `:set <options>`      | Define opções da linha de comando                        |
| `:set`                | Mostra opções atuais                                     |
| `:! <command>`        | Executa comando do sistema (shell)                       |
| `:cd <dir>`           | Muda o diretório atual                                   |
| `:gc`                 | Força coleta de lixo                                     |
| `:version`            | Mostra a versão do Hugs                                  |
| `:quit`               | Sai do interpretador                                     |

### Comparação - MDC

- **Funcional:**
  - **Verificação dinâmica:** Não é explicitado o tipo da variável.
  - `=`: Sinal de reescrita. 
  - O que separa os argumentos são os **espaços em branco**.
  - Letra **minúscula**: Variável.
  - Letra **maiúscula**: Constante.
  - \` ` : Transforma uma função em operador.

```hugs
mdc a 0 = a
mdc a b = mdc b (a ´mod´ b)
```

- Como funciona a execução:
  1. Casamento de padrões (pattern matching).
     - Ele tenta casar os argumentos com as definições **de cima para baixo**.
  2.  **Reescrita** (reescreve expressões)
     - O `=` **não é atribuição**, é uma **regra de transformação**.

    - Exemplo:
    ```hugs
    mdc 250 50
    mdc 50 (250 mod 50)
    mdc 50 0
    50
    ```

    1. Tenta casar com: `mdc a 0 = a`
        - Não casa, porque 50 != 0
    2. Vai para a próxima regra: `mdc a b = mdc b (a `mod` b)`
        - Substitui: a = 250, b = 50
        - `mdc 50 (250 `mod` 50)`
    3. Calcula: 250 `mod` 50 = 0
        - Então vira: `mdc 50 0`
    4. Aplica agora a primeira regra: mdc a 0 = a
        - `50`

> [!IMPORTANT]
>
> - Hugs funciona como matemática: `f x = x + 1`, "Sempre que eu vir `f x`, posso trocar por `x + 1`".

- **Imperativo:**

```
function mdc(a,b:integer):integer
    var t:integer;
	begin
		while b<> 0 do begin
        	t := b; b:=a mod b; a:= t;
		end;
		mdc :=a ;
	end;
```

- **Lógico:**

```prolog
mdc(A,0,A).
mdc(A,B,X) :-
BB is A mod B, mdc(B,	BB, X).
```

### Expressões `let` e `where`

- `let <definição> in <expressão>`.
- `let` $\{ d_1, d_2, \ldots, d_n  \}$  `in` expressão.

```hugs
Prelude> let soma a b = a + b in soma 12 15
27 :: Integer
```

- `<expressão> where <definição>`. 
- expressão `where` $\{ d_1, d_2, \ldots, d_n  \}$

```hugs
Prelude> fat 5 where fat n = product [1..n] - Produtório '..'
120 :: Integer
```

- **Avaliação preguiçosa**: Avaliação só é feita se necessária.
- **Cabeça** da lista: **primeiro** elemento da lista.
- Infere automaticamente que a lista é de inteiro.

### Re-escrita

- Permite transformar (re-escrever) termos em outros.
- É a base do processo de **avaliação** de expressões.
- **Programas funcionais** são executados usando a <u>redução</u> ou <u>re-escrita</u> de termos.

- Exemplo: 
```hugs
append [ ] ys = ys
append (x:xs) ys = x:append xs ys
append [1,3,5] [4,6] = 1:append [3,5] [4,6]
    = 1:3:append [5] [4,6]
    = 1:3:5:append [ ] [4,6]
    = 1:3:5:[4,6]
    = [1,3,5,4,6]
```
- `:` Operador de composição de lista;
- `x`: é a cabeça da lista;
- `xs`: corpo da lista;
- A cada passo a cabeça da lista é consumida, concatenando os elementos.
- É uma função recursiva.
- A lista é homogênea, uniforme.

## Função e Operadores

- São estruturas da LF que aplicadas a **parâmetros** e **operandos** retornam valores.
- **Funções** são em geral <u>prefixadas</u>, <u>associativas à esquerda</u> e com <u>prioridade máxima (10)</u>.

```hugs
f a b = (f a) b
```

- **Operadores** são em geral <u>infixados</u> e podem ter suas prioridades e <u>associatividades declaradas</u>.

```hugs
x^y^2 = x^(y^2), mas
x+y+2 = (x+y)+2
```

### Funções

- Tem nomes com **letras** e **dígitos**, começando com letra.
- São **prefixadas**: `fatorial n = product [1..n]`

```hugs
mdc a b
    | b == 0 = a
    | otherwise = mdc b (a `mod` b)
```

> [!NOTE]
>
> - Uma **função** pode ser tratada de forma **infixada** se for envolvida por **apóstrofes** .

#### Função Lambda
- É uma função **anônima**, sem nome.
- é definida como: `(\args -> corpo)`
- Exemplo: `(\x y -> x^2 + y^2)`

```hugs
Prelude> (\x -> x^2) 3
9 :: Integer

Prelude> map (\x ->x^2) [1,2,3,4]
[1,4,9,16] :: [Integer]
```

> [!NOTE]
>
> - Quando usar funções Lambda ?

#### Funções com Guardas

- Uma função é definida como:
```hugs
eq_1    mdc a 0 = a
eq_2    mdc a b = mdc b (mod a b)
...     fat 0 = 1
eq_n    fat (n+1) = (n+1) * fat n
```

- Onde cada equação tem uma das formas:
    - `f p1 p2 ... pk | <guarda> = expressão`;
    -  `f p1 p2 ... pk = expressão`;

```hugs
mdc a b
    | b == 0 = a
    | otherwise = mdc b (a `mod` b)
```

### Expressões Case

- Uma expressão case tem a forma geral: `case <exp> of { p1 match_1 ; ... ; pn match_n }`.

```hugs
merge xs ys = case (xs,ys) of
(z:zs, w:ws) | z <= w -> z:merge zs ys
             | z>w -> w:merge xs ws
([],ws)-> ys
(zs,[])-> xs

Main> merge [1,3..9] [2,4..10]
[1,2,3,4,5,6,7,8,9,10] :: [Integer]
```

```hugs
fat n = case n of
    0 -> 1
    1 -> 1
    (k+1) -> (k+1) * fat k
if e1 then e2 else e3
    = case e1 of { True -> e2 ; False -> e3 }
```
- e2 e e3 podem ser `if` também!

```hugs
qsort ls =
    case ls of
        [] -> []
        [x] -> [x]
        otherwise -> qsort ys ++ [x] ++ qsort zs
    where
        (x:xs) = ls
        ys = [y | y <- xs, y < x]
        zs = [z | z <- xs, z >= x]

Main> qsort [8,5,7,3,4]
[3,4,5,7,8] :: [Integer]
```

```hugs
pega n ys = case (n,ys) of
    (0,_) -> []
    (_,[]) -> []
    (n,x:xs) -> x : pega (n-1) xs

Main> pega 3 [8,5,7,3,4]
[8,5,7] :: [Integer]

Main> pega 7 [8,5,7,3,4]
[8,5,7,3,4] :: [Integer]
```

### Operadores
- **Operador** tem nome formado por <u>símbolo especial</u> (não letras ou dígito) e é <u>infixado</u>:

```hugs
Prelude> map (\x ->x^2) [1,2,3,4]
[1,4,9,16] :: [Integer]

Prelude> 5 == 9
False :: Bool

Prelude> [1,2,3] ++ [5,6] ou (++) [1,2,3] [5,6]
[1,2,3,5,6] :: [Integer]
```

- Operadores são definidos de forma similar a funções:

```hugs
[] \/ ys = ys
(x:xs) \/ ys | membro x ys = xs \/ ys

-- Função Membro             | otherwise = x: xs \/ ys
membro z [] = False
membro z (w:ws) = z == w || membro z ws
-- Vai consumindo a cabeça da lista até um momento que ela fica vazia
```

- Funções e operadores podem fazer uso de **definições locais** com `let` ou `where`.

```hugs
xs \/ ys | xs == [] = ys
         | membro x ys = resto
         | otherwise = x:resto where (x:t) = xs; resto = t \/ ys
-- t: Cauda de xs
-- x: Cabeça de xs
```

> [!IMPORTANT]
>
> - `\/` é a união de listas.

- A definição de um operador leva em conta:
    - Prioridade;
    - Associatividade;
    - Comportamemto;

- **Prioridade:**
```txt
2 * 3 + 4 = (2*3) + 4 = 10 ?
          = 2 * (3 + 4) = 14 ?
```

- **Associatividade:**
```   
1 - 2 - 3 = (1 - 2) - 3 = -4 ?
          = 1-(2-3) = 2

x $\oplus$ y $\oplus$ z = (x $\oplus$ y) $\oplus$ z -- à esquerda infixl
                        = x $\oplus$ (y $\oplus$ z) -- à direita infixr
                        = erro! - não associado. infix
```

## Tipos e Entrada/Saída

### Booleano

```hugs
(&&), (||) :: Bool (Argumento) -> Bool -> Bool 
-- &&, ||: Assinatura da função
-- () é função pré-fixada

True && x = x
False && _ = False  -- Representa uma variável anônima

True || _ = True
False || x = x

not :: Bool -> Bool
not True = False
not False = True

otherwise :: Bool
otherwise = True
```

- Hugs implementa curto circuito.
- Chacagem Estática: Declara o tipo, é imutávael.
- Checagem Dinâmica: Não há a declaração.

### Char

- É uma **enumeração** e consiste de valores de `16 bits`, conforme o padrão unicode.
- É representado pelo caractere entre **aspas simples**: 'a', 'b', 'A', '0', '1', ..., '9', etc.
- Cada um dos **caracteres de controle** `ASCII` tem mais de uma representação possível:

| Sequência | Nome (abreviação)        | Descrição                         |
|----------|--------------------------|-----------------------------------|
| \7, \a   | BEL (Bell)               | Emite um alerta sonoro (beep)     |
| \b, \BS  | BS (Backspace)           | Move o cursor uma posição atrás   |
| \f, \FF  | FF (Form Feed)           | Avança para a próxima página      |
| \r, \CR  | CR (Carriage Return)     | Retorna o cursor ao início da linha |
| \t, \HT  | HT (Horizontal Tab)      | Avança para a próxima tabulação   |
| \v, \VT  | VT (Vertical Tab)        | Avança verticalmente (linha abaixo com tabulação) |
| \n, \LF  | LF (Line Feed)           | Avança para a próxima linha       |

- Funções de Conversão: `chr` e `ord`:  Disponível após `"import Data.Char"` ou `:| Data.Char"`.

    ```hugs
    chr :: Int -> Char
    ord :: Char -> Int
    ```
- `Integer`: Inteiro para software.
- `Int`: Inteiro para hardware.

### String

- É uma **lista de caracteres**.
    - `type String = [Char]`, é um tipo **sinônimo**.
- Strings podem ser abreviadas envolvendo os caracteres por aspas.
    - `" string"` abrevia a notação `[' ', 's', 't', 'r', 'i', 'n', 'g']`.
- **Todas** as operações para <u>lista</u> se aplicam a <u>strings</u>.

#### Strings e I/O

- String são **objetos visíveis**: Podem ser lidos ou impressos.

```hugs
Prelude> let { leia = do putStr "informe uma string >"; str <- getLine; putStr str}
-- Imprime na tela o que foi digitado
-- in leia: executa a função
in leia informe uma string > lah vai a string, pega!
lah vai a string, pega! :: IO ()

Prelude> putStr "Isto eh uma string"
Isto eh uma string :: IO ()
```

- Qualquer objeto para ser impresso deve antes ser **convertido** em string.

```hugs
Prelude> putStr (show [1,2,3,4,5])
[1,2,3,4,5] :: IO ()

Prelude> read "[1,2,3,4]" :: [Int] -- Converte string em objeto
[1,2,3,4] :: [Int]

Prelude> show (23,5.4) -- Converte objeto em string
"(23,5.4)" :: [Char]

Prelude> read "[('a','b',4.5),('c','d',6.0)]" :: [(Char,Char,Float)]
[('a','b',4.5),('c','d',6.0)] :: [(Char,Char,Float)]
```

- <u>Tuplas</u> diferentemente das <u>listas</u> **não** precisam ser **homogêneas**!!

### Numéricos

- `Int` e `Integer`
    - `Int` tem valores **limitados**, aritmética por hardware.
    - `Integer` tem valores **ilimitado**, aritmética por software.

- **Operadores** para inteiros:
    - `+`, `-`, `*`, `/`, `^` 
    - `negate`, `div`, `rem`, `mod`, `odd`, `even`, `abs`, etc.

- Funções diversas existem no prelude para inteiros.
- `Float`
- `Complex`

### Listas
- É um **tipo algébrico** de dois construtores: `[]`, terminador, e `:`, operador de composição de listas.
- Há muitas funções no `Prelude` para manipular listas.

```hugs
[ ] -- Lista vazia ou nula
[3] == 3:[] -- Lista com 1 elemento
[1,2,3,4,5] == 1:2:3:4:5:[] -- Lista com 5 elementos numéricos

Prelude> [1,3..15]
[1,3,5,7,9,11,13,15] :: [Integer]

Prelude> ['a'..'z']
"abcdefghijklmnopqrstuvwxyz" :: [Char]

Prelude> [0.1,0.3 .. 2.0]
[0.1,0.3,0.5,0.7,0.9,1.1,1.3,1.5,1.7,1.9] :: [Double] -- Soma de 0.2 em 0.2

Prelude> length [1..10]
10 :: Int
```

- É um conjunto **ordenado** e **homogêneo** de elementos com **repetição permitida**.
- Se `t` é um tipo, então `[t]` é uma lista de **elementos do tipo** `t`.

#### Operadores e Funções sobre listas

```hugs
-- length: Retorna o tamanho da lista.
length [1..1000] -- 1000

-- ++: Concatena, usada como operador.
[1,3..10]++[2,4..8]  -- [1,3,5,7,9,2,4,6,8]

-- : Composição/"Junção" de lista.
[1,2]:[2,3]:[] -- [[1,2],[2,3]], lista da lista por causa da composição

-- filter: Aplica uma regra, se retorna TRUE retorna o elemento, se for FALSE despreza o elemento.
filter even [1..10]  -- [2, 4, 6, 8, 10]

-- concat: Concatena os elementos, retornando uma string.
concat [['1'],['2'],['3']," abc"," efg"] -- "123 abc efg"

-- head: Pega o elemento que está na cabeça da lista.
-- tail: Retorna a lista sem o elemento da sua cabeça.
head (tail [1,5..200]) -- 5

-- drop: Despreva os primeiros n elementos de uma lista e retorna a mesma sem eles.
-- take: Pega os primeiros n elementos de uma lista.
drop 2 (take 4 ["jan","fev","mar","abr","mai","jun"]) -- "mar", "abr"
-- Lista de strings, lista da lista de char.

-- last: Retorna o último elemento da lista.
-- reverse: Inverte a lista.
last (reverse [1,10..200]) -- 1

-- replicate: Repete-se os elementos.
replicate 5 'a' -- "aaaaa" 
replicate 3 "a" -- ["a", "a", "a"] 

-- elem: Saber se o elemento está na lista.
elem 13 [1,3..20] -- True

-- zip: Faz um Par Ordenado, tupla, com os elementos, (1º Elem, 1º Elem), ... (Nº Elem, Nº Elem); ainda esão dentro de uma lista.
-- Vai até a lista mais curta parar.
[1,3..10] [0,2..15] -- [(1,0),(3,2),(5,4),(7,6),(9,8)]

-- unzip: Separar os pares ordenado.
unzip (zip [1,3..10] [0,2..15]) -- ([1,3,5,7,9],[0,2,4,6,8])

-- and: Aplica a operação lógica and.
-- map: Aplica o função (even) recursivamente.
and (map even [1,2,3,4]) -- False 

-- or: Aplica a operação lógica or.
or (map even [1,2,3,4]) -- True

-- foldl: Aplica a função acumulativamente da esquerda para a direita:
-- foldl (+) valor_inicial lista
foldl (+) 2 [-2..2] -- 2
foldl (-) 2 [-2..2] -- 2 

-- foldl1: Usa o primeiro elemento como acumulador inicial.
foldl1 (+) [-2..2] -- 0
foldl1 (-) [-2..2] -- 4

-- foldr: Envelopa da direita para esquerda.
foldr (-) 2 [-2..2] -- -2
foldr1 (-) [-2..2] -- 0
```

#### Exemplos de Fold

```hugs
foldl (op) arg0 [a,b,c] = ((arg0 op a) op b) op c
foldl1 (op) [a,b,c] = (a op b) op c
foldr (op) arg0 [a,b,c] = a op (b op (arg0 op c))
foldr1 (op) [a,b,c] = a op (b op c)
```

- Exemplo: foldl
```txt
= ((((2 - (-2)) - (-1)) - 0) - 1) - 2
= (((4 - (-1)) - 0) - 1) - 2
= ((5 - 0) - 1) - 2
= (5 - 1) - 2
= 4 - 2
= 2
```

### Tuplas

- É uma estrutura do tipo **registro**.
- Uma **relação** fixa de campos de tipos quaisquer.
- Se $t_1, t_2, \ldots t_n$ são tipos, então o tipo da n-tupla é $(t_1, t_2, \ldots, t_n)$.

```hugs
(("Nome", "Leda"), "mulher", "casada", ("idade", 62))
(5, [1,2,3], "Brasília")
```

### Entrada/Saída

```hugs
entrada = do  putStr "\n dados> "
             dados <- getLine
             putStr “Digitado: "
             putStr (concat [dados, "\n"])
             putStr "continua, (s/n)?"
             carac <- getChar
             if carac=='S' || carac=='s' then entrada
             else return ()
Main> entrada
dados> -- primeira
Digitado: primeira
continua, (s/n)? -- s
dados> Segunda
Digitado: Segunda
continua, (s/n)? T :: IO [Char]
```

```hugs
import Hugs.Char (ord, chr)
tecla = do putStr "\n Qual a tecla? > "
    carac <- getChar
    putStr (show (ord carac))
    if carac == '\ESC' then (return ())
        else tecla

Main> tecla
Qual a tecla? > a97
Qual a tecla? > b98
Qual a tecla? > B66
Qual a tecla? > 27 :: IO ()
```

- `chr: Int --> Int`.
- `ord: Char --> Int`.

## Paradigma Funcional
- Uma função é definida como um **conjunto de equações**.
- Cada equação é uma **regra de reescrita** (redução).

```hugs
filtro p (x:xs) -- p: É uma variável, instância com qualquer coisa, função predicativa
    | p x = x:filtro p xs  -- Se p é à aplicado x retorna true 
    | otherwise = filtro p xs 
filtro _ [] = []

Main> filtro even [1..50]
[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50] :: [Int]
```

- `_`: É variável anônima.
- A cada chamada ele tira um elemento.
- Quando chega na lista unitária `[50] == 50:[]`.
    - Ele para pois na última interação o `xs` fica com o final de lista `[]`.

-  Se inverter a ordem das condições vai ficar testanto se tem **lista vazia** (`[]`) toda hora, perdendo perfomace.

### Casamento de Padrões
- É o **processo de avaliar** um ou mais dos argumentos para determinar qual a **expressão** do **lado direito** que se aplica.
- É o processo de **identificar a regra de reescrita** que se **aplica**.
- **Reescrita (redução):** Substituir a expressão corrente pela expressão do lado direito,conforme os padrões casados com a instância de argumentos.

### Guardas
- Cada uma das equações na definição pode conter guardas.
- Uma **guarda** é uma **função predicativa** $\rightarrow$ **função lógica**.
- Se a guarda for **verdadeira**, a expressão correspondente na função é **executada**.

```hugs
fat n | n == 0 || n == 1 = 1
      | n > 1 = n * fat (n-1)

Main> fat 5
120 :: Integer
```

- Se `n` for negativo vai dar erro.

### Recursão
- É a única **estrutura de controle** entre comandos em uma linguagem funcional pura.
- O **controle de sequência** intra-comando, em expressões, é definido
pelas **prioridades** e **associatividades** das funções e operadores.
- É o processo da função **chamar a si mesma**, <u>direta</u> ou <u>indiretamente</u>.

```hugs
fat 0 = 1
fat 1 = 1
fat n = n * fat (n - 1) -- e se n < 0 ?
```

- Se `n < 0` também ocorrerá um erro.
- Como foi colocado 0 e 1 ele entende a assinatura da função, ou seja, já infere que os parâmetros da funções são inteiros.
    - Nesse caso, já infere que os **parêmetros** são inteiros e a **saída** são do tipo **inteiro**.

## Polimorfismo
- Tipos polimórficos descrevem **famílias** de diferentes tipos.
- `[a]` **família de listas** para diferentes instâncias de tipos:
- É uma função que os tipos dos parâmentro podem variar
    - A função tem o mesmo nome, os tipos de paramentros mudam e "diferem" as funções.

```hugs
a = Int, lista de inteiro [Int]
a = Char, lista de caracteres [Char]
a = [Float], lista de lista de float [[Float]]
```

- `a`: É uma **variável de tipo**.
    - É mais geral que as instâncias de tipos `Int`, `Char`, `[Float]`, etc.

### Funções Polimórficas
- Uma função que se aplica a **qualquer tipo de parâmetro** é uma função polimórfica.

```hugs
size (x:xs) = 1 + size xs -- Vai somando 1 + 1 + 1 até a lista ficar vazia
size [] = 0

Main> size [1,3,15]
3 :: Integer

Main> size ['a'..'z']
26 :: Integer
```

```hugs
somamenor m xs
    | length xs <= 0 = [] 
    | z < m = (x,y,z):somamenor m (y:t) -- Corta o primeiro fazendo a composição do segundo elemento com a cauda
    | otherwise = somamenor m (y:t) where (x:y:t) = xs; z = x+y

-- Execução
-- (1,2,3):(2,3,5):(3,4,7):(4,5,9):[]

Main> somamenor 10 [1,2,3,4,5,6,7,8,9]
[(1,2,3),(2,3,5),(3,4,7),(4,5,9)]

Main> somamenor 10 [1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5]
[(1.5,2.5,4.0),(2.5,3.5,6.0),(3.5,4.5,8.0)]
```

- `(x:y:t)` é `xs` que é o segundo elemento.
    - `x`: Primeiro elemento
    - `y`: Segundo elemento
    - `t`: Cauda

- `z`: **Soma** dos primeiros elementos da lista.
- Vai tirando o primeiro elemento até que a soma dos primeiros seja menor ou igual ao último elemento e no final faz a composição com a lista vazia `[]`.

## Avaliação Preguiçosa
- Uma expressão só é avaliada quando seu valor é requerido.
- Uma **expressão cotizada**, aparecendo em vários lugares, é avaliada **uma única vez**.

```hugs
zero x = 0

Main> zero 10
0 :: Integer

Main> zero (1/0)
0 :: Integer

Main> zero $! (1/0) -- Força avaliação argumento mas não funcionou!
Program execution error: {primDivDouble 1.0 0.0}
```

### Avaliação Preguiçosa: qd x = x*x

- Passagem de parâmetro por **referência**, os endereços:
```hugs
qd(qd (qd 2)) = (qd (qd 2)) * (qd (qd 2))
                = (qd 2) * (qd 2) * (qd (qd 2))
                = 2 * 2 * (qd 2) * (qd (qd 2))
                = 4 * (qd 2) * (qd (qd 2)) -- Já está a operação, não ocorre a expansão
                = 4 * 4 * (qd (qd 2))
                = 16 * (qd (qd 2))
                = 16 * 16 = 256
```

- Passagem de parâmetro por **valor**:
```hugs
qd(qd(qd 2)) = qd(qd (2*2)) = qd(qd(4)) = qd(4*4)
= qd(16) = 16*16
```

- Ambas apresentam esforço próximo a 3 multiplicações.

### Objetos Infinitos

- Graças a avaliação preguiçosa é possível lidar com **lista infinitas**.

```hugs
Main> let naturais n = take n [0..] in naturais 8 -- n fica com 8
[0,1,2,3,4,5,6,7] :: [Integer]

Main> let impar n = take n [1,3..] in impar 10 -- n fica 
[1,3,5,7,9,11,13,15,17,19] :: [Integer]
```

- Vai expandindo um por um até chegar no 8.

#### Avaliação Preguiçosa e Objetos Infinitos

```hugs
fiblst = 1:1:[ x+y | (x,y) <- (zip fiblst (tail fiblst))] 

Main> take 10 fiblst
[1,1,2,3,5,8,13,21,34,55] :: [Integer]
```

- Faz um `zip` o primeiro e o último elemento da lista e a soma deles vai para a cauda.
    - Pega o primeiro com o segundo, depois o segundo o terceiro, ...

- Se o parâmetro for negativo retorna uma lista vazia `[]`.

| i | fiblst               | anterior           | tail            | pares (x, y)                          |
|---|----------------------|--------------------|-----------------|---------------------------------------|
| 1 | [1]                  | []                 | não utilizada   | —                                     |
| 2 | [1,1]                | [1]                | —               | a partir daqui calcule (x, y)          |
| 3 | [1,1,2]              | [1,1]              | [1]             | (1,1)                                 |
| 4 | [1,1,2,3]            | [1,1,2]            | [1,2]           | (1,1), (1,2)                          |
| 5 | [1,1,2,3,5]          | [1,1,2,3]          | [1,2,3]         | (1,1), (1,2), (2,3)                   |
| 6 | [1,1,2,3,5,8]        | [1,1,2,3,5]        | [1,2,3,5]       | (1,1), (1,2), (2,3), (3,5)            |

```hugs
primes = filterPrime [2..] 
    where filterPrime (p:xs) =
    p : filterPrime [x | x <- xs, x `mod` p /= 0] -- Função `mod` já é nativa.

Main> take 10 primes
[2,3,5,7,11,13,17,19,23,29] :: [Integer]
```

## Funções de Ordem alta
- São funções que manuseiam outras funções
    - Composição de funções.
    - Passadas como parâmetros.
    - Resultado da chamada de função.
    - Aplicação parcialmente aos seus argumentos.
    - Usadas em estrutura de dados.

### Composição de Funções

```hugs
f . g x = f (g x)
var xs = (sum . map (^2)) xs / n - (sum xs / n)^2
    where n = length xs

Main> var [1.0,1.5..5.0]
1.66667 :: Double

Main> ((^3) . (/2)) 10
125.0 :: Double

Main> (sum . take 10) [1..]
55 :: Integer

-- 1:uns -> Gera uma lista de uns, [1,1,1,...] e soma os 20 primeiros elementos.
Main> let uns = 1:uns in (sum . take 20) uns
20 :: Integer

Main> take 20 uns where uns = 1:uns
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] :: [Integer]

-- | Se for n == 1 --> [1]
-- simula o take, expande até o n - 1
Main> let uns n | n==1 = [1] | n/=1 = 1:uns (n-1) in (sum.uns) 30
30
```

### Funções como Parâmetros
- `p`: tem que ser uma **função predicativa**, retorna true ou false.
- \` \`: Transforma uma função em um operador.

```hugs
par x = x `mod` 2 == 0

filtro p (x:xs)
    | p x = x:filtro p xs
    | otherwise = filtro p xs
filtro _ [] = [] 

Main> filtro par [1..21]
[2,4,6,8,10,12,14,16,18,20] :: [Integer]

Main> filtro odd [1..20]
[1,3,5,7,9,11,13,15,17,19] :: [Integer]

Main> map par [1..10]
[False,True,False,True,False,True,False,True,False,True] :: [Bool]

-- 0 + (1 + (2 + (3 + ... )))
Main> foldr (+) 0 [1..10]  
55 :: Integer
```

### Função como Resultado

```hugs
somat = foldl (+) 0  somat :: [Integer] -> Integer
produt = foldl (*) 1 produt :: [Integer] -> Integer
append = foldr (++) [] append :: [[a]] -> [a]
quadlista = map (^2) quadlista :: [Integer] -> [Integer]

Main> somat [1..10]
55 :: Integer

Main> produt [1..10]
3628800 :: Integer

Main> append [[1,2], [3,4],[5,6,7],[8,9,10] ]
[1,2,3,4,5,6,7,8,9,10] :: [Integer]

Main> quadlista [1,3,5,7,9]
[1,9,25,49,81] :: [Integer]
```

#### Aplicação Parcial

```hugs
Main> suc 4 where suc = (+1)
5 :: Integer

Main> somatorio [1..10] where somatorio = foldr (+) 0
55 :: Integer

Main> olah "Joao"
where olah = ("Oi " ++) . (++ " como vai voce?")
"Oi Joao como vai voce?" :: [Char]

Main> soma 3 5 where soma = (+)
8 :: Integer
```

### Funções em Estrutura de dados

```hugs
Main> let operacao (f, x, y) = f x y in operacao ((+), 4, 6)
10 :: Integer

Main> let operacao (f, x, y) = f x y
    in map operacao [((+),4,6),((*),3,4)]
[10,12] :: [Integer]
```

### Map
- Uma lista aplicada a função x tal que x faz parte xs.

```hugs
map f xs = [f x | x <- xs]

-- O par ordenado (x,y) vem do zip de xs e ys
map2 f xs ys = [f x y | (x,y) <- zip xs ys]
```

## `runhugs.exe`: interpretador para scripts Hugs

- Runhugs file [argumentos...]
```exe
runhugs echo.hs a b c
The arguments are:
a
b
c
The program name is:
echo.hs
```

- Programa `echo.hs`
```hugs
import System.Environment
import Data.List
main = do
    args <- getArgs
    progName <- getProgName
    putStrLn "The arguments are:"
    mapM putStrLn args
    putStrLn "The program name is:"
    putStrLn progName
```
