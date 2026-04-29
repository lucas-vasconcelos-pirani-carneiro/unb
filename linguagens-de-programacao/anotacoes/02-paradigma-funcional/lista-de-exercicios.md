# Lista de Exercício - Haskell/Hugs

> [!NOTE]
>
> O valor entre parênteses ilustra o **grau de dificuldade** da tarefa.

### 1. Escreva uma função que receba uma lista de 4 elementos e verifique se todos os elementos são iguais. (1,0)
- Usar recursão onde os casos bases seriam se a lista está vazia retorna `True` ou se a lista tem um elemento também retorna `True`.
- Se a lista tiver cabeça e cauda, então verifica-se se o primeiro elemento é **diferente** so segundo elemento se isso for verdade então retorna `False`, caso contrário **continua a busca na lista** passando, por meio da recursão, a lista iniciando com segundo elemento, será usado para comparar com o próximo elemento, e a cauda. 

```haskell
elemIguais :: [Int] -> Bool
elemIguais [] = True
elemIguais [_] = True
elemIguais (h1:h2:t)
    | h1 /= h2 = False
    | otherwise = elemIguais (h2:t)

-- Execução
ghci> elemIguais []
True
ghci> elemIguais [1]
True
ghci> elemIguais [1,2,1,1]
False
ghci> elemIguais [1,1,1,2]
False
ghci> elemIguais [2,1,1,1]
False
ghci> elemIguais [1,1,2,1]
False
ghci> elemIguais [1,1,1,1]
True
```

### 2. Escreva uma função que calcule o resto de uma divisão de dois números inteiros. (0,5)
- Existem diversas formas de fazer usando a função `mod` já disponível.
- Podemos usar `mod` como função ou operador e também aplicá-la diretamente na console. 

```haskell
-- mod como Função
restoDiv :: Int -> Int -> Int
restoDiv n1 n2 = mod n1 n2

-- mod como operador
restoDiv :: Int -> Int -> Int
restoDiv n1 n2 = n1 `mod` n2

-- Execução
ghci> restoDiv 3 2
1
ghci> restoDiv 6 2
0
ghci> restoDiv 2 6
2
ghci> restoDiv 200 23
16

-- Usando a função mod diretamento no console
ghci> mod 3 2
1
ghci> mod 6 2
0
ghci> mod 2 6
2
ghci> mod 200 23
16
```

### 3. Utilize recursão para criar uma função que calcule $2^n$. (0,5)
- Nesse caso, a **base da recursão** será quando `n == 0` retornando `1`, e o caso recursivo será multiplicando por 2 e passando como recursão a função da potência passando como parâmetro `(n-1)`.
- Ela **repete** esse processo até chegar o caso base.

```haskell
pot2 :: Int -> Int
pot2 0 = 1
pot2 n = 2 * pot2(n-1)

-- Usando Guardas
potencia2 :: Int -> Int
potencia2 n
    | n == 0 = 1
    | n > 0 = 2 * potencia2 (n-1)

-- Execução
ghci> potencia2 0
1
ghci> potencia2 2
4
ghci> potencia2 5
32
ghci> potencia2 8
256
ghci> potencia2 10
1024
ghci> pot2 0
1
ghci> pot2 1
2
ghci> pot2 4
16
ghci> pot2 7
128
ghci> pot2 10
1024
```

### 4. Escreva uma função que calcule o dobro da soma dos elementos de uma lista. (0,5)
- Aqui fica muito mais fácil se utilizar a função `sum` que retorna a soma dos elementos de uma lista e depois **multiplicá-los por 2**, podendo fazer até mesmo direto no console.

```haskell
somaDobro :: [Int] -> Int
somaDobro lista = 2 * sum lista -- Ou, = 2 * foldl1 (+) lista

-- Execução
ghci> somaDobro []
0
ghci> somaDobro [1,2,3]
12
ghci> somaDobro [1..10]
110
ghci> somaDobro [2,4..10]
60
ghci> 2 * sum []
0
ghci> 2 * sum [1,2,3]
12
ghci> 2 * sum [1..10]
110
ghci> 2 * sum [2,4..10]
60
```

### 5. Crie uma função que retorne a lista de todos os divisores de um dado número. (1,0)
- Aqui o jeito mais fácil talvez seja usando **Lista por Compreensão**.Ou seja, vamos criar uma lista com elementos x tal que x está no intervalo de 1 até n e `n mod x == 0`.

```haskell
divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], n `mod` x == 0]

-- Execução
ghci> divisores 36
[1,2,3,4,6,9,12,18,36]
ghci> divisores 13
[1,13]
ghci> divisores 100
[1,2,4,5,10,20,25,50,100]
```

### 6. Escreva uma função que verifique se duas listas possuem os mesmos elementos (a ordem não importa). (1,0)

- A ideia que eu tive seria usar recursão para percorreer os elementos da lista 1 e ir comparando se a lista 2 também os possui.
- Caso base: Se ambas as lista forem vazias retornam True
    - Se a lista 1 for vazia e a lista 2 tiver cabeça e cauda retorna False.
    - Se a lista 2 for vazia e a lista 1 tiver cabeça e cauda retorna False.
- Caso Recursivo: Se a lista 1 e a lista 2 tiverem cabeça e cauda, reria algumas opções:
    - Se a cabeça da lista 1 for igual a cabeça da lista 2 chamo a função recursivamente para cauda da lista 1 e para cauda da lista 2 
    - Verifico usando a função elem se cabeça da lista 1 é um elemento da lista 2 se sim chamo a função recursivamente passando a cauda da lista 1 e o parâmetro eu passo uma função que remove a primeira ocorrência de um número em uma lista e retorna a lista sem esse elemento.
    - caso contrário retorna False.
-  A função removerElem funcionaa da seguinte maneira: Utiliza recursão para ir procurando o elemento a ser removido.
    - Se o elemento passado não está na lista retorna a lista sem nenhuma alteração.
    - Se a lista for vazia retorna a lista vazia.
    - Se a lista tiver cabeça e cauda, então verifica se a cabeça é igual ao elemento que queremos remover se sim retorna a cauda da lista.
    - Caso contrário, fazemos a composição/construção da cabeça da lista com a chamada recursiva da função passando o elemento a ser removido e a cauda da lista, vamos procurando o elemento a ser removido e mantendo a lista original.

```haskell
removerElem :: Int -> [Int] -> [Int]
removerElem _ [] = []
removerElem n (h:t)
    | n == h    = t
    | otherwise = h : removerElem n t

listasIguais :: [Int] -> [Int] -> Bool
listasIguais [] [] = True
listasIguais [] _  = False
listasIguais (h:t) ys
    | h `elem` ys = listasIguais t (removerElem h ys)
    | otherwise   = False

-- Execução
ghci> listasIguais [] []
True
ghci> listasIguais [1] []
False
ghci> listasIguais [] [1]
False
ghci> listasIguais [1,2,3] [1,2,3]
True
ghci> listasIguais [1,2,3] [1,2,3,3]
False
ghci> listasIguais [1,2,3,3] [1,2,3]
False
ghci> listasIguais [1,3,2] [1,2,3]
True

-- Uma outra forma mais fácil porém precisa de bibliotecas externas
import Data.List (sort)
listasIguais xs ys = sort xs == sort ys
```

7.	Escreva uma função que retorne o número de vezes que um dado elemento aparece numa lista. (1,0)

```haskell
```

8.	Escreva uma função que receba uma lista de números e retorne uma tupla com uma lista dos números pares e uma lista dos números ímpares.          (1,5) 
Ex:  funcao [1,2,3]
	([2],[1,3])

```haskell
```

9.	Escreva uma função que verifique se um ano é bissexto. (0,5)

```haskell
```

10.	Escreva uma função que verifique se um ponto (x,y) está dentro de uma circunferência de raio R e com centro localizado num ponto (a,b).          (1,0)
11.	Crie uma função que gere os números primos menores que um dado número    (2,5)
12.	Escreva uma função que receba uma lista e a transforme em palíndrome.     (1,0) 
Ex: transforma [1,2]
	[1,2,2,1]
13.	Escreva uma função que receba uma lista e retorne o número de elementos que estão acima da média dos valores da lista.            (2,0)
14.	Escreva uma função que receba os coeficientes “a”, “b” e “c” da entrada padrão (teclado) e calcule as raízes da equação ax2+bx+c.           (2,0)
15.	Escreva uma função que receba uma lista e retorne a posição de um dado elemento nessa lista, iniciando da posição 0.           (1,0)
16.	Escreva uma função que receba uma string com o nome de um arquivo e retorne a extensão daquele arquivo (considere que a extensão vem depois do último ponto).
Ex: extensao “prova_de_hugs.doc.pdf”        (1,5)
	“.pdf”
extensao “unknown”
	(Você decide)
17.	Escreva uma função que encontre todos os nomes em uma dada frase, começando com letra maiúscula, e o restante do nome em letra minúscula.        (1,5)
18.	Escreva uma função que quebre uma string em duas partes no ponto onde estiver uma “/” e retorne uma tupla com as duas partes.          (2,0)
Ex: quebra “oi/tudo bem?”
	(“oi”, “tudo bem?”)
quebra “/tudo bem”
	([],”tudo bem”)
19.	Crie uma função que substitua uma dada palavra por outra em uma frase. Se a palavra não estiver contida na frase, deverá retornar a frase original.         (1,5)
Ex: subs “Senna” “Vettel” “Senna é o tricampeão de Fórmula 1 mais jovem!”
	“Vettel é o tricampeão de Fórmula 1 mais jovem!”

