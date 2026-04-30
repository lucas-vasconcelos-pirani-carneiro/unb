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

### 7. Escreva uma função que retorne o número de vezes que um dado elemento aparece numa lista. (1,0)
- Aqui podemos fazer uma busca recursiva na lista, em que temos como caso base da recursão a lista sendo vazia e um número qualquer retornando 0.
- E para o caso recursiva precisamos verificar se a cabeça da lista é igual ao número que estamos procurando se sim retornamos 1 + a busca recursiva pela ocorrência dos outros elementos pela cauda da lista.

```haskell
apareceLista :: [Int] -> Int -> Int
apareceLista [] _ = 0
apareceLista (h:t) n 
    | h == n = 1 + apareceLista t n
    | otherwise = apareceLista t n

-- Execução
ghci> apareceLista [] 1
0
ghci> apareceLista [1,1,1,1,1,1] 1
6
ghci> apareceLista [1..5] 1
1
ghci> apareceLista [1,2,1,2,1,2,1] 1
4
ghci> apareceLista [2,2,2,2,1,1,1] 1
3
```

### 8. Escreva uma função que receba uma lista de números e retorne uma tupla com uma lista dos números pares e uma lista dos números ímpares. (1,5) 
```haskell
-- Exemplo:
ghci> funcao [1,2,3]
ghci> ([2],[1,3])
```

- Aqui precisamos primeiramente criar o tipo da tupla que tem como primeiro e segundo elementos listas de inteiros.
- Depois, criamos uma função que recebe uma lista de inteiros e retorna essa tupla.
- A ideia seria fazer uma busca recursiva, onde teríamos como base uma lista vazia que retornaria uma tupla com listas vazias ( [], [] ).
- Já para o caso recursivo, precisamos chamar a função para a cauda da lista (t), que irá retornar uma tupla contendo a lista de pares e a lista de ímpares.
- Então, devemos desempacotar essa tupla para obter (pares, impares) e, a partir disso, verificar se a cabeça (h) é par ou ímpar:
- Se for par, adicionamos h à lista de pares. Caso contrário, adicionamos h à lista de ímpares.
- Por fim, reconstruímos a tupla com os novos valores.

```haskell
type TuplaDeLista = ([Int], [Int])
funcao :: [Int] -> TuplaDeLista
funcao [] = ([],[])
funcao (h:t) 
    | even h = (h: pares, impares)
    | otherwise = (pares, h: impares)
    where 
        (pares, impares) = funcao t

-- Execução
ghci> funcao [1..10]
([2,4,6,8,10],[1,3,5,7,9])
ghci> funcao [1,3..10]
([],[1,3,5,7,9])
ghci> funcao [2,4..10]
([2,4,6,8,10],[])
ghci> funcao []
([],[])
```

### 9. Escreva uma função que verifique se um ano é bissexto. (0,5)
- Para um ser Bissexto é preciso que ele seja divísivel por 4 e ao mesmo tempo não seja divisível por 100 ou que ele seja divisível por 400.

```haskell
ehBissexto :: Int -> Bool
ehBissexto n = if (n `mod` 4 == 0 && n `mod` 100 /= 0) || (n `mod` 400 == 0) then True else False 

-- Outra forma
ehBissexto :: Int -> Bool
ehBissexto n = (n `mod` 4 == 0 && n `mod` 100 /= 0) || (n `mod` 400 == 0)  

-- Execução
ghci> ehBissexto 2016
True
ghci> ehBissexto 2020
True
ghci> ehBissexto 2022
False
ghci> ehBissexto 2021
False
ghci> ehBissexto 1999
False
ghci> ehBissexto 2000
True
ghci> ehBissexto 2002
False
```

### 10.	Escreva uma função que verifique se um ponto (x,y) está dentro de uma circunferência de raio R e com centro localizado num ponto (a,b). (1,0)
- Aqui primeiramente devemos usar uma tupla para criar um ponto (x,y).
- Ainda precisamos saber da fôrmula da circunferência da geometri analítica que é: $(x - a)^2 + (y - b)^2 = r^2$, onde $a,b$ são coordenadas do Centro.
- Além disso precisamps saber que a posição de um ponto $(x,y)$ está dentro da circunferência se $(x - a)^2 + (y - b)^2 < r^2$

```haskell
type Ponto = (Float, Float)
estaNaCirc :: Ponto -> Ponto -> Float -> Bool
estaNaCirc (x,y) (a,b) r
    |  (x - a)^2 + (y - b)^2 < r^2 = True
    | otherwise = False

-- Outra forma 
type Ponto = (Double, Double)
dentroCirc :: Ponto -> Ponto -> Double -> Bool
dentroCirc (x,y) (a,b) r =
    (x - a)^2 + (y - b)^2 <= r^2

-- Execução
ghci> dentroCirc (1,2) (0,0) 2
False
ghci> dentroCirc (1,1) (0,0) 2
True
```

### 11.	Crie uma função que gere os números primos menores que um dado número. (2,5)
- A ideia aqui é usar a função filter onde passamos como parâmetro uma função que verifica se um número é primo ou não em cima de uma lista que vai de [1..n], onde n é o dado número que queremos saber os primos menor que eles.
- A função para determinar se um número é primo ou não foi pensada da seguinte maneira: utilizamos a propriedade que os números só possuem dois divisores 1 e ele mesmo então geramos uma lista com todos os divisores de um determinado número n usando o operador mod e verificamos se essa lista tem tamanho 2, se sim retorna True, ou seja, n é um número primo. Caso contrário, retorna False. 

```haskell
isPrime :: Int -> Bool
isPrime n 
    | length [x | x <- [1..n], n `mod` x == 0] == 2 = True
    | otherwise = False

listaPrimos :: Int -> [Int]
listaPrimos n = filter isPrime [1..n]

-- Execução
ghci> listaPrimos 20
[2,3,5,7,11,13,17,19]
ghci> listaPrimos 50
[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
ghci> listaPrimos 100
[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
```

### 12.	Escreva uma função que receba uma lista e a transforme em palíndrome. (1,0) 
- Para poder transforma uma lista em um palíndromo, acredito que a maneira mais fácil seja concatenar a lista original com a sua lista reversa.
- Para isso podemos usar a função nativa `reverse` e o operador `++` do `Haskell`.

```haskell
-- Exemplo: 
ghci> transforma [1,2]
ghci> [1,2,2,1]
```

```haskell
transforma :: [Int] -> [Int]
transforma lista = lista ++ reverse lista 

-- Solução que evita duplicar o meio
transforma :: [Int] -> [Int]
transforma lista = lista ++ reverse (init lista) 
-- Init: "Cauda ao contrário" retorna a lista sem o seu último elemento

-- Execução
ghci> transforma [1,2]
[1,2,2,1]
ghci> transforma [1,2,2,2]
[1,2,2,2,2,2,2,1]
ghci> transforma [1,2,1,2]
[1,2,1,2,2,1,2,1]
ghci> transforma []
[]
ghci> transforma [1]
[1,1]
```

### 13.	Escreva uma função que receba uma lista e retorne o número de elementos que estão acima da média dos valores da lista. (2,0)
- A ideia aqui seria somar todos os elemetos, usando o `sum`, de da lista dividir pelo seu comprimento, usando o `length`, para obtermos a média e 
depois , usando a função `filter`, filtrar todos os elementos maiores que a média.
- O problema é que o haskell não consegue fazer divisão por inteiro que pode retorna `Float`.
- Ao invês de passar a media como parâmetro da função `filter`, vamos passar uma **função anônima** que para cada `elemento x` verifica-se se `x * n > s`,
onde `s` é a **soma dos valores** dos elementos da lista e `n` o **comprimento** da lista.
- Logo, se `x * n` for maior que `s` siginifica que o elemento x da lista é maior que a média.

```haskell
acimaMedia :: [Int] -> [Int]
acimaMedia [] = []
acimaMedia lista = filter (\x -> x * n > s) lista
    where
        s = sum lista
        n = length lista

-- Execução
ghci> acimaMedia [1..10]
[6,7,8,9,10]
ghci> acimaMedia [2,4,3,6,8,9,11,05,34,0,7,8]
[9,11,34]
```

### 14.	Escreva uma função que receba os coeficientes $a,b, \text{e } c$, “b” e “c” da entrada padrão (teclado) e calcule as raízes da equação $ax^2 + bx +c$. (2.0)
- Fazer usando let e where, 
- como vamos realizar calculo e mostrá-los depois é preciso fazer as conversões de tipos usando read String -> Float, e show Double -> String

```haskell

```

### 15.	Escreva uma função que receba uma lista e retorne a posição de um dado elemento nessa lista, iniciando da posição 0. (1,0)
- Aqui acabei fazendo uma gambiarra no código. Primeiramente temos uma função que verfica se o elemento que procuramos está na lista ou não usando a função `elem` disponibilizada nativamente no `Haskell`.
- Se o elemento está na lista então chamo uma função que busca pela posição do elemento na lista de forma recursiva, caso contrário retorno -1 para demostrar que o elemento não está na lista.
- A função recursiva foi feita da seguinte maneira como caso base temos uma lista vazia que retorna 0, e caso recursivo e dado da seguinte forma: 
    - se a cabeça for igual ao elemento procurado = retornamos caso base, ou seja, chamamos a função de forma recursiva passando como parâmetro o elemento procurado e a lista vazia
    - Caso contrário, continuamos a busca pela posição do elemento de forma recursiva somando 1 e chamando a função recursivamente passando como parâmetro o elemento procurado e a cauda da lista.

```haskell
posicaoRec :: Int -> [Int] -> Int
posicaoRec _ [] = 0 
posicaoRec n (h:t)
    | h == n = posicaoRec n []
    | h /= n = 1 + posicaoRec n t

posicao :: Int -> [Int] -> Int
posicao n lista = 
    if n `elem` lista
        then 
            posicaoRec n lista
        else -1

-- Execução
ghci> posicao 5 [1..10]
4
ghci> posicao 0 [1..10]
-1
ghci> posicao 1 [1..10]
0
ghci> posicao 10 [1..10]
9
```

### 16.	Escreva uma função que receba uma string com o nome de um arquivo e retorne a extensão daquele arquivo (considere que a extensão vem depois do último ponto). (1,5)

```haskell
-- Exemplo
extensao “prova_de_hugs.doc.pdf”        
".pdf"
extensao “unknown”
-- (Você decide)
```

```haskell

```


### 17.	Escreva uma função que encontre todos os nomes em uma dada frase, começando com letra maiúscula, e o restante do nome em letra minúscula. (1,5)

```haskell

```

### 18.	Escreva uma função que quebre uma string em duas partes no ponto onde estiver uma "/" e retorne uma tupla com as duas partes. (2,0)
- Ir fazendo composição até encontrar o simbolo '/'
- usar a função que encontrar a posição porém para lista de Char ou seja String

```haskell
-- Exemplo: 
quebra "oi/tudo bem?"
("oi", "tudo bem?")

quebra "/tudo bem"
([],"tudo bem")
```

```haskell

```

### 19.	Crie uma função que substitua uma dada palavra por outra em uma frase. Se a palavra não estiver contida na frase, deverá retornar a frase original. (1,5)

```haskell
-- Exemplo: 
subs "Senna" "Vettel" "Senna é o tricampeão de Fórmula 1 mais jovem!"
"Vettel é o tricampeão de Fórmula 1 mais jovem!"
```
