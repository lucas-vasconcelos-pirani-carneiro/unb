filtro p (x:xs)
       | p x       = x:filtro p xs
       | otherwise = filtro p xs
filtro _ [] = []

par x = x `mod` 2 == 0