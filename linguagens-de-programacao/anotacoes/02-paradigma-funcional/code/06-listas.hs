-- Comprimento de uma Lista
comp :: [Int] -> Int
comp [] = 0 -- Caso base 
comp (head:tail) = 1 + comp tail

compGuardas :: [Int] -> Int
compGuardas lista
    | null lista = 0 -- lista == [] = 0
    | otherwise   = 1 + compGuardas (tail lista)

-- Função append
append :: [Int] -> [Int] -> [Int]
append [] ys = ys
append xs [] = xs
append (x:xs) ys = x:append xs ys

cubo :: Int -> Int
cubo n = n^3

aoCubo :: [Int] -> [Int]
aoCubo [] = []
aoCubo (head:tail) = cubo(head) : aoCubo tail

-- Exercicios
somaLista :: [Int] -> Int
somaLista [] = 0
somaLista (head:tail) = head + somaLista tail

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

-- Exercício 3: Busca maior número
buscaMaior :: [Int] -> Int
buscaMaior [] = -1
buscaMaior (head:tail) 
    | head >= maior_cauda = head 
    | otherwise = maior_cauda
    where 
        maior_cauda = buscaMaior tail
