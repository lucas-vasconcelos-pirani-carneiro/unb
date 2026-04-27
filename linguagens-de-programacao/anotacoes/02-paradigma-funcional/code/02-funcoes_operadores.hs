-- Usando if-then-else
-- Maior Número
maior1 :: Int -> Int -> Int
maior1 a b = if a >= b -- Poderia escrever tudo na mesma linha
    then a 
    else b

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

-- Funções usando Guardas
-- Maior Número
maior2 :: Int -> Int -> Int
maior2 a b 
    | a > b = a
    | b > a = b
    | otherwise = 0

-- Fatorial
fatorial :: Int -> Int
fatorial n
    | n == 0 || n == 1 = 1 
    | n > 0 = n * fatorial(n - 1)

-- MDC
mdcGuardas :: Int -> Int -> Int
mdcGuardas a b
    | b == 0 = a
    | otherwise = mdcGuardas b (a `mod` b)

-- Usando case-of
-- Merge
mergeLista :: [Int] -> [Int] -> [Int]
mergeLista xs ys = case (xs, ys) of
    (z:zs, w:ws)
        | z <= w -> z : mergeLista zs ys
        | otherwise -> w : mergeLista xs ws
    ([], ys) -> ys
    (xs, []) -> xs

-- Fatorial
fatCase :: Int -> Int
fatCase n = case n of
    0 -> 1
    1 -> 1
    k -> k * fat(k-1)

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

-- Pega os primeiros n elementos de uma lista
pega :: Int -> [Int] -> [Int]
pega n ys = case (n,ys) of
    (0,_) -> []
    (_,[]) -> []
    (n,x:xs) -> x : pega (n-1) xs

-- Função Membro 
membro :: Int -> [Int] -> Bool
membro z [] = False
membro z (w:ws) = z == w || membro z ws

-- União de Lista
(\/) :: [Int] -> [Int] -> [Int] 
[] \/ ys = ys
(x:xs) \/ ys | membro x ys = xs \/ ys
              | otherwise   = x : xs \/ ys

-- União de Lista usando definições locais
{-  
(\/) :: [Int] -> [Int] -> [Int]
xs \/ ys 
    | xs == []   = ys
    | membro x ys = resto
    | otherwise   = x:resto
  where (x:t) = xs
        resto = t \/ ys
-}

-- Exercícios
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

charcase :: Char -> String
charcase ch
    | ch >= 'a' && ch <= 'z' = "Minusculo"
    | ch >= 'A' && ch <= 'Z' = "Maiusculo"
    | otherwise = "Desconhecido"

func :: Int -> Int -> Int -> Int
func a b c 
    | a == 0 = b^2 + 3*c
    | a == 1 = 2*c^2 - 3*c
    | a == 2 = 3*c - b^2 
    | otherwise = 0 
