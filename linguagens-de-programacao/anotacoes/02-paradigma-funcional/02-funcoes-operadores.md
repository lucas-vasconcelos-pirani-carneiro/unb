# Funções, Condicionais e Operadores

## Funções
- Funções são estruturas que, aplicadas a parâmetros/operandos, retornam **valores**. 
- São **prefixadas** por padrão, associativas à esquerda e têm prioridade máxima (10).
- Exemplo de associação: `f a b = (f a) b`.

### Definição e Sintaxe
- **Nomes:** Letras + dígitos, iniciando com letra **minúscula** (funções/parâmetros); **maiúscula** para tipos.
- <u>Sem parênteses</u> entre nome e parâmetros; separe por espaços.
- **Comentários:** `--` até o fim da linha.
- **Tipos explícitos:** `:: TipoParam1 -> TipoParam2 -> ... -> TipoRetorno`.
    - Haskell é **fortemente tipada**, ou seja, verifica tipos em ***compile-time***.
    - **Tipos básicos:** `Int/Integer` (inteiros), `Float/Double` (reais), `Bool` (booleanos), `Char` (caracteres).

```haskell
soma :: Float -> Float -> Float -- Parâmetro, Parâmetro, Retorno
```

> [!NOTE]
> 
> - Uma **função** pode ser tratada de forma **infixada** se for envolvida por **apóstrofes**, ``a `mod` b`` .
> Funções podem ser infixas com apóstrofes: `div` 10 3.

#### Função Lambda
- Funções <u>sem nome</u>, **anônima**, são chamadas de **lambdas**. 
- São definidas por: `(\args -> corpo)`

```haskell
ghci> (\x -> x^2) 3
9
ghci> map (\x -> x^2) [1..4]
[1,4,9,16]
```

> [!NOTE]
>
> - Quando usar funções Lambda ? Para expressões curtas e únicas (Ex: map, filter)

### Funções já Fornecidas

| Função  | Descrição                                                       | Tipo                                  |
|--------|-----------------------------------------------------------------|----------------------------------------|
| `abs`    | retorna o valor absoluto de um número                           | `abs :: Num a => a -> a`                |
| `ceiling` | retorna o menor inteiro não menor do que o argumento           | `ceiling :: (RealFrac a, Integral b) => a -> b` |
| `cos`    | retorna o cosseno de um número descrito em radianos            | `cos :: Floating a => a -> a`           |
| `div`    | retorna o quociente inteiro da divisão de dois inteiros        | `div :: Integral a => a -> a -> a`      |
| `exp`    | retorna o valor correspondente a $e^n$                            | `exp :: Floating a => a -> a`           |
| `floor`  | retorna o maior inteiro não maior do que o argumento              | `floor :: (RealFrac a, Integral b) => a -> b`    |
| `lcm`    | retorna o mínimo múltiplo comum entre dois inteiros               | `lcm :: Integral a => a -> a -> a`               |
| `mod`    | retorna o resto inteiro da divisão de dois inteiros               | `mod :: Integral a => a -> a -> a`               |
| `pi`     | retorna o valor $\pi$                                                 | `pi :: Floating a => a`                          |
| `round`  | retorna o inteiro mais próximo do argumento                       | `round :: (RealFrac a, Integral b) => a -> b`    |
| `sin`      | retorna o seno de um número descrito em radianos               | `sin :: Floating a => a -> a`                   |
| `sqrt`     | retorna a raiz quadrada do argumento                           | `sqrt :: Floating a => a -> a`                  |
| `tan`      | retorna a tangente de um número descrito em radianos           | `tan :: Floating a => a -> a`                   |
| `truncate` | retorna o inteiro sem parte fracionária do número              | `truncate :: (RealFrac a, Integral b) => a -> b` |

## Condicionais

### Condicionais `if-then-else`
- Uma função também pode incluir **estruturas condicionais** para desviar o fluxo do programa para diferentes partes, dependendo de uma **condição verdadeira ou falsa**.
- Há uma maneira tradicional (**Programação Imperativa**) de se fazer condicionais em `Haskell`, através da estrutura `if-then-else`.
- Exemplo: Maior número

```haskell
-- Usando if-then-else
-- Maior Número
maior1 :: Int -> Int -> Int
maior1 a b = if a >= b -- Poderia escrever tudo na mesma linha
    then a 
    else b

-- Execução
ghci> maior1 10 11
11
ghci> maior1 100 11
100
```

### Guardas
- Uma função é normalmente definida como:
```haskell
-- Funções que são definidas normalmente
-- MDC
mdc :: Int -> Int -> Int
mdc a 0 = a
mdc a b = mdc b (mod a b)

-- Fatorial
fat :: Int -> Int
fat 0 = 1
fat 1 = 1
fat n = n * fat (n - 1)
```

- Cada uma das equações na definição pode conter **guardas**. 
- Uma guarda é uma **função predicativa**.
    - Se a guarda for **verdadeira**, a expressão correspondente na função é **executada**.

- Os **Guardas** são **equações condiocionais** que especificam cada uma das circunstâncias nas quais a definição da função pode ser aplicada.
    - Similiar ao `switch-case`.

- Pode ou não ter a palavra `otherwise`, como a **última condição** em uma expressão condicional, de acordo com a necessidade de um caminho padrão.
    - Similiar do `default` do `switch-case`.

- Cada gurada é responsável por uma saída, caso aquele guarda seja verdadeiro.
- Com guardas, a **primeira expressão** a ser avaliada como verdadeira, seguindo a ordem da escrita, determina o valor da função.
    - Testa o primeiro guarda, se for verdadeiro já retorna o valor daquela função, se for falsa passa para o próximo guarda.
    - E assim por diante ...

#### Exemplos
```haskell
-- Usando Guardas
-- Maior Número
maior2 :: Int -> Int -> Int
maior2 a b 
    | a > b = a
    | b > a = b
    | otherwise = 0

-- Execução
ghci> maior2 5 8
8
ghci> maior2 6 3
6
ghci> maior2 4 4
0

-- Fatorial 
fatorial :: Int -> Int
fatorial n
    | n == 0 || n == 1 = 1 
    | n > 0 = n * fatorial(n - 1)

-- Execução
ghci> fatorial 5
120
ghci> fatorial 4
24
ghci> fatorial 7
5040

-- MDC
mdcGuardas :: Int -> Int -> Int
mdcGuardas a b
    | b == 0 = a
    | otherwise = mdcGuardas b (a `mod` b)

-- Execução
ghci> mdcGuardas 2 3
1
ghci> mdcGuardas 24 36
12
```

> [!WARNING]
>
> O `Haskell` utiliza a **identação** para delimitar o escopo/bloco das funções.

### Expressões Case

- Uma expressão case tem a forma geral: 
```haskell
case <exp> of 
    p1 match_1
    ... ; 
    pn match_n

-- Analogia com if-then-else
if e1 then e2 else e3 = case e1 of { True -> e2 ; False -> e3 }
```

> [!NOTE]
> 
> - e2 e e3 podem ser `if` também!

```haskell
-- Usando case-of
-- Merge
mergeLista :: [Int] -> [Int] -> [Int]
mergeLista xs ys = case (xs, ys) of
    (z:zs, w:ws)
        | z <= w -> z : mergeLista zs ys
        | otherwise -> w : mergeLista xs ws
    ([], ys) -> ys
    (xs, []) -> xs

-- Execução
ghci> mergeLista [1,3..9] [2,4..10]
[1,2,3,4,5,6,7,8,9,10]

-- Fatorial
fatCase :: Int -> Int
fatCase n = case n of
    0 -> 1
    1 -> 1
    k -> k * fat(k-1)

-- Execução
ghci> fatCase 1
1
ghci> fatCase 5
120
ghci> fatCase 7
5040

-- Quicksort
qsort :: [Int] -> [Int]
qsort ls =
    case ls of
        [] -> []
        [x] -> [x]
        otherwise -> qsort ys ++ [x] ++ qsort zs
    where
        (x:xs) = ls
        ys = [y | y <- xs, y < x]
        zs = [z | z <- xs, z >= x]

-- Execução
ghci> qsort [8,5,7,3,4]
[3,4,5,7,8]

-- Pega os primeiros n elementos de uma lista
pega :: Int -> [Int] -> [Int]
pega n ys = case (n,ys) of
    (0,_) -> []
    (_,[]) -> []
    (n,x:xs) -> x : pega (n-1) xs

-- Execução
ghci> pega 3 [8,5,7,3,4]
[8,5,7]
ghci> pega 7 [8,5,7,3,4]
[8,5,7,3,4]
```

## Operadores
- Em Haskell, operadores são, em geral, **infixados** (escritos entre os operandos) e permitem declarar prioridade e **associatividade** para controlar a **ordem** de avaliação.
- Exemplo de diferença gerada por associatividade:
    - **Potência:** `x ^ y ^ 2 = x ^ (y^2)`, associativa à **direita**.
    - **Soma:** `x + y + 2 = (x + y) + 2`, associativa à **esquerda**.

### O que é um Operador
- Tem nome formado por **símbolos especiais** (não letras nem dígitos).
- Aparece como operador **infixado** na expressão.

```haskell
ghci> 5 == 9
False
ghci> [1,2,3] ++ [5,6]
[1,2,3,5,6]
-- Operadores podem também ser usados de forma prefixada, entre parênteses:
ghci> (++) [1,2,3] [5,6]
[1,2,3,5,6]
```

- Operadores são **definidos** de forma **similar a funções**, usando pattern matching e, se necessário, definições locais com `let` ou `where`.

```haskell
-- Função Membro 
membro :: Int -> [Int] -> Bool
membro z [] = False
membro z (w:ws) = z == w || membro z ws

-- União de Lista
\/ :: [Int] -> [Int] -> [Int] 
[] \/ ys = ys
(x:xs) \/ ys | membro x ys = xs \/ ys
              | otherwise   = x : xs \/ ys

-- Exeução
ghci> [1,3..10] \/ [2,4..10]
[1,3,5,7,9,2,4,6,8,10]

-- União de Listas usando definições locais
(\/) :: [Int] -> [Int] -> [Int]
xs \/ ys 
    | xs == []   = ys
    | membro x ys = resto
    | otherwise   = x:resto
  where (x:t) = xs
        resto = t \/ ys

ghci> [1,3..10] \/ [2,4..10]
[1,3,5,7,9,2,4,6,8,10]
```

> [!IMPORTANT]
>
> - `\/` implementa a união de listas: concatena xs e ys, evitando duplicatas.

### Propriedades
- A definição de um operador considera normalmente:
  - **Prioridade** (precedência).
  - **Associatividade** (à esquerda, à direita ou não associativo).
  - **Comportamento** (semântica da operação).

#### Prioridade
- Determina a **ordem de avaliação** quando há vários operadores na mesma expressão.
- Exemplo:
```txt
2 * 3 + 4 = (2*3) + 4 = 10 ? Certo
          = 2 * (3 + 4) = 14 ? Errado
```

#### Associatividade
- Define como avaliar expressões com vários operadores do mesmo nível:
$$
1 − 2 − 3 = (1 − 2) − 3 = −4
$$
    
- Para um operador $\oplus$:
  - **Assoc. esquerda:** x $\oplus$ y $\oplus$ z = (x $\oplus$ y) $\oplus$ z, (infixl).
  - **Assoc. direita:** x $\oplus$ y $\oplus$ z = x $\oplus$ (y $\oplus$ z) (infixr).
  - **Não associativo:** x $\oplus$ y $\oplus$ z gera erro!

### Operadores Relacionais
| Operador | Exemplo  | Descrição            |
|----------|----------|----------------------|
| `>`        | `a > b`    | a maior que b        |
| `>=`       | `a >= b`   | a maior igual a b    |
| `<`        | `a < b`    | a menor que b        |
| `<=`       | `a <= b`   | a menor igual a b    |
| `==`       | `a == b`   | a igual a b          |
| `/=`       | `a /= b`   | a diferente de b     |

### Operadores Aritméticos
| Operador | Exemplo | Descrição         |
|----------|--------|-------------------|
| `+`        | `a + b`  | soma              |
| `-`        | `a - b`  | subtração         |
| `*`        | `a * b`  | multiplicação     |
| `/`        | `a / b`  | divisão           |
| `^`        | `a ^ b`  | potência          |
| `div`      | `div a b`| divisão inteira   |
| `mod`      | `mod a b`| resto             |

## Exercícios

1. Escreva uma **função** que informa se dado número é **par**.

```haskell
-- Usando if-then-else
isPar :: Int -> Bool
isPar n = if mod n 2 == 0 
    then True
    else False

-- Usando Guardas
ehPar :: Int -> Bool
ehPar n
    | mod n 2 == 0 = True
    | otherwise = False

-- Execução
ghci> isPar 5
False
ghci> isPar 8
True
ghci> isPar 0
True
ghci> isPar 1
False
```

2. Escreva uma **função** que recebe um caractere como parâmetro e verifica se ele é maiúsculo ou minúsculo.

```haskell
charcase :: Char -> String
charcase ch
    | ch >= 'a' && ch <= 'z' = "Minusculo"
    | ch >= 'A' && ch <= 'Z' = "Maiusculo"
    | otherwise = "Desconhecido"

-- Execução
ghci> charcase 'a'
"Minusculo"
ghci> charcase 'R'
"Maiusculo"
ghci> charcase 'r'
"Minusculo"
ghci> charcase 'Z'
"Maiusculo"
ghci> charcase '$'
"Desconhecido"
```

3. Escreva uma **função** que recebe 3 parâmetros: a, b e c:
- Se `a = 0`, calcula-se: `b^2 + 3*c`.
- Se `a = 1` calcula-se: `2*c^2 - 3*c`.
- Se `a = 2`, calcula-se: `3*c - b^2`.
- Para **outros valores** de `a`, deve retornar `0`.

```haskell
func :: Int -> Int -> Int -> Int
func a b c 
    | a == 0 = b^2 + 3*c
    | a == 1 = 2*c^2 - 3*c
    | a == 2 = 3*c - b^2 
    | otherwise = 0 

-- Execução
ghci> func 0 2 3
13
ghci> func 1 2 3
9
ghci> func 2 2 3
5
ghci> func 10 2 3
0
```
