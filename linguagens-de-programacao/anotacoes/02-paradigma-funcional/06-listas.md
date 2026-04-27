# Listas
- É a **estrutura de dados** fundamental da linguagem `Haskell`.

> **Lista:** É uma coleção de elementos de um certo tipo que podem ser definidas pela enumeração de seus elementos.

- **Declaração:** Colocar o **tipo da lista entre colchetes**.
    - [Int] : Lista de inteiros
    - [Char]: Lista de Caracteres.
- Nelas, os elementos são definidos colocando-os entre colchetes, **separados por vírgulas**.

- É um **tipo algébrico** de dois construtores: `[]`, terminador, e `:`, operador de **composição de listas**.
- Há muitas funções para manipular listas.
- É um conjunto **ordenado** e **homogêneo** de elementos com **repetição permitida**.
- Se `t` é um tipo, então `[t]` é uma lista de **elementos do tipo** `t`.


```haskell
-- Exemplos
lista_num = [1,2,3,4,5] -- Lista de números inteiros.
lista_vazia = [] -- Lista vazia ou nula, não contém nenhum elemento.
lista_char ['a', 'b', 'c', 'd'] -- Lista de Caracteres (String - "abcd")
```

- Além das inicializações simples, também podemos definir:
- **Lista de lista**: "Matrizes"

```haskell
listals = [[1,2], [3,4], [5,6]] -- [[Int]]
```

- Em `Haskell` as listas podem ser **preenchidas automaticamente**, através do reconhecimento de um padrão:
```haskell
ls1 = [1..10] -- [1,2,3,4,5,6,7,8,9,10]
ls2 = [1,3,..10] -- [1,3,5,7,9]
ls3 = [10,8..0] -- [10,8,6,4,2,0]

-- Execução
ghci> ls1 = [1..10]
ghci> ls2 = [1,3..10]
ghci> ls3 = [10,8..0]
ghci> ls1
[1,2,3,4,5,6,7,8,9,10]
ghci> ls2
[1,3,5,7,9]
ghci> ls3
[10,8,6,4,2,0]
ghci> [1,3..15]
[1,3,5,7,9,11,13,15] 
ghci> ['a'..'z']
"abcdefghijklmnopqrstuvwxyz"
ghci> [0.1,0.3 .. 2.0]
[0.1,0.3,0.5,0.7,0.9,1.1,1.3,1.5,1.7,1.9] -- Soma de 0.2 em 0.2
ghci> length [1..10]
10
```

> [!NOTE]
>
> A lista de números é definida pela convenção familiar das reticências (..) para omitir elementos intermediários apenas quando o **padrão é óbvio**.

- Como dito anteriormente a função básica para **construir** uma lista em `Haskell` é o **operador interfizado** `":"`, que toma **um elemento** e **uma lista** (que pode estar vazia) como seus argumentos.

```haskell
ghci> 8:[]
[8]
ghci> 6:8:[]
[6,8]
ghci> 4:[6,8]
[4,6,8]
[3] == 3:[] -- Lista com 1 elemento
[1,2,3,4,5] == 1:2:3:4:5:[] -- Lista com 5 elementos numéricos
```

- Além disso, uma lista em `Haskell` tem duas partes: `head` e `tail`.
    - **head/cabeça:** Primeiro elemento da lista.
    - **tail/cauda:** A lista sem o `head`.

```haskell
ghci> pares = [0,2..8]
ghci> head pares
0
ghci> tail pares
[2,4,6,8]
```

- Outro operador útil com relação a lista é o `++`, cuja função é **concatenar** duas listas pelas extremidades delas.

```haskell
ghci> [1,2,3] ++ [4,5,6]
[1,2,3,4,5,6]
ghci> pares = [0,2..8]
ghci> impares = [1,3..9]
ghci> pares ++ impares
[0,2,4,6,8,1,3,5,7,9]
```

- Tomando-se por base o operador de construção `:`, a lista `[1,2,3]` pode ser escrita como `1:[2,3]`, onde `1 :: Int` é a **cabeça** da lista (head) e a lista `[2,3] :: Int` é a sua **cauda** (tail).
- Toda lista é **vazia** ou é uma lista com **cabeça seguida de cauda**.

> [!NOTE]
> 
> - Se a lista tiver **um elemento** a cabeça vai ser o primeiro elemento e a cauda vai ser uma lista vazia.

```haskell
ghci> lista = [1]
ghci> head lista
1
ghci> tail lista
[]
```

### Exemplo - Comprimento

```haskell
-- Comprimento de uma Lista
comp :: [Int] -> Int
comp [] = 0 -- Caso base 
comp (head:tail) = 1 + comp tail

-- Execução
ghci> lista = [1..20]
ghci> comp lista
20
ghci> lista = [2,4..100]
ghci> comp lista
50
```

> - Existem algumas outras funções que podem ser aplicadas a lista, como `null`, que verifica se ela é **vazia**, ou `length`, que retorna seu **comprimento**.

- Comprimento com **Guardas**.
```haskell
compGuardas :: [Int] -> Int
compGuardas lista
    | null lista = 0 -- lista == [] = 0
    | otherwise   = 1 + compGuardas (tail lista)
```

### Exemplo - Append
```haskell
-- Função append
append :: [Int] -> [Int] -> [Int]
append [] ys = ys
append xs [] = xs
append (x:xs) ys = x:append xs ys

-- Execução
ghci> append [1,2,3] [4,5,6]
[1,2,3,4,5,6]
ghci> append [] [4,5,6]
[4,5,6]
ghci> append [1,2,3] []
[1,2,3]

{-
append [1,3,5] [4,6] = 1:append [3,5] [4,6]
    = 1:3:append [5] [4,6]
    = 1:3:5:append [ ] [4,6]
    = 1:3:5:[4,6]
    = [1,3,5,4,6]
-}
```

### Exemplo - Elementos ao Cubo
- O programa abaixo recebe uma lista e devolve outra, que contém os valores da primeira elevados ao cubo.

```haskell
cubo :: Int -> Int
cubo n = n^3

aoCubo :: [Int] -> [Int]
aoCubo [] = []
aoCubo (head:tail) = cubo(head) : aoCubo tail

-- Execução 
ghci> lista = [1..9]
ghci> aoCubo lista
[1,8,27,64,125,216,343,512,729]
```

## Operadores e Funções sobre Listas

```haskell
-- length: retorna o tamanho da lista
ghci> length [1..1000]
1000

-- ++: concatena listas
ghci> [1,3..10] ++ [2,4..8]
[1,3,5,7,9,2,4,6,8]

-- : (cons): adiciona um elemento no início da lista
ghci> 1 : [2,3]
[1,2,3]
ghci> [1,2] : [[2,3]]
[[1,2],[2,3]]

-- filter: filtra elementos com base em uma condição
ghci> filter even [1..10]
[2,4,6,8,10]

-- concat: concatena uma lista de listas
ghci> concat [['1'],['2'],['3']," abc"," efg"]
"123 abc efg"

-- head: Pega o elemento que está na cabeça da lista. 
-- tail: Retorna a lista sem o elemento da sua cabeça.
ghci> head (tail [1,5..200])
5

-- drop: Retira os primeiros n elementos de uma lista e retorna a mesma sem eles. 
-- take: Pega os primeiros n elementos de uma lista.
ghci> drop 2 (take 4 ["jan","fev","mar","abr","mai","jun"])
["mar","abr"]

-- last: Retorna o último elemento da lista. 
-- reverse: Inverte a lista.
ghci> last (reverse [1,10..200])
1

-- replicate: Repete-se os elementos.
ghci> replicate 5 'a'
"aaaaa"
ghci> replicate 3 "a" -- ["a","a","a"]
["a","a","a"]

-- elem: Verifica se um elemento está na lista, retorna True or False.
ghci> elem 13 [1,3..20]
True

-- zip: Faz um Par Ordenado, tupla, com os elementos, (1º Elem, 1º Elem), ... (Nº Elem, Nº Elem); ainda esão dentro de uma lista.
-- Vai até a lista mais curta parar.
ghci> zip [1,3..10] [0,2..15]
[(1,0),(3,2),(5,4),(7,6),(9,8)]

-- unzip: Separar os pares ordenado em duas listas.
ghci> unzip (zip [1,3..10] [0,2..15])
([1,3,5,7,9],[0,2,4,6,8])

-- and: Aplica a operação lógica and. 
-- map: Aplica o função (even) recursivamente.
-- or: Aplica a operação lógica or.
ghci> and (map even [1,2,3,4])
False
ghci> or (map even [1,2,3,4])
True

-- foldl (esquerda -> direita)
ghci> foldl (+) 2 [-2..2]
2
ghci> foldl (-) 2 [-2..2]
2

-- foldl1 (sem valor inicial)
ghci> foldl1 (+) [-2..2]
0
ghci> foldl1 (-) [-2..2]
-4

-- foldr (esquerda <- direita)
ghci> foldr (-) 2 [-2..2]
-2
ghci> foldr1 (-) [-2..2]
0
```

#### Exemplos de Fold

- Como o foldr e foldl realizam as operações:
```txt
foldl op z [a,b,c] = ((z `op` a) `op` b) `op` c
foldl1 op [a,b,c] = (a `op` b) `op` c

foldr op z [a,b,c] = a `op` (b `op` (c `op` z))
foldr1 op [a,b,c] = a `op` (b `op` c)
```

```haskell
foldl (-) 2 [-2,-1,0,1,2]

{-
= ((((2 - (-2)) - (-1)) - 0) - 1) - 2
= (((4 - (-1)) - 0) - 1) - 2
= ((5 - 0) - 1) - 2
= (5 - 1) - 2
= 4 - 2
= 2
-}

foldl1 (-) [-2,-1,0,1,2]

{-
= ((((-2 - (-1)) - 0) - 1) - 2)
= (((-1 - 0) - 1) - 2)
= ((-1 - 1) - 2)
= (-2 - 2)
= -4
-}

foldr (-) 2 [-2,-1,0,1,2]

{-
= -2 - (-1 - (0 - (1 - (2 - 2))))
= -2 - (-1 - (0 - (1 - 0)))
= -2 - (-1 - (0 - 1))
= -2 - (-1 - (-1))
= -2 - (0)
= -2
-}

foldr1 (-) [-2,-1,0,1,2]

{-
= -2 - (-1 - (0 - (1 - 2)))
= -2 - (-1 - (0 - (-1)))
= -2 - (-1 - 1)
= -2 - (-2)
= 0
-}
```

## Lista por Compreensão
- Uma lista pode ser definida por um "gerador":
```haskell
ghci> pares = [2*x | x <- [0..10]]
ghci> pares
[0,2,4,6,8,10,12,14,16,18,20]
```

- Essa estrutura indica que será criada uma lista a partir de x, que é uma lista de elementos entre 0 e 10, onde cada elemento é o **dobro** de cada elemento x.
- Uma extensão de lista pode ser definida se um "gerador" for utilizado, e a lista pode ser **infinita**.

```haskell
ghci> allpares = [2*x | x <- [0,1..]]
ghci> allpares
[0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40, -- Continua ...
```

- Isso é possível devido ao fato do `Haskell` ser uma linguagem com **"avaliação lenta"**, o que quer dizer que **nenhum argumento** para uma função é **avaliado** até que seja <u>absolutamente necessário</u>.

### Exemplo - Usando Condições

```haskell
[x | x <- [1..n], mod n x == 0] -- Retorna os divisores de n
```
- Nesse exemplo, temos que é criado:
    - Uma lista com os elementos de x, onde
    - x é uma **lista de elementos** que vai de 1 até n,
    - e o **resto da divisão** de n por x é igual a zero.

```haskell
ghci> [x | x <- [1..10], mod 10 x == 0]
[1,2,5,10]
ghci> [x | x <- [1..10], 10 `mod` x == 0]
[1,2,5,10]
```

## Exercícios
1. Escreva uma função em `Haskell` que calcule a somatória dos elementos de uma lista de inteiros

```haskell
somaLista :: [Int] -> Int
somaLista [] = 0
somaLista (head:tail) = head + somaLista tail

-- Execução
ghci> somaLista [1,2,3,4]
10
ghci> somaLista [1,2,3,4,75]
85
ghci> somaLista [1..75]
2850
```

2. Escreva uma função em `Haskell` que verifique se uma String **possui o caractere** informado, passado como parâmetro.

```haskell
-- Exercício 02: Busca pelo Caractere 
buscaChar :: String -> Char -> Bool
buscaChar s c
    | null s = False
    | head s == c = True
    | otherwise = buscaChar (tail s) c 

--  Opção 2
buscaChar1 :: [Char] -> Char -> Bool
buscaChar1 [] ch = False
buscaChar1 (head:tail) ch 
    | head == ch = True 
    | otherwise = buscaChar1 tail ch

-- Execução
ghci> buscaChar1 "joao" 'a'
True
ghci> buscaChar1 "joao" 'p'
False
ghci> buscaChar1 "manhattan" 't'
True
ghci> buscaChar1 "manhattan" 'r'
False
```

3. Escreva uma função em `Haskell` que busque pelo **maior número** em uma lista.

```haskell
-- Exercício 3: Busca maior número
buscaMaior :: [Int] -> Int
buscaMaior [] = -1
buscaMaior (head:tail) 
    | head >= maior_cauda = head 
    | otherwise = maior_cauda
    where 
        maior_cauda = buscaMaior tail

-- Execução
ghci> buscaMaior [52, 10, 68, 37, 9, 21]
68
ghci> buscaMaior [520, 10, 68, 37, 9, 21]
520
ghci> buscaMaior [1]
1
ghci> buscaMaior []
-1
```

4. Faça uma função em `Haskell` que retorna as raízes reais distintas de uma equação do segundo grau na forma de uma **lista**.

$$
ax^2 + bx + c = 0, { onde } \delta = b^2 - 4ac
$$

> [!NOTE] 
>
> Se o discriminante for igual a 0, há apenas uma raíz real, caso seja positivo, há duas raízes reais distintas e, se for negativo, não raízes reais para a equação.

> [!TIP]
>
> **Utilize guardas e definições locais.**

```haskell
raizes :: Float -> Float -> Float -> [Float] 
raizes a b c 
    | delta < 0  = []
    | delta == 0 = [(-b) / (2*a)]  -- (-b)/(2*a) : []
    | otherwise  = [ ((-b) + sqrt delta) / (2*a) , ((-b) - sqrt delta) / (2*a)]
  where
    delta = b^2 - 4*a*c

-- Execução
ghci> raizes 1 (-5) 6
[3.0,2.0]
ghci> raizes 1 (-4) 4
[2.0]
ghci> raizes 1 (-4) 400
[]
```

5. Escreva uma função em `Haskell` que retorne os **10 primeiros elementos multiplos de n**. Utilize geradores de lista.

```haskell
multiplos :: Int -> [Int]
multiplos n = [n * x | x <- [1..10]]

-- Execução
ghci> multiplos 7
[7,14,21,28,35,42,49,56,63,70]
ghci> multiplos 9
[9,18,27,36,45,54,63,72,81,90]
ghci> multiplos 124
[124,248,372,496,620,744,868,992,1116,1240]
```

6. Escreva uma função em `Haskell` que verifique se um determinado número é **primo**. Utilize geradores de lista.

```haskell
isPrimo :: Int -> Bool
isPrimo n
    | length [x | x <- [1..n], mod n x == 0] == 2 = True
    | otherwise = False

-- Execução
ghci> isPrimo 19
True
ghci> isPrimo 20
False
ghci> isPrimo 200
False
ghci> isPrimo 191
True
```

## Quicksort
- Para ilustrar o poder da técnica de **compreensão de lista**, vamos implementar o algoritmo de **ordenação** de listas/vetores **"Quicksort"**.
- O método é **rápido** e **eficiente**, conhecido como um dos melhotes algoritmos para essa finalidade.

### Passos do Algoritmo
1. **Escolhe** um elemento do vetor, conhecido como **pivô**;
2. **Particionar o vetor** de maneira que todos os elementos anteriores ao pivô sejam menores que ele, e todos os elementos posteriores sejam maiores.
3. **Ordena recursivamente** os vetores de elementos menores e maiores.

- A **base da recursão** são os vetores de tamanho 0 ou 1, que já se encontram ordenados.
- A cada passo do algoritmo, pelo menos um elemento é colocado em sua posição definitiva, e não será mais manipulado no passo seguinte.

```haskell
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (h:t) = quicksort [y | y <- t, y < h] -- menores que o pivô
                            : [h] -- o próprio pivô
                            : [y | y <- t, y >= h] -- Maiiores que o pivô
-- Execução
ghci> quicksort [10, 2, 6, 8, 5, 7, 15, 25, 18, 3]
[2,6,8,5,7,3,10,15,25,18]
```

