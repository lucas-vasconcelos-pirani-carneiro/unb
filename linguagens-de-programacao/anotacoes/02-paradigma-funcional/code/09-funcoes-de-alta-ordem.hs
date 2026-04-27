dobra :: Int -> Int
dobra n = 2 * n

dobraLista :: [Int] -> [Int]
dobraLista [] = []
dobraLista (primeiro:outros) = (dobra primeiro) : (dobraLista outros)

mapInt :: (Int -> Int) -> [Int] -> [Int]
mapInt _ [] = []
mapInt f (h:t) = f h : mapInt f t

filtro :: (Int -> Bool) -> [Int] -> [Int]
filtro _ [] = []
filtro f (h:t)
    | f h == True = h : filtro f t -- f h = ... já resolve
    | otherwise = filtro f t

-- Outra versão
par x = x `mod` 2 == 0

filtro1 p (x:xs) 
    | p x       = x : filtro1 p xs
    | otherwise = filtro1 p xs
filtro1 _ [] = []

-- Uma lista aplicada a função x tal que x faz parte xs.
map3 f xs = [f x | x <- xs]
-- O par ordenado (x,y) vem do zip de xs e ys
map2 f xs ys = [f x y | (x,y) <- zip xs ys]

-- Exercícios
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

-- Quicksort usando filter
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (h:t) =
    quicksort menores ++ [h] ++ quicksort maiores
    where
        menores = filter (< h) t -- (<h) é o mesmo que \y -> y < h
        maiores = filter (>= h) t -- (>=h) é o mesmo que \y -> y >= h


somat :: [Integer] -> Integer
somat = foldl (+) 0
produt :: [Integer] -> Integer  
produt = foldl (*) 1 
append :: [[a]] -> [a]
append = foldr (++) []
quadlista :: [Integer] -> [Integer] 
quadlista = map (^2) 
