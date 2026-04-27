# Funções de Alta Ordem
- São funções que **operam sobre outras funções**, ou seja, que podem receber uma função como resultado.
- Para ilustrar o mecanismo, iremos estudar duas funções muito utilizadas no procesamento de listas: **mapeamento** e **filtros**.
    - **Mapeamento:** Recebe uma lista e aplica uma determinada <u>operação</u> em todos os elementos de uma lista.   
- São funções que **manuseiam** outras funções.
- **Exemplos:**
    - Composição de funções.
    - Passadas como parâmetros.
    - Resultado da chamada de função.
    - Aplicação parcialmente aos seus argumentos.
    - Usadas em estrutura de dados.

### Exemplo: Dobra os elementos de uma lista

```haskell
dobra :: Int -> Int
dobra n = 2 * n

dobraLista :: [Int] -> [Int]
dobraLista [] = []
dobraLista (primeiro:outros) = (dobra primeiro) : (dobraLista outros)

-- Execução
ghci> lista = [1..9]
ghci> dobraLista lista
[2,4,6,8,10,12,14,16,18]
```

### Exemplo: Eleva ao quadrado os elementos de uma lista
- Agora, imagine que queiramos fazer também uma função que **calcule o quadrado** de um número. A única troca com relação à anterior seria de `2 * n` por `n^2`.
- É possível implementar uma **função de alta ordem**, chamada de `mapInt`, que recebe uma **função f** do tipo (`Int -> Int`) como argumento e a **aplica uniformemente** em todos os elementos da lista, retornando uma lista de inteiros mapeada.

```haskell
mapInt :: (Int -> Int) -> [Int] -> [Int]
mapInt _ [] = []
mapInt f (h:t) = f h : mapInt f t

-- Execução
ghci> mapInt dobra [6..9]
[12,14,16,18]
ghci> mapInt quadrado [6..9]
[36,49,64,81]
ghci> let triplo x = 3*x in mapInt triplo [6..9]
[18,21,24,27]
ghci> mapInt (+2) [1..4]
[3,4,5,6]
```

- Exemplo: Criaremos uma função de alta ordem chamada **"filtro"**, que recebe como argumento uma função de teste e seleciona os elementos da lista que satisfazem a condição desejada.

```haskell
filtro :: (Int -> Bool) -> [Int] -> [Int]
filtro _ [] = []
filtro f (h:t)
    | f h == True = h : filtro f t -- f h = ... já resolve
    | otherwise = filtro f t

-- Se o teste a cabeça for True, filtra a cauda
-- Caso contrário a cabeça da cauda não entra, e filtra o restante da lista

pares :: Int -> Bool 
pares n = mod n 2 == 0 

impares :: Int -> Bool 
impares n = mod n 2 == 1

-- Execução
ghci> filtro pares [1..20]
[2,4,6,8,10,12,14,16,18,20]
ghci> filtro impares [1..20]
[1,3,5,7,9,11,13,15,17,19]

-- Outra versão
filtro1 p (x:xs) 
    | p x       = x : filtro1 p xs
    | otherwise = filtro1 p xs
filtro1 _ [] = []
```

## `map` e `filter`
- No `Haskell` já existem funções próprias para mapeamento e filtragem, `map` e `filter`.

```haskell
-- Exemplos:
-- map
ghci> let square n = n^2 in map square [1..9]
[1,4,9,16,25,36,49,64,81]
ghci> let add1 x = x+1 in map add1 [1..9]
[2,3,4,5,6,7,8,9,10]
ghci> map (+10) [1..9]
[11,12,13,14,15,16,17,18,19]

-- filter
ghci> lista = [1..9]
ghci> let impares n = (mod n 2 == 1) in filter impares lista 
[1,3,5,7,9]
ghci> filter (>5) lista 
[6,7,8,9]
ghci> filter (==1) lista 
[1]

-- Uma lista aplicada a função x tal que x faz parte xs.
map f xs = [f x | x <- xs]
-- O par ordenado (x,y) vem do zip de xs e ys
map2 f xs ys = [f x y | (x,y) <- zip xs ys]
```

## Exercícios
1. Tomemos o exemplo de uma função que **busca o maior elemento em uma lista de inteiros**. Imagine agora que queiramos tornar essa função "mais geral", possibilitando que o usuário entre com o tipo de busca a ser realizada: **maior** ou **menor**.

```haskell
maior :: Int -> Int -> Bool
maior x y 
    | x >= y = True
    | otherwise = False

menor :: Int -> Int -> Bool
menor x y 
    | x < y = True
    | otherwise = False

busca :: (Int -> Int -> Bool) -> [Int] -> Int
busca _ [] = -1
busca _ [h] = h
busca f (h:t) 
    | f h x = h
    | otherwise = x
    where 
        x = busca f t

-- Execução
ghci> busca menor [50, 12, 6, 78, 45]
6
ghci> busca maior [50, 12, 6, 78, 45]
78
ghci> busca menor [1]
1
ghci> busca maior [1]
1
ghci> busca menor []
-1
ghci> busca maior []
-1
```

2. Utilize a função `filter` para substituir os as partes de compreensão de do algoritmo de quicksort abaixo.

```haskell
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (h:t) = quicksort [y | y <- t, y < h] -- menores que o pivô
                            ++ [h] -- o próprio pivô
                            ++ [y | y <- t, y >= h] -- Maiiores que o pivô

-- Usando filter
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (h:t) =
    quicksort menores ++ [h] ++ quicksort maiores
    where
        menores = filter (< h) t -- (<h) é o mesmo que \y -> y < h
        maiores = filter (>= h) t -- (>=h) é o mesmo que \y -> y >= h
```

## Composição de Funções

```haskell
f . g x = f (g x)
ghci> var xs = (sum (map (^2) xs) / n) - (sum xs / n)^2 where n = fromIntegral (length xs)
ghci> var [1.0,1.5..5.0]
1.666666666666666

ghci> ((^3) . (/2)) 10
125.0
ghci> (sum . take 10) [1..]
55

-- 1:uns -> Gera uma lista de uns, [1,1,1,...] e soma os 20 primeiros elementos.
ghci> let uns = 1:uns in (sum . take 20) uns
20

ghci> take 20 uns where uns = 1:uns
[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

-- | Se for n == 1 --> [1]
-- simula o take, expande até o n - 1
ghci> let uns n | n==1 = [1] | n/=1 = 1:uns (n-1) in (sum.uns) 30
30
```

## Funções como Parâmetros
- `p`: tem que ser uma **função predicativa**, retorna true ou false.
- \` \`: Transforma uma função em um **operador**.

```haskell
-- Outra versão
par x = x `mod` 2 == 0

filtro1 p (x:xs) 
    | p x       = x : filtro1 p xs
    | otherwise = filtro1 p xs
filtro1 _ [] = []

-- Execução
ghci> filtro1 par [1..21]
[2,4,6,8,10,12,14,16,18,20]

ghci> filtro1 odd [1..21]
[1,3,5,7,9,11,13,15,17,19,21]

ghci> map par [1..10]
[False,True,False,True,False,True,False,True,False,True]

-- 0 + (1 + (2 + (3 + ... )))
ghci> foldr (+) 0 [1..10]  
55
```

## Função como Resultado

```haskell
somat :: [Integer] -> Integer
somat = foldl (+) 0
produt :: [Integer] -> Integer  
produt = foldl (*) 1 
append :: [[a]] -> [a]
append = foldr (++) []
quadlista :: [Integer] -> [Integer] 
quadlista = map (^2) 

-- Execução
ghci> somat [1..10]
55

ghci> produt [1..10]
3628800

ghci> append [[1,2], [3,4],[5,6,7],[8,9,10]]
[1,2,3,4,5,6,7,8,9,10]

ghci> quadlista [1,3..9]
[1,9,25,49,81]
```

### Aplicação Parcial

```haskell
ghci> let suc = (+1) in suc 4
5
ghci> let somatorio = foldr (+) 0 in somatorio [1..10]
55
ghci> let soma a b = a + b in soma 3 5
8
ghci> let olah = ("Oi " ++) . (++ " como vai voce?") in olah "Joao"
"Oi Joao como vai voce?"
```

## Funções em Estrutura de dados

```haskell
ghci> let operacao (f, x, y) = f x y in operacao ((+), 4, 6)
10
ghci> let operacao (f, x, y) = f x y in map operacao [((+), 4, 6), ((*), 3, 4)]
[10,12]
```
