# Uniciclo

O desempenho de uma máquina pode ser determinado por três fatores: 
- Número de instruções executadas 
- Período do clock (ou frequência) 
- Número de ciclos por instrução (CPI) 

Para um determinado algoritmo, o compilador e a **ISA** (***Instruction  Set Architecture***) determinam o **número de instruções a serem executadas**. 

A **implementação do processador** determina o **período de clock** e o **CPI**.

Os aspectos relativos à implementação do hardware serão ilustrados a partir de um **subconjunto das instruções** do RISC-V. 

O interrelacionamento entre ISA e a implementação é exemplificado em três projetos alternativos do processador 
- Processador **Uniciclo** 
- Processador **Multiciclo** 
- Processador **Pipeline**

### Arquitetura Von Neumann

![arquitetura-von-neumann](img/10-uniciclo/arquitetura-von-neumann.png)

### Arquitetura Harvard

![arquitetura-harvard](img/10-uniciclo/arquitetura-harvard.png)

## Unidade Operativa 
Também chamada **Parte Operativa**, Caminho de Dados ou, em inglês, ***"Datapath"***.

É construída a partir dos seguintes componentes: 
- Elementos de armazenamento (registradores, flip-flops) 
- Operadores lógico-aritméticos 
- Recursos de interconexão (barramentos, mux)

Será projetada para implementar o seguinte subconjunto de instruções do RISC-V: 
- Instruções de referência a memória: `lw` e `sw` 
- Instruções lógicas e aritméticas: `add`, `sub`, `and`, `or` e `slt` 
- Instruções de fluxo de controle: `beq` e `jal`

### Sinopse da Implementação

Implementação Genérica: 
- Use o contador de programa (PC) para fornecer endereço da instrução. 
- Obtenha a instrução da memória 
- Leia os registradores 
- Use a instrução para decidir exatamente o que fazer 

> [!IMPORTANT]
>
> **Todas as instruções** usam a **ALU** após lerem os registradores.

### Implementação Básica

![implementacao-basica](img/10-uniciclo/implementacao-basica.png)

- **Unidade de Controle:** 1 único ciclo de clock. 
- Elementos **combinacionais** e **sequenciais**.
- **Observação:** 
    - Em vários pontos temos dados vindo de duas origens diferentes. 
    - As unidades precisam ser controladas.

### Componentes Combinacionais
Componentes combinacionais definem o valor de suas saídas apenas em função dos valores presentes nas suas entradas.

![componentes-combinacionais](img/10-uniciclo/componentes-combinacionais.png)

### Componentes Sequenciais
Componentes armazenadores de estado, as saídas dependem das entradas e do tempo.

![componentes-sequencias](img/10-uniciclo/componentes-sequencias.png)

Componentes sequenciais têm um **estado**, que **define seu valor em um dado instante** de tempo.

**Registrador:** 
- Um conjunto de ***flip-flops*** tipo **D** (Registrador) 
    - Com `n bits` de entrada e saída. 
    - Entrada de habilitação de escrita. 
- Habilitação de escrita (***Write Enable - WE***): 
    - 0: O dado de saída **não muda**. 
    - 1: O dado de entrada será carregado (saída = entrada) na transição do clock.

![registrador](img/10-uniciclo/registrador.png)

### Mémoria
Memória (One/Two/Three... Ports) 
- Um barramento de entrada: `Data In` 
- Um barramento de saída: `Data Out`

Uma palavra é selecionada por: 
- Um endereço seleciona a palavra para ser colocada na saída (**Data out**). 
- `Write Enable = 1`: Permite que a palavra selecionada seja **escrita com a informação na entrada** (`Data in`). 

Entrada de Clock (`CLK`): Sincroniza os processos de acesso à memória.

![memoria](img/10-uniciclo/memoria.png)

## Estratégia de Temporização
- Uma metodologia de temporização define quando **os sinais podem ser lidos** e quando eles podem **ser escritos**. 
- É necessário evitar **situações de conflito**, por exemplo, querer ler uma palavra e escrevê-la simultaneamente. 
- Será adotada uma metodologia de temporização sensível às transições do sinal do clock. 
- Nesta metodologia, qualquer valor armazenado nos **elementos de estado** só pode ser atualizado durante a **transição do sinal de relógio** (**clock**).

![temporizacao-combinacional](img/10-uniciclo/temporizacao-combinacional.png)

- Lógica combinacional usualmente tem **entradas e saídas conectadas** a elementos de estado (sequenciais) 
- O elemento de estado 2 só pode ser escrito depois de os dados em sua entrada estarem estáveis: 
    - Atraso de propagação no elemento de estado 1 
    - Atraso da lógica combinacional 
    - Tempo de pré-carga (setup time) no elemento de estado 2

![comparacao-temporizacao](img/10-uniciclo/comparacao-temporizacao.png)

## Criando a Unidade Operativa
Uma maneira de se começar o projeto de uma unidade operativa (***data path***) é **examinar cada** um dos **componentes necessários** para a execução de cada uma 
das classes de instruções do RISC-V.

Elementos Necessários: 
- Um lugar para armazenar as instruções (**memória de instruções**) 
- Um registrador para armazenar o endereço de instrução (**Program Counter – PC**) 
- Um contador para incrementar o PC, para compor o endereço da próxima instrução (soma 4 para endereçar próxima instrução).

![elementos-basicos](img/10-uniciclo/elementos-basicos.png)

### Instruções Lógico-Aritméticas

Formato de uma instrução tipo R:

| Campo | funct7 | rs2 | rs1 | funct3 | rd | opcode |
|---|---|---|---|---|---|---|
| **Tamanho** | 7 bits | 5 bits | 5 bits | 3 bits | 5 bits | 7 bits |

- Semântica: $x[rd] \leftarrow op(x[rs1],x[rs2])$
- Estrutura de Suporte: **Banco de Registradores**

### Banco de Registradores
- **Dupla Porta:** Leitura de dois registradores ao mesmo tempo. 
- Sinal de controle para escrita: Leitura não necessita controle.

![banco-de-registradores](img/10-uniciclo/banco-de-registradores.png)

### Projeto da ULA
- A ULA é apresentada no anexo do livro. 
- 4 bits de controle indicam a operação a ser realizada.

| Linhas de controle da ALU | Função                 |
|:-------------------------:|------------------------|
| 0000                      | AND                    |
| 0001                      | OR                     |
| 0010                      | add                    |
| 0110                      | subtract               |
| 0111                      | set on less than       |
| 1100                      | NOR                    |

![ula](img/10-uniciclo/ula.png)


### Memória
- Memória com um barramento de entrada independente do de saída. 
- Controle de escrita (*write*) e leitura (*read*). 
- Barramento de endereços. 
- Um acesso de cada vez.

![memoria1](img/10-uniciclo/memoria1.png)

### Extensão de Sinal do Imediato

A forma de geração do imediato depende da instrução: 
- `lw`: Imediato = { 20x{Instr[31]}, Instr[31:20] }  
- `sw`: Imediato = { 20x{Instr[31]}, Instr[31:25], Instr[11:7] }  
- `beq`: Imediato = { 20x{Instr[31]}, Instr[7], Instr[30:25], Instr[11:8] } 
- `jal`: Imediato = { 12x{Instr[31]}, Instr[19:12], Instr[20], Instr[30:21] }

![imediatos](img/10-uniciclo/imediatos.png)

### Acesso a Memória

- `lw`: Lê um dado da memória e escreve em um registrador. 
    - Conexão entre a saída da memória e a entrada do banco de registradores. 
- `sw`: Lê um dado de um registrador e escreve na memória. 
    - Ligação entre saída do banco de registradores e entrada de dados da memória. 
- Endereço **calculado através da ULA** 
    - Saída da ULA ligada ao barramento de endereços da memória.

![acesso-memoria](image.png)

### Instruções de Desvio

`beq  t1, t2, desloc`
- Compara dois registradores 
- Soma **desloc palavras ao endereço** PC se `t1 = t2`. 
- No Assembly utiliza-se uma versão simplificada, com o rótulo do destino. 
    - `beq t1, t2, LABEL` 
    - Neste caso, o montador calcula o deslocamento a ser usado. 
- **desloc** é um deslocamento de **meias palavras**, ou seja, cada unidade de desloc corresponde a 2 bytes. 
- No RiscV, a **comparação** entre os registradores é **feita pela ULA**, sendo a resposta colocada na saída como um **valor Booleano**. 
- O PC deve ser carregado com `PC + 4` ou  `PC + desloc*2`, de acordo com o resultado do teste. 
- A multiplicação de **desloc por 2** é feita **deslocando-se 1 bit a esquerda** o seu valor. 
- Dependendo da implementação, o deslocamento pode ser  feito dentro do gerador de valores imediato.

![endereco-desvio](img/10-uniciclo/endereco-desvio.png)

### Observações
- Para realizar a comparação dos dois operandos precisamos usar o banco de registradores. 
- O cálculo do endereço de desvio foi incluído no circuito. 
- Na instrução não é preciso **escrever no banco de registradores**. 
- A **comparação será feita pela ULA**, com o resultado disponibilizado através do bit **0 da saída da ULA**.

![caminho-de-dados](image.png)

## Unidade de Controle 

