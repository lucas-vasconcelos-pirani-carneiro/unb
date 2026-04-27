# Introdução - Haskell/Hugs

## Linguagens Declarativas e Paradigma Funcional
- Linguagens **declarativas**, como as **funcionais**, focam no **processamento simbólico** e em listas. Seu bloco básico de construção são as **funções**, que declaram o problema por meio de sua **especificação**, sem resolver passo a passo. Elas implementam <u>funções complexas, metaprogramas e tratam símbolos e operações da lógica matemática</u> com **facilidade**.
- A programação funcional **imita** <u>funções matemáticas</u>, mapeando entradas (domínio) para saídas (imagem).   
- **Características fundamentais:**
  - Não há noção de **estado** nem **comandos de atribuição**.
  - O resultado de uma função depende **apenas dos argumentos** (transparência referencial): 
    - Chamadas idênticas sempre produzem o mesmo ***output***.
  - Isso difere de paradigmas imperativos, onde estado local/global afeta o resultado.

- Exemplos de linguagens: `LISP`, `Scheme`, `ML`, `OCaml` e `Haskell`.

### Funções Matemáticas como Base
- Uma função típica, como o quadrado: $Square(n) = n \times n$
  - **Nome:** Square.
  - **Argumentos:** $n$, do domínio.
  - **Definição:** $n \times n$, gera valores na imagem ou contradomínio.

- Matematicamente: $f: A \to B, y = f(x), \text{ onde } y = f(x)$ mapeia dados de $A$ para $B$.

### Diferença Semântica do `=`
- O sinal de igual tem significados distintos entre paradigmas.

#### Programação Imperativa
- **Representa atribuição:** Atualiza uma célula de memória, **mudando o estado** (l-value = memória, r-value = valor).

```c
x = x + 1  // x recebe o valor x + 1
```

#### Programação Funcional
- Representa **equivalência**: Variáveis são expressões imutáveis.
- Sinal de **reescrita** o que tiver ao lado direito será **substituindo** pelo o que está no lado esquerdo, reduzindo a complexidade.

```haskell
quadrado num = num * num  -- quadrado de num É num * num
```

- Linguagens funcionais baseiam-se no <u>cálculo lambda</u>, com:
  - Funções primitivas.
  - Formas funcionais para compor funções complexas.
  - Operação de aplicação de função.
  - Estruturas para representar dados.

## Introdução à Linguagem Hugs98

- **Referência:** Hugs98 User Manual
  **Autores:**
  - Mark P. Jones
  - John C. Peterson
- https://www.haskell.org/hugs/

### Ambiente Hugs
- É um interpretador com o ciclo que lê, avalia e exibe resultados.
- **Funções primitivas:** Lidas do `Prelude`.
  - Se a função está no preludio ela pode executa-la.

- **Funções globais:** São visíveis, ocupam espaços na memória.
- **Funções locais:** Não permanecem na memória, são usadas e descartadas.
- As funções são definidas pelo usuário e carregadas de um **arquivo de texto**.
- **Ordem de execução** são as chamadas das <u>funções</u>.


- Interpretador:

![interpretador-hugs](../img/02-haskell_hugs/interpretador-hugs.png)

### Comandos do Prelude (Hugs)

| Comando               | Descrição                                                |
| --------------------- | -------------------------------------------------------- |
| `:?`                  | Exibe a lista de comandos disponíveis                    |
| `:type <expr>`        | Mostra o tipo de uma expressão                           |
| `:load <filenames>`   | Carrega módulos/arquivos especificados                   |
| `:also <filenames>`   | Carrega arquivos adicionais sem remover os já carregados |
| `:reload`             | Recarrega o último conjunto de arquivos                  |
| `:project <filename>` | Usa um arquivo de projeto                                |
| `:edit <filename>`    | Abre um arquivo para edição                              |
| `:edit`               | Edita o último módulo utilizado                          |
| `:browse <modules>`   | Lista nomes definidos em um módulo                       |
| `:find <name>`        | Abre o arquivo contendo a definição do nome              |
| `:names [pat]`        | Lista nomes atualmente no escopo                         |
| `:info <names>`       | Mostra informações sobre nomes                           |
| `:module <module>`    | Define o módulo para avaliação de expressões             |
| `<expr>`              | Avalia uma expressão                                     |
| `:set <options>`      | Define opções da linha de comando                        |
| `:set`                | Mostra opções atuais                                     |
| `:! <command>`        | Executa comando do sistema (shell)                       |
| `:cd <dir>`           | Muda o diretório atual                                   |
| `:gc`                 | Força coleta de lixo                                     |
| `:version`            | Mostra a versão do Hugs                                  |
| `:quit`               | Sai do interpretador                                     |


## A Linguagem Haskell
- `Haskell` surgiu em 1987, liderado por **Simon Peyton Jones**, e se consolidou como uma das principais linguagens funcionais. Ela suporta programas de <u>grande porte com eficiência</u> e resolve problemas da indústria e academia.
- Em `Haskell`, toda expressão lambda recebe um nome e tem seu tipo explícito indicado: 
  - Tipos do Domínio (**argumentos**) e Imagem (**retorno**). 
- **Exemplo teórico:** : $\lambda x. (x^2 + 10x + 2)$

### Exemplos
```haskell
-- primeiro programa em haskell
polinomio :: Int -> Int
polinomio x = x*x + 10*x + 2

-- calcula o quadrado de um numero
square :: Int -> Int
square n = n * n

-- soma
soma :: Float -> Float -> Float
soma a b = a + b

-- triplica
triplica :: Int -> Int
triplica var = 3*var

-- calcula o mdc
mdc :: Int -> Int -> Int
mdc a 0 = a
mdc a b = mdc b (a `mod` b)

-- Execução
ghci> polinomio 2
26
ghci> polinomio 10
202
ghci> quadrado 12
ghci> square 12
144
ghci> soma 3.4523 5.9812
9.4335
ghci> triplica 5
15
```

### Sintaxe e Convenções
- `Haskell` é **puramente funcional** e segue regras simples:
  - **Verificação dinâmica:** Tipos podem ser inferidos, não sempre explícitos.
  - `=`: Sinal de **reescrita**, equivalência.
  - Os **argumentos** separados por **espaços em branco**.
  - Letra **minúscula**: <u>Variáveis/funções</u>. 
    - Ex: x, polinomio.
  - Letra **maiúscula**: <u>Construtores/tipos</u>.
    - Ex: `Int`, `Maybe`.
  - `` ` `` : **Transforma** função em **operador** 
    - Ex: mod $\rightarrow$ a mod b.

> [!NOTE]
> 
> - Todas as definições devem ter a mesma indentação.
> - Hugs/GHCI funciona como matemática: f x = x + 1 significa "troque f x por x + 1 sempre".

### Reescrita e Avaliação
  - **Reescrita:** Transforma termos em equivalentes, base da avaliação de expressões.
  - Programas funcionais **executam** por redução/reescrita de termos.
 
## Tipos de Dados

### Booleano

```haskell
(&&), (||) :: Bool (Argumento) -> Bool -> Bool 
-- &&, ||: Assinatura da função
-- () é função pré-fixada

True && x = x
False && _ = False  -- _ Representa uma variável anônima

True || _ = True
False || x = x

not :: Bool -> Bool
not True = False
not False = True

otherwise :: Bool
otherwise = True
```

- Hugs implementa curto circuito.
- **Chacagem Estática:** Declara o tipo, é <u>imutávael</u>.
- **Checagem Dinâmica:** Não há a declaração.

### Char

- É uma **enumeração** e consiste de valores de `16 bits`, conforme o padrão unicode.
- É representado pelo caractere entre **aspas simples**: 'a', 'b', 'A', '0', '1', ..., '9', etc.
- Cada um dos **caracteres de controle** `ASCII` tem mais de uma representação possível:

| Sequência | Nome (abreviação)        | Descrição                         |
|----------|--------------------------|-----------------------------------|
| \7, \a   | BEL (Bell)               | Emite um alerta sonoro (beep)     |
| \b, \BS  | BS (Backspace)           | Move o cursor uma posição atrás   |
| \f, \FF  | FF (Form Feed)           | Avança para a próxima página      |
| \r, \CR  | CR (Carriage Return)     | Retorna o cursor ao início da linha |
| \t, \HT  | HT (Horizontal Tab)      | Avança para a próxima tabulação   |
| \v, \VT  | VT (Vertical Tab)        | Avança verticalmente (linha abaixo com tabulação) |
| \n, \LF  | LF (Line Feed)           | Avança para a próxima linha       |

#### Funções de Conversão 

- `chr`: Converte um `Int` para `Char`. 
- `ord`: Converte um `Char` para um `Int`. 
- Estão disponíveis após `"import Data.Char"` ou `:| Data.Char"`.

```haskell
chr :: Int -> Char
ord :: Char -> Int
```

### Numéricos
- `Int` e `Integer`
  - `Int` tem valores **limitados**, aritmética por <u>hardware</u>.
  - `Integer` tem valores **ilimitados**, aritmética por <u>software</u>.

- **Operadores** para inteiros:
  - `+`, `-`, `*`, `/`, `^` 
  - `negate`, `div`, `rem`, `mod`, `odd`, `even`, `abs`, etc.

- Também existem os tipos `Float` `Complex`.

## Exercícios

1. Escreva uma **função** para calcular a área de um círculo de raio r.

```haskell
areaCirculo :: Float -> Float
areaCirculo r = pi * r*r

-- Execução
ghci> areaCirculo 10
314.15927
```

2. Escreva uma **função** para calcular o perímetro de um círculo de raio r.

```haskell
perimetroCirculo :: Float -> Float
perimetroCirculo r = 2 * pi * r

-- Execução
ghci> perimetroCirculo 10
62.831856
```

3. Escreva uma **função** para calcular a **hipotenusa** h de um triangulo retângulo a partir dos catetos a e b.

```haskell
calculaHipotenusa :: Float -> Float -> Float
calculaHipotenusa a b = sqrt (a*a + b*b)

-- Execução
ghci> calculaHipotenusa 3 4
5.0
```

4. Escreva uma **função** para calcular a **diferença da área** de dois círculos de raios r1 e r2.

```haskell
difAreaCirculo :: Float -> Float -> Float
difAreaCirculo r1 r2 = abs (areaCirculo r1 - areaCirculo r2) 

-- Execução
ghci> difAreaCirculo 10 9
59.69026

ghci> difAreaCirculo 10 11
65.97348
```

> [!NOTE]
>
> **Obervação:** O Haskell já disponibiliza a constante `pi` (3.14158...) e a função `sqrt` para cálculo da raiz quadrada.
