# Strings e Entradas/Saídas

## String
- É uma **lista de caracteres**.
    - `type String = [Char]`, é um tipo **sinônimo**.
- Strings podem ser abreviadas envolvendo os caracteres por aspas.
    - `" string"` abrevia a notação `[' ', 's', 't', 'r', 'i', 'n', 'g']`.
- **Todas** as operações para <u>lista</u> se aplicam a <u>strings</u>.

### Strings e I/O
- String são **objetos visíveis**: Podem ser <u>lidos ou impressos</u>.
- Ou seja, podem ser usadas em operações de entrada e saída (I/O).

```haskell
-- putStr: escreve uma mensagem no console (sem quebra de linha)
-- putStrLn: escreve com quebra de linha
-- getLine: lê uma linha digitada pelo usuário

ghci> let leia = do
           putStr "Informe uma String: "
           str <- getLine
           putStr str
       in leia

Informe uma String: Lucas
Lucasghci>

ghci> putStr "Lucas"
Lucasghci>

ghci> putStrLn "Lucas"
Lucas

-- Outra maneira de escrever a mesma coisa
ghci> let { leia = do putStr "Informe uma String: "; str <- getLine; putStr str } in leia
Informe uma String: Lucas
Lucasghci>

ghci> putStr "Lucas"
Lucasghci>
ghci> putStr "Lucas\n"
Lucas
```

- Qualquer objeto para ser impresso deve antes ser **convertido** em string.
- Funções como `putStr` e `putStrLn` exigem uma `String`
- Para imprimir outros tipos, usamos `show`
- Para converter uma `String` em um valor, usamos `read`

```haskell
-- show: converte um valor em String
-- read: converte uma String em valor (precisa do tipo)

ghci> putStrLn (show [1..5])
[1,2,3,4,5]

ghci> show ([1..5])
"[1,2,3,4,5]"

ghci> show (2,3,4)
"(2,3,4)"

ghci> read "[1,2,3,4]" :: [Int]
[1,2,3,4]

ghci> read "[('a','b',4.5),('c','d',6.0)]" :: [(Char,Char,Float)]
[('a','b',4.5),('c','d',6.0)]
```

### Exemplos de Entrada/Saída

```haskell
-- Leitura de string com repetição

entrada = do
    putStr "\ndados> "
    dados <- getLine
    putStrLn ("Digitado: " ++ dados)
    putStr "continua (s/n)? "
    carac <- getChar
    if carac `elem` "sS"
        then entrada
        else return ()

-- Execução
ghci> entrada

dados> Lucas
Digitado: Lucas
continua (s/n)? s
dados> Vasconcelos
Digitado: Vasconcelos
continua (s/n)? S
dados> Pirani
Digitado: Pirani
continua (s/n)? nghci> 

-- Leitura de caractere e código ASCII
-- Lê o caractere e mostra o seu número na tabela ASCII
-- Se clicar no ESC sai do programa
import Data.Char (ord)
tecla = do
    putStr "Qual a tecla?: "
    carac <- getChar
    putStrLn (show (ord carac))
    if carac == '\ESC'
        then return ()
        else tecla

-- Execução
ghci> tecla
Qual a tecla? > a97
Qual a tecla? > A65
Qual a tecla? > z122
Qual a tecla? > Z90
Qual a tecla? > ^[27
```
