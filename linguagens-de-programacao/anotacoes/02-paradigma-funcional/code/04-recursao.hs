-- Fatorial com Guardas
fatorial :: Int -> Int
fatorial n
    | n == 0 = 1 
    | n > 0 = n * fatorial (n - 1)

-- Fatorial sem Guardas
fat :: Int -> Int
fat 0 = 1
fat 1 = 1
fat n = n * fat (n - 1) -- e se n < 0 ? Retorna um ERRO !!

divRec :: Int -> Int -> Int
divRec a b 
    | b > a = a 
    | b == a = 0
    | otherwise = divRec(a - b) b

potencia2 :: Int -> Int
potencia2 n 
    | n == 0 = 1
    | n > 0 = 2 * potencia2 (n - 1)

potencia2Cauda :: Int -> Int -> Int
potencia2Cauda n acumulado 
    | n == 0 = acumulado
    | n > 1 = potencia2Cauda (n-1) (acumulado * 2)

fatorialCauda :: Integer -> Integer -> Integer
fatorialCauda n acc
    | n == 0 = acc
    | n > 0 = fatorialCauda (n - 1) (n * acc)

-- Exercícios 
somaSuc :: Int -> Int -> Int
somaSuc x n 
    | n == 1 = x
    | n > 1 = x + somaSuc x (n - 1) 

-- Vai diminindo o valor de n até que n == 1 e soma o último n da pilha de soma.

mdc :: Int -> Int -> Int
mdc x y 
    | x > y = mdc (x-y) y
    | x < y = mdc y x
    | x == y = x

-- Exercício 03 - Fibonacci com Cauda
fib :: Int -> Int -> Int -> Int
fib n a1 a2 
    | n == 0 = a1
    | n == 1 = a2
    | n > 1 = fib (n - 1) (a1 + a2) a2 
