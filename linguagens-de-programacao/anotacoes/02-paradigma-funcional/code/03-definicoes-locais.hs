-- Formula de Heron com Where
areaHeron :: Float -> Float -> Float -> Float
areaHeron a b c = sqrt (s * (s - a) * (s - b) * (s - c))
    where 
        s = (a + b + c) / 2 -- Definição local do Semiperimetro

-- Utilizando Guardas
funcao :: Int -> Int -> Int
funcao x y 
    | x <= 10 = x + a
    | otherwise = x - a
    where
        a = (y + 1)^2

outrafuncao :: Int -> Int
outrafuncao y = 3 + func y + func a + func b
    where
        func x = x + 7*c -- Define uma outra função local
        a = 3*c -- Define o valor de com expressões
        b = func 2 -- Define o valor com a chamada da função
        c = 10 -- define valor fixo

bhaskara :: Float -> Float -> Float -> Int
bhaskara a b c 
    | delta > 0 = 2
    | delta == 0 = 1
    | otherwise = 0
    where   
        delta = b^2 - 4 * a * c

-- Área da superfície de um cilindro com let
areaCilindro :: Float -> Float -> Float
areaCilindro r h =
    let areaLado = 2 * pi * r * h
        areaBase = pi * r^2
    in areaLado + 2 * areaBase

-- Heron com let
areaHeronLet :: Float -> Float -> Float -> Float
areaHeronLet a b c = 
    let s = (a + b + c) / 2
    in sqrt( s * (s - a) * (s - b) * (s - c) )
