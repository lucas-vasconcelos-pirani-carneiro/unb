-- Exercício 01. Escreva uma função que receba uma lista de 4 elementos e verifique se todos os elementos são iguais. (1,0)
elemIguais :: [Int] -> Bool
elemIguais [] = True
elemIguais [_] = True
elemIguais (h1:h2:t)
    | h1 /= h2 = False
    | otherwise = elemIguais (h2:t)

-- Exercício 02. Escreva uma função que calcule o resto de uma divisão de dois números inteiros. 
restoDiv :: Int -> Int -> Int
restoDiv n1 n2 = n1 `mod` n2

-- Exercício 03. Utilize recursão para criar uma função que calcule 2^n.
potencia2 :: Int -> Int
potencia2 n
    | n == 0 = 1
    | n > 0 = 2 * potencia2 (n-1)

pot2 :: Int -> Int
pot2 0 = 1
pot2 n = 2 * pot2(n-1)

-- Exercício 04. Escreva uma função que calcule o dobro da soma dos elementos de uma lista.
somaDobro :: [Int] -> Int
somaDobro lista = 2 * sum lista

-- Exercício 05. Crie uma função que retorne a lista de todos os divisores de um dado número.
divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], n `mod` x == 0]

--- Exercício 06. Escreva uma função que verifique se duas listas possuem os mesmos elementos (a ordem não importa)
removerElem :: Int -> [Int] -> [Int]
removerElem _ [] = []
removerElem n (h:t)
    | n == h    = t
    | otherwise = h : removerElem n t

listasIguais :: [Int] -> [Int] -> Bool
listasIguais [] [] = True
listasIguais [] _  = False
listasIguais (h:t) ys
    | h `elem` ys = listasIguais t (removerElem h ys)
    | otherwise   = False



