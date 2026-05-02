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


-- Exercício 07. Escreva uma função que retorne o número de vezes que um dado elemento aparece numa lista. (1,0)
apareceLista :: [Int] -> Int -> Int
apareceLista [] _ = 0
apareceLista (h:t) n 
    | h == n = 1 + apareceLista t n
    | otherwise = apareceLista t n

-- Exercício 08. Escreva uma função que receba uma lista de números e retorne uma tupla com uma lista dos números pares e uma lista dos números ímpares. (1,5) 
type TuplaDeLista = ([Int], [Int])
funcao :: [Int] -> TuplaDeLista
funcao [] = ([],[])
funcao (h:t) 
    | even h = (h: pares, impares)
    | otherwise = (pares, h: impares)
    where
        (pares, impares) = funcao t

-- Exercício 09. Escreva uma função que verifique se um ano é bissexto. (0,5)
ehBissexto :: Int -> Bool
ehBissexto n = (n `mod` 4 == 0 && n `mod` 100 /= 0) || (n `mod` 400 == 0)  

-- Exercício 10. Escreva uma função que verifique se um ponto (x,y) está dentro de uma circunferência de raio R e com centro localizado num ponto (a,b). (1,0)
type Ponto = (Float, Float)
dentroCirc :: Ponto -> Ponto -> Float -> Bool
dentroCirc (x,y) (a,b) r
    | (x - a)^2 + (y - b)^2 < r^2 = True
    | otherwise = False

-- Exercício 11. Crie uma função que gere os números primos menores que um dado número.
isPrime :: Int -> Bool
isPrime n
    | length [x | x <- [1..n], n `mod` x == 0] == 2 = True
    | otherwise = False

listaPrimos :: Int -> [Int]
listaPrimos n = filter isPrime [1..n]

-- Exercício 12. Escreva uma função que receba uma lista e a transforme em palíndrome. (1,0)
transforma :: [Int] -> [Int]
transforma lista = lista ++ reverse lista 

-- Exercício 13. Escreva uma função que receba uma lista e retorne o número de elementos que estão acima da média dos valores da lista. (2,0)
acimaMedia :: [Int] -> [Int]
acimaMedia [] = []
acimaMedia lista = filter (\x -> x * n > s) lista
    where
        s = sum lista
        n = length lista

-- Exercício 14. Escreva uma função que receba os coeficientes a,b e c da entrada padrão (teclado) e calcule as raízes da equação $ax^2 + bx +c$.
entrada :: IO ()
entrada = do
    putStr "Digite o valor do coeficiente a: "
    astr <- getLine
    putStr "Digite o valor do coeficiente b: "
    bstr <- getLine
    putStr "Digite o valor do coeficiente c: "
    cstr <- getLine
    
    let 
        a = read astr
        b = read bstr 
        c = read cstr
        delta =  b^2 - 4*a*c
        r1 = (-b + sqrt delta) / (2 * a) 
        r2 = (-b - sqrt delta) / (2 * a) 

    if delta > 0 
        then
            putStrLn ("Raiz 1 = " ++ show r1 ++ "\nRaiz 2 = " ++ show r2)
    else if delta == 0
        then 
            putStrLn ("Raiz = " ++ show r1)
    else 
        putStrLn "Sem raízes"

-- Exercício 15. Escreva uma função que receba uma lista e retorne a posição de um dado elemento nessa lista, iniciando da posição 0. (1,0)
posicaoRec :: Int -> [Int] -> Int
posicaoRec _ [] = 0 
posicaoRec n (h:t)
    | h == n = posicaoRec n []
    | h /= n = 1 + posicaoRec n t

posicao :: Int -> [Int] -> Int
posicao n lista = 
    if n `elem` lista
        then 
            posicaoRec n lista
        else -1

-- Exercício 16. Escreva uma função que receba uma string com o nome de um arquivo e retorne a extensão daquele arquivo (considere que a extensão vem depois do último ponto). (1,5)
procuraPonto :: String -> String
procuraPonto "" = ""
procuraPonto (h:t)
    | h == '.' = h : ""
    | otherwise = h : procuraPonto t

extensao :: String -> String
extensao s = 
    if '.' `elem` s 
        then reverse (procuraPonto (reverse s))
    else "unknown"

-- Exercício 18. Escreva uma função que quebre uma string em duas partes no ponto onde estiver uma "/" e retorne uma tupla com as duas partes. (2,0)
quebra :: [Char] -> ([Char], [Char])
quebra (h:t)
    | h /= '/' = (h: parte1, parte2)
    | otherwise = (parte1, t)
    where 
        (parte1, parte2) = quebra t
