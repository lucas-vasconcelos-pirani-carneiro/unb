# Abstração

## Encapsulamento por Subprograma

### Implementação de Subprograma
Subprograma representa parte da VM construída pelo programador:
- É implementado usando a estrutura de dados e as operações providas pela LP. 

Implementação:

$$
\begin{array}{r l}
\text{Encapsulado} &
\left\{
\begin{array}{l}
\text{Cabeçalho} \rightarrow \text{assinatura} \\
\text{Declarações} \rightarrow \text{locais} \\
\text{Comandos} \rightarrow \text{definem a ação}
\end{array}
\right.
\end{array}
$$

- Uso: Apenas via chamada ao subprograma.

**Subprogramas Locais:** São subprogramas definidos aninhados, dentro de outros subprogramas (Pascal e Ada). 
- Não são acessíveis externamente; estão encapsulados.

**Chamada de Subprogramas:**
- Invocação checa os tipos dos argumentos, 
- Checagem é estática ou dinâmica, 
- Pode ocorrer coerção automática dos argumentos.

### Definição e Invocação de subprograma
**Definição:**
- É a forma (estática) escrita do subprograma.
- É a única informação disponível em tempo de tradução (só o tipo das variáveis é conhecido). 

**Ativação:** 
- Existe somente durante a execução,  
- ***l-value*** e ***r-value*** podem ser acessados, mas os tipos dos OD podem não estar disponíveis, 
- Usa a definição como gabarito, de  modo similar ao tipo de dados (para definir tamanho e RA = Região de Armazenamento ).

A definição de subprograma e sua área de ativação: analogia com tipo e OD daquele tipo.

No programa em **execução**: 
- Cria-se uma **área de ativação** a **cada chamada**, 
- Quando o subprograma **completa sua execução**, a área de ativação **é destruída**, 
- De uma única definição de subprograma, muitas áreas de ativações podem ser criadas,

A tradução da definição do subprograma **permite dimensionar as RA para os OD e código executável, em tempo de tradução**. 
- Esse resultado é usado como um gabarito para as ativações do subprograma. 
- Esse gabarito é divido em duas partes:
    - **Segmento de código**. 
    - **Registro de ativação**.

**Segmento de Código:** 
- Parte estática, ***invariante*** durante a execução: consiste de **constantes** e do **código executável**. 
- Cópia única é **cotizada** por todas as ativações. 

**Registro de Ativação:** 
- Parte **dinâmica** que contém as informações que **variam durante a execução**: 
    - Resultado das funções, parâmetros, variáveis locais e estruturas para housekeeping (dados não locais, temporários, **pontos de retorno**, etc.).

```c
float fn (float x, int y) { 
    const int vi = 2;  
    #define vf 10 
    float m[vf]; 
    int n;
    ...
    n = vi; 
    if (n < vi) { ... }; 
    return (20*x + m[n]);
}
```

1. `fn: float x int -> float` Dá as informações p/ RA dos parâmetros e do resultado. 
2. Declarações de m e n induz a RA deles. 
3. RA para literais e constantes: 
    - `vi` é constante, 
    - `vf` é definida como constante 10 (macro); 
    - 10 e 20 são literais. 
4. RA para armazenar o código executável criado a partir dos comandos.

$$
\begin{array}{c c}
\begin{array}{|c|}
\hline
\text{Prólogo para criar o} \\
\text{registro de ativação} \\
\hline
\text{Código executável} \\
\hline
\text{Epílogo p/ eliminar} \\
\text{o registro de ativação} \\
\hline
20 \\ \hline
10 \\ \hline
2 \\ \hline
\end{array}
&
\begin{array}{|c|}
\hline
\text{Ponto de retorno e outros} \\
\text{dados do sistema} \\
\hline
\text{Dados resultantes de fn} \\
\hline
x: \text{ parâmetro} \\ \hline
y: \text{ parâmetro} \\ \hline
m: \text{ OD local} \\ \hline
n: \text{ OD local} \\ \hline
\vdots \\ \hline
\end{array}
\\[1em]
\text{Segmento de} &
\text{Registro de} \\
\text{código para a função fn} &
\text{ativação para fn (um por chamada)}
\end{array}
$$

### ODE Registro de Ativação
- **Tamanho:** Determinado durante a tradução. 
- **Seleção dos Componentes:** 
    - Como em um registro: $\alpha$ + deslocamento. 
    - Sua RA é similar a um OD do tipo registro.  
- **Criação dinâmica:** Um registro a **cada chamada do subprograma**, sendo destruído ao término da rotina. 
- **Recursão:** A cada chamada recursiva é criado um novo registro de ativação.

### Subprograma Genérico
Único nome, denominando subprogramas distintos com diferentes assinaturas: 
- **Sobrecarregado**, 
- Individualização do subprograma é feita pelo <u>tradutor</u> **com base em seus argumentos**.
- Traz vantagens sem complicar a implementação.

É uma propriedade central em LP tipo ML (tipos polimórficos) ou Prolog.

#### Exemplos
```ml
fun size [] = 0
    | size (x::xs) = 1 + size xs;        

> val size = fn: 'a_list  --> int 
size ["a","perigo", "João", 2,3,4,5] 
> 7: int 
```

```ada
procedure entra (aluno: in integer; turma: in out Tturma) is        
    begin
    ... 
    end; 

procedure entra (turma: in Tturma; tab: in out TlistaTurma) is 
    begin  
    ...
    end;
```

```fortran
INTERFACE ENTRA      
    SUBROUTINE ENTRA1 (ALUNO,TURMA)       
        INTEGER :: ALUNO         
        TTURMA  :: TURMA                  
        ....   
    END SUBROUTINE ENTRA1 
    SUBROUTINE ENTRA2 (TURMA,TAB)        
        TTURMA :: TURMA         
        TLISTATURMA :: TAB                 
        ...   
    END SUBROUTINE ENTRA2 
END INTERFACE ENTRA
```

## Definição de Tipos
Definir tipos abstratos de dados requer: 
1. Definir um novo tipo ou classe de dados.
    - C, Pascal e Ada permitem definição de tipos  `nome do tipo --> nome da classe de objetos` de dados.
    ```pascal
    type racional = record  
        numerador, denominador: integer;  
    end;  
    var A, B, C: racional;
    ```
2. Mecanismos para definir as operações sobre o novo TD.  
    - Especialidade de linguagens orientadas a objetos. 

### Exemplo C: Struct
```c
struct racional { 
    int numerador, denominador;
} 
struct racional A, B, C; 
```

Uso de **struct** para definir variáveis viola o **princípio**: Tudo que o programador vê é o **nome do tipo** e a **lista de operações** para manipulá-lo. 

```c
typedef struct {
    int numerador, denominador; 
} racional; 

racional A, B, C;
```

Sintaxe semelhante ao Pascal: **não** viola a regra de TAD. 
- `typedef` é similar a uma **macro**: Novos tipos são criados em C pela declaração struct.
    - Novos tipos são criados em `C` usando `struct` e `unions`.

Uso: gabarito para definir OD na execução: 
- Permite separar a definição da **estrutura do OD** da definição dos **pontos nos quais OD desse tipo serão criados** na execução do programa.  

Constitui uma forma de encapsular dados e esconder informação: 
- Se subprograma cria OD usando o nome do tipo e não acessa diretamente os seus componentes internos a definição do tipo pode mudar sem ser necessário 
alterar o programa.

### Implementação
Similar a declarações, definição de tipo é útil apenas na tradução para determinar a RA do OD, checagem de tipo e gerência de armazenamento:  
- Durante a **compilação**, definições de tipo são inseridas em uma tabela específica e usadas quando OD deste tipo são declarados. 
- Gerado o código objeto, **não são necessárias**:  
    - **Em LP compiladas os objetos de dados não tem etiqueta de tipo**. 

### Equivalência de Tipos
Checagem de tipo (**estática** ou **dinâmica**):
- Comparação entre os tipos dos argumentos atuais e esperados (*formais*) de uma operação. 
- Um erro ou coerção ocorre, se os tipos não são os mesmos.

Questões em equivalência de tipos: 
- **Quando dois OD são do mesmo tipo ?** 
    - Questão tratada em tipos de dados. 
- **Quando dois  OD do mesmo tipo são iguais ?** 
    - Questão **semântica** relativa ao r-value de um OD.

```pascal
program Pxy ;   
    type 
        T1 = array[1..10] of real;  
        T2 = array[1..10] of real;     
    var x,z: T1; 
    y: T2;   
    
    procedure Sub(A:T1);   
    begin
        ... 
    end;   
    begin { ADA,  C++ }  
        x := y;   {erro: não Pascal} 
        Sub(y); {erro tipo Pascal}   
    end ;
```

1. x, y, z e A tem o mesmo tipo ? 
2. É válido fazer: x := y ?  e  Sub(y) ? 
3. Há 2 enfoques básicos: 
    - Equivalência de **nomes**. 
    - Equivalência **estrutural**.  
4. Equivalência de nomes: TD são equivalentes se têm o mesmo nome. 
    - Usado em ADA, C++ e em passagem de parâmetros em Pascal.

### Equivalência de Nomes
**Desvantagens:** Todo OD usado em atribuição precisa ter um nome de tipo. 
- Não pode haver tipos anônimos. 
- `var w: array [1..10] of real;` não é argumento válido de subprograma.

TD de argumento transmitido em uma cadeia de subprogramas não pode ser novamente definido em cada subprograma:
- Uma única definição global de tipo deve ser usada.
- Definição de classe em `C++`, package em ADA e arquivos de inclusão `.h` em `C` garantem isto.  

### Equivalência Estrutural
Dois tipos de dados são equivalentes se definem **OD com os mesmos componentes internos**: 
- Isto é, ambos tem a mesma RA, em tempo de execução e mesma forma para selecionar componentes.  
- T1 e T2 são equivalentes estruturais porque têm a mesma RA. 

#### Questões sobre Equivalência Estrutural
Registros são equivalentes se componentes:
- Estão na mesma ordem e têm os mesmos tipos ? 
- Mesma ordem, têm os mesmos tipos e nomes ? 
- Tendo mesmos tipos e nomes, precisam estar na mesma ordem ? 

Arrays com mesmo nº de componentes de tipos iguais: subscritos precisam ser iguais ?

Literais em dois tipos de enumerações precisam ser os mesmos e estarem na mesma ordem ? 

Equivalência equivocada: 

```pascal
type 
    Tmetro = integer;               
    Tlitro  = integer;   
var dis: Tmetro;   { distância em metros } 
    vol: Tlitro;   { volume em litros } 
X:= dis + vol ;    { Equivalência estrutural: OK, Equivalência de nome: erro. }
```
- O programador declarou tipos diferentes e considerá-los iguais é um erro semântico. 

Compilação cara (freqüência da) verificação de equivalência entre OD complexos. 

### Projeto de Linguagens
- Em LP como Pascal e Ada equivalência de tipos tem um papel central. 
- Em LP antigas (Cobol, Fortran, PL/1), não há definição de tipos; usa-se formas de e **quivalência estrutural**.  
- C usa **equivalência estrutural**. 
- C++ e Ada usam equivalência de nomes. 
- Equivalência é um assunto de pesquisa.

### Igualdade de OD
Se dois objetos A e B têm o mesmo tipo, quando são iguais? Isto é A = B ? 
- Resposta é não trivial.

```c
struct tpilha {
    int topo; 
    int dados[100];
} x,y;

struct tconjunto {
    int num; 
    int dados[100];
} a,b; 
```

1. a, b, x e y  são **estruturalmente equivalentes**.
2. As condições sobre as quais se deseja ter `a = b` e `x = y` podem ser muito diferentes. 

Igualdade de pilha: Mesma ordem
- `x.topo = y.topo` // aponta para mesmo índice. 
- `x.dados[k] = y.dados[k]`, para k = 0, x.topo - 1.

Igualdade de conjuntos: Permuração!
- `a.num = b.num // mesmo # de elementos`.
- `a.dados[0], ..., a.dados[a.num - 1]` é uma **permutação** 
    - `b.dados[0], ..., b.dados[a.num-1]`

Não é fácil formalizar igualdade p/ ODE, com tipos criados pelo usuário:
- Cabe ao usuário essa tarefa.

> ![NOTE]
> 
> `equals` em **Java** retorna `true` se os endereços de dois objetos são os mesmos.

### Definição de Tipos com Parâmetros
Tipo parametrizado facilita definir tipos de dados similares, como arrays de != tamanhos.

1. Exemplo com parâmetros *explícitos* em Ada.
```ada
type mês (dias: integer range 1 .. 31) is  
    record                   
        nomes: string(1 .. 3);                  
        vendas: array(1 .. dias) of float 
    end record; 
  fev: mês(28); m30: mês(30); m31: mês(31);                   
```
- Número de dias faz parte da declaração do mês.

2. Exemplo **sem** parâmetros *explícitos* em Ada 
    1. `type matriz is array (integer range <>, integer range <>) of float;`
        - Tabela: `matriz(1..10, 1..20);`
    2. `novalista (1..n) of tipox;`
        - Cada vez que o subprograma contendo esta declaração for ativado tem-se um arranjo novalista de comprimento n, variável externa ao subprograma.

**Implementação:** Definição funciona como um molde (template). 
- O parâmetro deve ser **definido antes de usado**.  
