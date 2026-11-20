# Projeto 2 - Teoria e Aplicação de Grafos

**Integrantes:**
- Caio Merçon Pereira Carvalho - 231028746
- Lucas Vasconcelos Pirani Carneiro – 251031785
- Pedro Zambrozi Brunhara – 242039579

## Sumário

- [1. Introdução](#1-introdução)
- [2. Objetivos](#2-objetivos)
  - [2.1. Objetivo Geral](#21-objetivo-geral)
  - [2.2. Objetivos Específicos](#22-objetivos-específicos)
- [3. Formulação do Problema](#3-formulação-do-problema)
  - [3.1. Características da Instância](#31-características-da-instância)
  - [3.2. Restrições do Problema](#32-restrições-do-problema)
  - [3.3. Tratamento e Validação dos Dados](#33-tratamento-e-validação-dos-dados)
- [4. Grafo Bipartido](#4-grafo-bipartido)
  - [4.1. Exemplo](#41-exemplo)
- [5. Emparelhamento em Grafos Bipartidos](#5-emparelhamento-em-grafos-bipartidos)
- [6. Emparelhamento Estável](#6-emparelhamento-estável)
- [7. Algoritmo de Gale-Shapley](#7-algoritmo-de-gale-shapley)
  - [7.1. Alunos propõem aos projetos](#71-alunos-propõem-aos-projetos)
  - [7.2. Projetos propõem aos alunos](#72-projetos-propõem-aos-alunos)
- [8. Caminhos Alternados e Aumentantes](#8-caminhos-alternados-e-aumentantes)
- [9. Critérios de Preferência e Desempate](#9-critérios-de-preferência-e-desempate)
- [10. Processo Iterativo de Emparelhamento](#10-processo-iterativo-de-emparelhamento)
- [11. Indicadores e Matriz de Emparelhamento](#11-indicadores-e-matriz-de-emparelhamento)
- [12. Visualização Gráfica](#12-visualização-gráfica)
- [13. Tecnologias Utilizadas](#13-tecnologias-utilizadas)
- [14. Referências](#14-referências)

## 1. Introdução

Este projeto tem como objetivo desenvolver uma solução para o problema de alocação de alunos em projetos universitários (*Student-Project Allocation Problem — SPA*), utilizando algoritmos de emparelhamento estável em grafos bipartidos.

O problema consiste em alocar 200 alunos em 50 projetos universitários, considerando suas preferências, a quantidade de vagas disponíveis e a nota mínima exigida por cada projeto.

Cada aluno pode indicar até **três projetos em ordem de preferência**, enquanto cada projeto possui uma capacidade máxima de alunos e exige uma nota agregada mínima para aceitar candidatos.

A solução será desenvolvida a partir de variações do algoritmo de **Gale-Shapley**, buscando produzir emparelhamentos estáveis e aumentar a quantidade de alunos alocados por meio de caminhos alternados.

Além da implementação dos algoritmos, serão realizadas simulações das diferentes estratégias de proposição, visualizações da evolução dos emparelhamentos e análises dos resultados obtidos.

## 2. Objetivos

### 2.1. Objetivo Geral

Implementar uma solução para o problema de alocação de alunos em projetos universitários, buscando obter um **emparelhamento estável com o maior número possível de alunos alocados**, respeitando as restrições estabelecidas.

### 2.2. Objetivos Específicos

- Implementar as variações do algoritmo de Gale-Shapley, considerando propostas realizadas pelos alunos e pelos projetos.
- Aplicar caminhos alternados para tentar aumentar a quantidade de alunos alocados.
- Realizar dez iterações determinísticas do processo de emparelhamento.
- Desenvolver uma visualização gráfica da evolução das propostas, aceitações e rejeições.
- Calcular indicadores de preferência e construir a matriz final de emparelhamento.
- Analisar e comparar os resultados das diferentes estratégias implementadas.

## 3. Formulação do Problema

### 3.1. Características da Instância

A instância fornecida para o projeto apresenta as seguintes características:

- **Alunos:** 200 candidatos identificados de A1 até A200.
- **Projetos:** 50 projetos identificados de P1 até P50.
- **Preferências:** Cada aluno pode indicar até três projetos, em ordem de preferência.
- **Nota agregada:** Cada aluno possui uma nota inteira pertencente ao conjunto {3, 4, 5}.
- **Capacidade dos projetos:** Cada projeto possui uma quantidade máxima de vagas disponíveis.
- **Requisito mínimo:** Cada projeto estabelece uma nota agregada mínima para aceitar um aluno.
- **Cota mínima:** Cada projeto deve selecionar pelo menos um aluno.

### 3.2. Restrições do Problema

A solução computacional deverá considerar as seguintes restrições:

1. **Preferências dos alunos:** Cada aluno só pode ser alocado a um projeto que tenha indicado entre suas preferências.
2. **Elegibilidade:** A nota agregada do aluno deve ser maior ou igual à nota mínima exigida pelo projeto.
3. **Capacidade:** O número de alunos alocados em cada projeto não pode exceder sua capacidade máxima.
4. **Quantidade mínima de alunos:** Cada projeto deve selecionar pelo menos um aluno.
5. **Estabilidade:** A alocação deve ser estável, sem a existência de pares bloqueadores.
6. **Determinismo:** O algoritmo não deve utilizar critérios de escolha aleatórios, garantindo a reprodutibilidade dos resultados.

### 3.3. Tratamento e Validação dos Dados

Durante o processamento dos dados, serão aplicadas as seguintes regras:

- Preferências para projetos inexistentes serão ignoradas.
- Preferências repetidas serão removidas, mantendo a primeira ocorrência.
- Candidaturas de alunos abaixo da nota mínima exigida pelo projeto serão desconsideradas.

Além disso, será realizada uma validação da elegibilidade dos candidatos para cada projeto, verificando se existem alunos que atendam aos requisitos estabelecidos.

**Tratamento das cotas mínimas:** Caso um projeto não possua candidatos elegíveis, não será possível satisfazer a exigência de selecionar pelo menos um aluno. Essa situação deverá ser identificada e informada pelo programa, sem a realização de associações que violem as restrições de preferência ou elegibilidade.

Dessa forma, a solução deverá distinguir os projetos que conseguiram cumprir suas cotas mínimas daqueles cuja seleção foi inviabilizada pelas características dos dados de entrada.

Essas etapas garantem uma entrada consistente e permitem identificar possíveis limitações da instância antes da execução dos algoritmos.

## 4. Grafo Bipartido

Um grafo bipartido é um grafo cujos vértices podem ser divididos em dois conjuntos disjuntos, de modo que cada aresta conecte vértices de conjuntos diferentes.

Neste projeto, os dois conjuntos são:

- **Alunos:** vértices que representam os candidatos.
- **Projetos:** vértices que representam as oportunidades disponíveis.

As arestas representam as possíveis associações entre alunos e projetos, considerando as preferências e os requisitos mínimos de cada projeto.

Uma aresta entre um aluno e um projeto somente existirá quando o aluno tiver indicado aquele projeto entre suas preferências e atender ao requisito mínimo de nota estabelecido.

### 4.1. Exemplo

Considere três alunos (A1, A2 e A3) e dois projetos (P1 e P2).

Se um aluno indicar determinado projeto e atender à sua nota mínima, será criada uma aresta entre eles.

Essa representação permite identificar visualmente as possibilidades de alocação e constitui a estrutura utilizada pelos algoritmos de emparelhamento.

## 5. Emparelhamento em Grafos Bipartidos

Um emparelhamento é um conjunto de arestas que não possuem vértices em comum. Em outras palavras, cada vértice pode participar de, no máximo, uma associação.

Entretanto, neste projeto, os projetos possuem múltiplas vagas. Portanto, será utilizada uma variação do emparelhamento bipartido com capacidades (*Many-to-One Matching*), na qual:

- Cada aluno pode ser associado a, no máximo, um projeto.
- Cada projeto pode receber múltiplos alunos, respeitando sua capacidade máxima.
- As associações devem respeitar os requisitos de elegibilidade.
- Cada projeto deve selecionar pelo menos um aluno, desde que existam candidatos elegíveis para isso.

## 6. Emparelhamento Estável

Um emparelhamento é considerado estável quando não existem pares bloqueadores (*blocking pairs*).

Um par formado por um aluno e um projeto é considerado bloqueador quando ambos preferem estar associados entre si em vez de manter suas alocações atuais.

Para que isso ocorra:

- O aluno deve preferir o projeto à sua alocação atual ou estar sem alocação.
- O projeto deve considerar o aluno aceitável e possuir uma vaga disponível ou preferi-lo a pelo menos um dos alunos atualmente selecionados.

A existência de pelo menos um par bloqueador indica que o emparelhamento não é estável.

Portanto, o objetivo é encontrar uma distribuição que respeite as capacidades, as preferências e os requisitos de elegibilidade, sem apresentar pares bloqueadores.

## 7. Algoritmo de Gale-Shapley

O algoritmo de **Gale-Shapley** é utilizado para encontrar emparelhamentos estáveis por meio de um processo iterativo de propostas e rejeições.

Neste projeto, serão implementadas duas estratégias de proposição, adaptadas ao problema de alocação de alunos em projetos com capacidades (*Student-Project Allocation Problem — SPA*).

### 7.1. Alunos propõem aos projetos

- Cada aluno não alocado propõe ao projeto mais bem classificado de sua lista que ainda não tenha tentado.
- Os projetos avaliam os candidatos recebidos conforme sua lista de preferência.
- Caso a quantidade de propostas ultrapasse sua capacidade, os projetos mantêm os candidatos de maior prioridade e rejeitam os demais.
- Os alunos rejeitados tentam suas próximas preferências.

O processo continua até que não existam novas propostas possíveis.

### 7.2. Projetos propõem aos alunos

- Os projetos apresentam propostas aos alunos de acordo com sua lista de preferência.
- Cada aluno avalia as propostas recebidas e mantém aquela correspondente ao projeto que considera mais desejável.
- Os projetos cujas propostas forem rejeitadas procuram outros candidatos.
- O processo continua até que não existam novas propostas possíveis.

As duas estratégias serão simuladas e comparadas, considerando suas diferenças nos resultados de alocação.

**Observação:** A solução final deverá utilizar a lista de preferência dos projetos como estratégia principal, conforme estabelecido no enunciado. A estratégia de proposição pelos alunos também deverá ser implementada e apresentada para comparação.

## 8. Caminhos Alternados e Aumentantes

Um **caminho alternado** é um caminho no grafo cujas arestas alternam entre aquelas pertencentes ao emparelhamento e aquelas que não pertencem.

Um **caminho aumentante** é um caminho alternado que começa e termina em vértices não emparelhados. Sua utilização permite aumentar em uma unidade a quantidade de associações no emparelhamento tradicional.

Neste projeto, esses caminhos serão utilizados para tentar alocar alunos que permaneceram sem projeto, reorganizando associações existentes quando necessário.

A busca deverá considerar as capacidades dos projetos, as preferências dos participantes e os requisitos de elegibilidade.

Após cada tentativa de aumento, a solução deverá ser verificada para garantir que as restrições sejam respeitadas e que não sejam introduzidos pares bloqueadores.

## 9. Critérios de Preferência e Desempate

As listas de preferência dos dois lados serão construídas da seguinte forma:

**Preferência dos alunos:**

- Será utilizada a ordem de projetos informada no arquivo de entrada.

**Preferência dos projetos:**

- Os alunos serão classificados pela Nota Agregada, em ordem decrescente (5 > 4 > 3).
- Em caso de empate, será utilizada a ordem de chegada das propostas ao projeto.

Para garantir o determinismo, a ordem inicial de processamento dos alunos seguirá seus identificadores em ordem crescente. Nas rodadas seguintes, será registrada a ordem efetiva de chegada das propostas.

Serão consideradas apenas as candidaturas válidas, ou seja, aquelas em que o projeto foi indicado pelo aluno e o requisito mínimo de nota foi atendido.

## 10. Processo Iterativo de Emparelhamento

A solução será executada em dez iterações sequenciais, conforme solicitado no enunciado.

Na primeira iteração, será executado o algoritmo de emparelhamento estável, considerando as preferências dos participantes.

A partir da segunda iteração, serão utilizados os alunos que permaneceram não emparelhados na iteração anterior como pontos de partida para a busca por caminhos alternados.

O objetivo é reorganizar as associações existentes e tentar aumentar a quantidade de alunos alocados, preservando as restrições do problema.

Cada iteração deverá:

1. Recuperar a solução obtida na iteração anterior.
2. Identificar os alunos não alocados.
3. Buscar caminhos alternados que possibilitem novas alocações.
4. Verificar as capacidades e os requisitos de elegibilidade.
5. Verificar a estabilidade da solução resultante.
6. Registrar e apresentar o resultado da iteração.

Todas as iterações serão determinísticas, sem utilização de escolhas aleatórias.

Ao final, serão apresentadas as dez soluções e a evolução da quantidade de alunos alocados.

## 11. Indicadores e Matriz de Emparelhamento

A solução final deverá apresentar indicadores que permitam avaliar a qualidade das alocações realizadas.

Será construída uma matriz de emparelhamento contendo:

- Identificação do aluno.
- Projeto ao qual foi alocado.
- Classificação do aluno na lista de preferência do projeto.
- Classificação do projeto na lista de preferência do aluno.

Essa matriz permitirá analisar as posições alcançadas pelos participantes em suas respectivas listas de preferência, evidenciando os ganhos e as perdas de cada lado.

Também deverá ser calculado e visualizado um índice de preferência por projeto, conforme solicitado no enunciado. A definição da metodologia e da fórmula desse indicador será estabelecida após esclarecimento com o professor.

Essas informações possibilitarão comparar as estratégias de proposição e analisar as preferências atendidas em cada emparelhamento.

## 12. Visualização Gráfica

Será desenvolvida uma interface para visualizar o grafo bipartido, representando os alunos e projetos como conjuntos distintos de vértices.

As arestas representarão as propostas e associações realizadas durante o processo de emparelhamento.

Serão utilizadas cores diferentes para identificar:

- **Propostas ativas:** arestas que representam propostas em andamento.
- **Emparelhamentos temporários:** arestas que representam associações mantidas durante o processo.
- **Propostas rejeitadas:** arestas que representam associações recusadas.

A interface deverá apresentar a evolução das dez iterações, permitindo acompanhar as mudanças nas alocações e identificar os resultados de cada etapa.

Também serão apresentados os resultados das duas estratégias de proposição, destacando a solução obtida com a lista de preferência dos projetos.

## 13. Tecnologias Utilizadas

O projeto será desenvolvido utilizando Python, com execução em um notebook Jupyter ou Google Colab, conforme estabelecido no enunciado.

Serão utilizadas bibliotecas para:

- Processamento e manipulação dos dados.
- Construção e manipulação de grafos.
- Implementação dos algoritmos de emparelhamento.
- Visualização gráfica do grafo e dos resultados.
- Construção de tabelas e indicadores.

As bibliotecas específicas serão definidas durante o desenvolvimento da solução.

## 14. Referências

ABRAHAM, D. J.; IRVING, R. W.; MANLOVE, D. F. (2007). Two algorithms for the student-project allocation problem. *Journal of Discrete Algorithms*, 5(1), p. 73–90.
