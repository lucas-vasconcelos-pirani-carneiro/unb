let { leia = do
	putStr "informe uma string >";
	str <- getLine; putStr str}
in leia