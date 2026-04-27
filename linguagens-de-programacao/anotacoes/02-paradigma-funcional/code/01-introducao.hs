-- primeiro programa em haskell
polinomio :: Int -> Int
polinomio x = x*x + 10*x + 2

-- calcula o quadrado de um numero
square :: Int -> Int
square n = n * n

-- soma
soma :: Float -> Float -> Float
soma a b = a + b

-- triplica
triplica :: Int -> Int
triplica var = 3*var

-- calcula o mdc
mdc :: Int -> Int -> Int
mdc a 0 = a
mdc a b = mdc b (a `mod` b)

-- Exercícios
areaCirculo :: Float -> Float
areaCirculo r = pi * r*r

perimetroCirculo :: Float -> Float
perimetroCirculo r = 2 * pi * r

calculaHipotenusa :: Float -> Float -> Float
calculaHipotenusa a b = sqrt (a*a + b*b)

difAreaCirculo :: Float -> Float -> Float
difAreaCirculo r1 r2 = abs (areaCirculo r1 - areaCirculo r2) 
