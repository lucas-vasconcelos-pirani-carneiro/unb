padroes :: Int -> String
padroes 1 = "Um!"
padroes 2 = "Dois!"
padroes 3 = "Tres!"
padroes x = "Nao esta entre 1 e 3!"

padroes2 :: Int -> String
padroes2 1 = "Um!"
padroes2 2 = "Dois!"
padroes2 3 = "Tres!"
padroes2 _ = "Nao esta entre 1 e 3!"

comp :: [Int] -> Int
comp [] = 0 -- Caso Base
comp (_:t) = 1 + comp t -- Caso Recursivo

type Tupla4 = (Int, Int, Int, Int) -- Define 4-upla
padroes3 :: Tupla4 -> String
padroes3 (_,_,_,fourth) 
    | fourth > 10 = "Maior que 10"
    | otherwise = "Nao maior que 10"

-- Exercícios
opp2 :: (Int, (Int, Int)) -> Int
opp2 (1, (x,y)) = x + y
opp2 (2, (x,y)) = x - y
opp2 _ = 0

size (x:xs) = 1 + size xs -- Vai somando 1 + 1 + 1 até a lista ficar vazia
size [] = 0

somamenor m (x:y:t)
    | z < m     = (x,y,z) : somamenor m (y:t)
    | otherwise = somamenor m (y:t)
    where z = x + y
somamenor _ _ = []

primes = filterPrime [2..]
    where filterPrime (p:t) = p : filterPrime [x | x <- t, x `mod` p/= 0 ]
