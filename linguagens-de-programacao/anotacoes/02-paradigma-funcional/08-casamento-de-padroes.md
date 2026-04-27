# Casamento de Padrões
- Em `Haskell`, assim como nas outras linguagens funcionais modernas, a noção de casamento de padrões é muito importante.
- É o **processo de avaliar** um ou mais dos argumentos para determinar qual a **expressão** do **lado direito** que se aplica.
- É o processo de **identificar a regra de reescrita** que se **aplica**.
- **Reescrita (redução):** Substituir a expressão corrente pela expressão do lado direito,conforme os padrões casados com a instância de argumentos.
- **Exemplo:**

```haskell
padroes :: Int -> String
padroes 1 = "Um!"
padroes 2 = "Dois!"
padroes 3 = "Tres!"
padroes x = "Nao esta entre 1 e 3!"

-- Execução
ghci> padroes 1
"Um!"
ghci> padroes 2
"Dois!"
ghci> padroes 3
"Tres!"
ghci> padroes 1000
"Nao esta entre 1 e 3!"
```

- Ao chamar a função, passando um parâmetro, a linguagem tenta definir em qual padrão ele se encaixa, **testando de cima para baixo** os padrões fornecidos pelo programador. 
- O primeiro a ser encontrado é executado com o valor passado como parâmetro.

- O que aconteceria se o programa fosse escrito dessa maneira ?
```haskell
padroes1  :: Int -> String
padroes1 x = "Nao esta entre 1 e 3!"
padroes1 1 = "Um!"
padroes1 2 = "Dois!"
padroes1 3 = "Tres!"
```

- Como os padrões são testados de cima para baixo e entra no primeiro que der ***match***, ele **sempre** vai entrar na <u>primeira condição</u> `padroes1 x = "Nao esta entre 1 e 3!"`, logo as demais são inúteis.

> [!NOTE]
>
> Inclusive ao tentar "compilar" o arquivo ele retorna esse erro.

```haskell
ghci> :reload
[1 of 2] Compiling Main             ( aula07.hs, interpreted ) [Source file changed]

aula07.hs:9:1: warning: [GHC-53633] [-Woverlapping-patterns]
    Pattern match is redundant
    In an equation for ‘padroes1’: padroes1 1 = ...
  |
9 | padroes1 1 = "Um!"
  | ^^^^^^^^^^^^^^^^^^

aula07.hs:10:1: warning: [GHC-53633] [-Woverlapping-patterns]
    Pattern match is redundant
    In an equation for ‘padroes1’: padroes1 2 = ...
   |
10 | padroes1 2 = "Dois!"
   | ^^^^^^^^^^^^^^^^^^^^

aula07.hs:11:1: warning: [GHC-53633] [-Woverlapping-patterns]
    Pattern match is redundant
    In an equation for ‘padroes1’: padroes1 3 = ...
   |
11 | padroes1 3 = "Tres!"
   | ^^^^^^^^^^^^^^^^^^^^
Ok, one module loaded.
```

- E se fosse dessa maneira ?
```haskell
padroes2 :: Int -> String
padroes2 1 = "Um!"
padroes2 2 = "Dois!"
padroes2 3 = "Tres!"
padroes2 _ = "Nao esta entre 1 e 3!"
```

- Tem o mesmo comportamento do primeiro caso, porém como o `x` não é **usado para nada** no lado direito podemos utilizar o `_` no lugar. 
    - É chamado de **padrão coringa**. 

### Exemplos 
1. Comprimento de uma lista.

```haskell
comp :: [Int] -> Int
comp [] = 0 -- Caso Base
comp (_:t) = 1 + comp t -- Caso Recursivo

-- Execução
ghci> compLista [x | x <- [1..100], mod x 2 == 0] -- Lista com números pares de 1 a 100
50
```

2. Verifica se o quarto elemento da tupla é maior que 10, não importando os valores dos outros elementos.

```haskell
type Tupla4 = (Int, Int, Int, Int) -- Define 4-upla
padroes3 :: Tupla4 -> String
padroes3 (_,_,_,fourth) 
    | fourth > 10 = "Maior que 10"
    | otherwise = "Nao maior que 10"

-- Execução
ghci> padroes3 (100,2,35,40)
"Maior que 10"
```

## Padrão Coringa
- É representado pelo ***underscore***.
- Pode ser utilizado tendo em mente o casamento de padrões próprio da linguagem, para representar **dados indefinidos** (variáveis) ou que **não sejam relevantes** para o seu programa, ou seja, **não precisam ser nomeados**.
- Exemplo:

```haskell
f1 :: Int -> Int -> Int -> Int
f1 x y z 
    | x == 1 = 10 
    | y == 2 = 20 
    | z == 3 = 30 
    | otherwise = 0
```

- Esse mesmo programa poderia ser escrito da seguinte forma:

```haskell
f2 :: Int -> Int -> Int -> Int
f2 1 _ _ = 10 
f2 _ 2 _ = 20 
f2 _ _ 3 = 30 
f2 _ _ _ = 0
```

- A utilização do ***underscore*** facilita a implementação de funções que utilizam o **casamento de padrões** para chegar ao seu resultado.
- Funciona muitas vezes como alternativas para estruturas `if-then-else` e `guardas` muito grandes.

## Exercícios
1. Reescreva a função abaixo de maneira mais simples utilizando **casamento de padrões** e **padrão curinga**.

```haskell
opp :: (Int, (Int, Int)) -> Int
opp z = if fst z == 1
    then fst (snd z) + snd (snd z) 
    else if fst z == 2
        then fst (snd z) - snd (snd z)
        else 0
```

```haskell
opp2 :: (Int, (Int, Int)) -> Int
opp2 (1, (x,y)) = x + y
opp2 (2, (x,y)) = x - y
opp2 _ = 0

-- Execução
ghci> opp2 (1, (5,6))
11
ghci> opp2 (2, (5,6))
-1
ghci> opp2 (3, (5,6))
0
ghci> opp2 (100, (5,6))
0
```

## Polimorfismo
- Tipos polimórficos descrevem **famílias** de diferentes tipos.
- **Exemplos:**
```haskell
[a]        -- lista de qualquer tipo
[Int]      -- lista de inteiros
[Char]     -- string
[[Float]]  -- lista de listas
```

- `a`: É uma **variável de tipo**, ou seja, é mais geral que as instâncias de tipos `Int`, `Char`, `[Float]`, etc.

### Funções Polimórficas
- Uma função que se aplica a **qualquer tipo de parâmetro** é uma função polimórfica.

```haskell
size :: [a] -> Int
size (x:xs) = 1 + size xs -- Vai somando 1 + 1 + 1 até a lista ficar vazia
size [] = 0

-- Execução
ghci> size [1..10]
10
ghci> size [11,3,5]
3
ghci> size ['a'..'z']
26

somamenor m (x:y:t)
    | z < m     = (x,y,z) : somamenor m (y:t)
    | otherwise = somamenor m (y:t)
    where z = x + y
somamenor _ _ = []

-- Execução
ghci> somamenor 10 [1..9]
[(1,2,3),(2,3,5),(3,4,7),(4,5,9)]
ghci> somamenor 10 [1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5]
[(1.5,2.5,4.0),(2.5,3.5,6.0),(3.5,4.5,8.0)]
```

- `(x:y:t)` é `xs` que é o segundo elemento.
    - `x`: Primeiro elemento
    - `y`: Segundo elemento
    - `t`: Cauda, restante da lista.

- A função percorre pares consecutivos e gera tuplas `(x,y,x+y)`.
    - Apenas adiciona quando `x + y < m`.
- `z`: **Soma** dos primeiros elementos da lista.
- Vai tirando o primeiro elemento até que a soma dos primeiros seja menor ou igual ao último elemento e no final faz a composição com a lista vazia `[]`.

## Avaliação Preguiçosa
- Uma expressão só é avaliada quando seu valor é requerido.
- Uma **expressão cotizada**, aparecendo em vários lugares, é avaliada **uma única vez**.

```haskell
ghci> zero x = 0
ghci> zero 10
0
ghci> zero (1/0)
0
ghci> zero $! (1/0) -- Força avaliação argumento mas não funcionou!
Program execution error: {primDivDouble 1.0 0.0}
```

### Exemplo

- Passagem de parâmetro por **referência**, os endereços:
```haskell
-- Passagem de parâmetro por referência:
ghci> qd x = x*x
ghci> qd(qd (qd 2))
256

{-
qd(qd (qd 2)) = (qd (qd 2)) * (qd (qd 2))
                = (qd 2) * (qd 2) * (qd (qd 2))
                = 2 * 2 * (qd 2) * (qd (qd 2))
                = 4 * (qd 2) * (qd (qd 2)) -- Já está a operação, não ocorre a expansão
                = 4 * 4 * (qd (qd 2))
                = 16 * (qd (qd 2))
                = 16 * 16 = 256
-}

-- Passagem de parâmetro por valor
{-
qd(qd(qd 2)) = qd(qd (2*2)) = qd(qd(4)) = qd(4*4)
= qd(16) = 16*16
-}
```

- Ambas apresentam esforço próximo a <u>3 multiplicações</u>.

### Objetos Infinitos

- Graças a avaliação preguiçosa é possível lidar com **lista infinitas**.

```haskell
ghci> let naturais n = take n [0..] in naturais 8
[0,1,2,3,4,5,6,7]

ghci> let impares n = take n [1,3..] in impares 10
[1,3,5,7,9,11,13,15,17,19]
```

#### Avaliação Preguiçosa e Objetos Infinitos

```haskell
ghci> fiblist = 1:1:[ x+y | (x,y) <- (zip fiblist (tail fiblist))]
ghci> take 10 fiblist 
[1,1,2,3,5,8,13,21,34,55]
```

- Faz um `zip` do **primeiro** e do **último** elemento da lista e a soma deles vai para a cauda.
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

```haskell
primes = filterPrime [2..]
    where filterPrime (p:t) = p : filterPrime [x | x <- t, x `mod` p/= 0 ]
    
ghci> take 10 primes
[2,3,5,7,11,13,17,19,23,29]
```
