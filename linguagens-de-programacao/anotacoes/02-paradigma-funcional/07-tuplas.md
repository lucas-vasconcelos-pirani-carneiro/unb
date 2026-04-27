# Tuplas

- Uma tupla em `Haskell` é uma coleção de valores que podem ou não ter tipos diferentes (parecidos com uma struct em C/C++).
- É uma estrutura do tipo **registro**.
- Uma **relação** fixa de campos de tipos quaisquer.

> [!WARNING]
>
> <u>Tuplas</u> diferentemente das <u>listas</u> **não** precisam ser **homogêneas!!**.

- Se $t_1, t_2, \ldots t_n$ são tipos, então o tipo da n-tupla é $(t_1, t_2, \ldots, t_n)$.
- Os valores são colocados entre **parênteses** e separados por vírgulas.
- Exemplo:

```haskell
("John", 12345)
(("Nome", "Leda"), "mulher", "casada", ("idade", 62))
(5, [1,2,3], "Brasília")
```

- Valores de tuplas são definidos de maneira **semelhante às listas**, mas com a utilização de parênteses `()` ao invês de colchetes `[]`.
- Além disso, uma tupla pode conter valores de **tipos diferentes**, enquanto uma lista não.
- **A ordem dos elementos importa**, de maneira que a tupla `(12345, "John")` é diferente da mostrada acima.
- Quando uma tupla possui dois membros, ela é chamada de **"par"** ou **2-upla**.
- Existem funções para acessar o **primeiro** elemento de um par (`fst`) e o **segundo** elemento de um par (`snd`). 

```haskell
ghci> fst ("John", 12345)
"John"
ghci> snd ("John", 12345)
12345
```

- As funções `fst` e `snd` somente funcionam para pares.

```haskell
-- Erro
ghci> fst ("John", 12345, 'B')

<interactive>:47:5: error: [GHC-83865]
    • Couldn't match expected type: (a, b0)
                  with actual type: (String, b1, Char)
    • In the first argument of ‘fst’, namely ‘("John", 12345, 'B')’
      In the expression: fst ("John", 12345, 'B')
      In an equation for ‘it’: it = fst ("John", 12345, 'B')
    • Relevant bindings include it :: a (bound at <interactive>:47:1)
```

- Para desenvolver um sistema acadêmico de notas, por exemplo, é ncessário manipular informações sobre alunos.
- **Exemplo:**

```haskell
type NomeAluno = String
type MediaNota = Int
type Aluno = (NomeAluno, MediaNota) -- nome, nota

type Turma = [Aluno]

aprovados :: Turma -> Int -> [NomeAluno]
aprovados tma nota = [nome | (nome, media) <- tma ,media >= nota]

-- Execução
ghci> turma = [("Joao", 9), ("Pedro", 5), ("Maria", 6), ("Jose", 7)]
ghci> aprovados turma 6
["Joao","Maria","Jose"]
```

- O uso da palavra reservada `type` na definição da tupla permite a criação de um **sinônimo** de um tipo.
- Sua utilzação **não cria um novo tipo**, <u>apenas dá um novo nome a tipos já existentes</u>, tornando o programa mais legível.
- Com base na definição do tipo Aluno, podemos elaborar funções para acessar os elementos da tupla, utilizando **casamento de padrões**.

## Exercício
1. Crie a representação de um ponto de três dimensões `(x,y,z)`. Apresentação deve ser realizada por de uma tupla e a definição de um novo tipo.
2. Escreva uma função que calcula a distância entre dois pontos passados como argumentos. 

```haskell
type Ponto = (Float, Float, Float)

distancia :: Ponto -> Ponto -> Float
distancia (x1, y1, z1) (x2, y2, z2) = sqrt ( dx^2 + dy^2 + dz^2 )
    where
        dx = x1 - x2
        dy = y1 - y2
        dz = z1 - z2

-- Execução
ghci> p1 = (0, 0, 1)
ghci> p2 = (0, 0, 0)
ghci> distancia p1 p2
1.0
ghci> p2 = (0, 1, 0)
ghci> distancia p1 p2
1.4142135
ghci> distancia (10,5,7) (9, 1, 8)
4.2426405
```
