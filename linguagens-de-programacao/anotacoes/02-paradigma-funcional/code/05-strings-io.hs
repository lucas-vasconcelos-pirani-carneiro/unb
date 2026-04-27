import Data.Char (ord, chr)

entrada = do
    putStr "\ndados> "
    dados <- getLine
    putStr "Digitado: "
    putStr (dados ++ "\n")
    putStr "continua (s/n)? "
    carac <- getChar
    if carac == 'S' || carac == 's'
        then entrada
        else return ()

tecla = do
    putStr "Qual a tecla?: "
    carac <- getChar
    putStr (show (ord carac))
    if carac == '\ESC'
        then return ()
        else tecla
