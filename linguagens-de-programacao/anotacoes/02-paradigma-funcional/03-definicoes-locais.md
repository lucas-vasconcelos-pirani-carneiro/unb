# Definições Locais

## Where
- Em várias situações, desejamos definir **valores e funções auxiliares** em uma definição principal. Isso pode ser feito, em `Haskell`, através da cláusula `where`.
- A cláusula `where` traz **definições locais** para uma equação, ou seja, o escopo das **definições trazidos** por ela se limita apenas à equação que a contém.
- expressão `where` definição.
- **Exemplo:**  Considere, por exemplo, que queiramos calcular a área de triângulo de lados a, b e c, através da fórmula de Heron, dada por: 
$$
A = \sqrt{ S \cdot (S - a) \cdot (S - b) \cdot (S - c) }, \\
\text{ onde $S$ é o semiperímetro do triângulo:} \\
S = \frac{a + b + c}{2}  
$$

```haskell
-- Formula de Heron com Where
areaHeron :: Float -> Float -> Float -> Float
areaHeron a b c = sqrt (s * (s - a) * (s - b) * (s - c))
    where 
        s = (a + b + c) / 2 -- Definição local do Semiperimetro

-- Execução
ghci> areaHeron 4 5 6
9.921567
ghci> areaHeron 20 20 15
139.05373
```

### Exemplos

```haskell
-- Utilizando Guardas
funcao :: Int -> Int -> Int
funcao x y 
    | x <= 10 = x + a
    | otherwise = x - a
    where
        a = (y + 1)^2
```

```haskell
outrafuncao :: Int -> Int
outrafuncao y = 3 + func y + func a + func b
    where
        func x = x + 7*c -- Define uma outra função local
        a = 3*c -- Define o valor de com expressões
        b = func 2 -- Define o valor com a chamada da função
        c = 10 -- define valor fixo
```

### Exercício - Bhaskara

```haskell
-- Bhaskara com Where
bhaskara :: Float -> Float -> Float -> Int
bhaskara a b c 
    | delta > 0 = 2
    | delta == 0 = 1
    | otherwise = 0
    where   
        delta = b^2 - 4 * a * c

-- Execução
ghci> bhaskara 1 (-5) 6
2
ghci> bhaskara 1 4 4
1
ghci> bhaskara 1 4 40
0
```

## Let
-  Também é possível fazer definições locais escrevendo-se uma expressão `let`, formada por uma **lista de definições** e um **corpo** (que é uma expressão), introduzidos pelas palavras `let` e `in`.
-  `let` definições `in` expressão.
- O **escopo** dos <u>nomes definidos</u> na expressão `let` se **restringem** à própria expressão e podem ser utilizados no **corpo** da expressão `let` e nas **definções locais** da expressão `let`.
- **Exemplos:**

```haskell
ghci> let x = 4 + 6 in x^2 + 2*x -4
116
ghci> let x = 3 + 2; y = 5 - 1 in x^2 + 2*x -y 
31
ghci> let quadrado x = x^2 in quadrado 5 + quadrado 4
41
ghci> let soma a b = a + b in soma 12 15
27
```

- Exemplo: Calcular a área da superfície de um cilindro

```haskell
-- Área da superfície de um cilindro com let
areaCilindro :: Float -> Float -> Float
areaCilindro r h =
    let areaLado = 2 * pi * r * h
        areaBase = pi * r^2
    in areaLado + 2 * areaBase

-- Execução
ghci> areaCilindro 10 10
1256.6371
ghci> areaCilindro 2 10
150.79645
```

## Diferenças 
- Com `where`, as definições são colocadas no final e, com `let` elas são colocadas no início.
- `let` é uma **expressão** e pode ser utilizada em qualquer lugar onde se espera um expressão.
- Já o `where` não é uma expressão, podendo ser utilizada apenas para fazer **definições locais** em uma definição de função.

```haskell
-- Heron com let
areaHeron :: Float -> Float -> Float -> Float
areaHeron a b c = 
    let s = (a + b + c) / 2
    in sqrt( s * (s - a) * (s - b) * (s - c) )

-- Execução
ghci> areaHeron 4 5 6
9.921567
ghci> areaHeron 20 20 15
139.05373
```
