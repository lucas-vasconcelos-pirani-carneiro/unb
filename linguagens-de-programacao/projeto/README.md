# Projeto

Utilizar a Linguagem GoLang para fazer um projeto não muito complexo, porém esse projeto deve estar alinhado com as premissas da linguagem.

## 1º Seminário
A linguagem de programação **Go (Golang)** surgiu no Google em 2007 como uma resposta direta a desafios de **infraestrutura** e **desenvolvimento** enfrentados pela empresa.

### Por que a linguagem surgiu?
O surgimento do Go foi motivado pela necessidade de resolver obstáculos complexos que as linguagens existentes não conseguiam suprir **de forma eficiente** dentro da **escala do Google**. Os principais motivos foram:

- **Desempenho e Hardware:** A empresa precisava de uma solução que aproveitasse melhor o desempenho de **processadores multinúcleos** e sistemas **divididos em redes**.

- **Complexidade de Linguagens Existentes:** Tentativas de resolver esses problemas com linguagens como C++, Java e Python falharam em agrupar todos os atributos desejados em uma única linguagem, como **tipagem estática**, **segurança**, **eficiência** e **facilidade de sintaxe**.

- **Lentidão no Desenvolvimento:** O processo de fusão e compilação de sistemas massivos com milhares de engenheiros era muito demorado; o Go foi projetado para ter **tempos de compilação extremamente rápidos**.

- **Escalabilidade e Concorrência:** O avanço da computação em nuvem exigia uma linguagem explicitamente voltada para o desenvolvimento de **aplicações concorrentes altamente confiáveis**.

### Como a linguagem surgiu?
O desenvolvimento seguiu uma trajetória de projeto interno para se tornar uma das linguagens mais populares do mundo:

- **Criadores:** Foi concebida como um projeto interno por **Robert Griessemer**, **Rob Pike** e **Ken Thompson**.

- **Evolução Interna:** Em 2008, o Go deixou de ser um projeto de meio período para se tornar um projeto de período integral dentro do Google.

- **Lançamento como Código Aberto:** Em novembro de 2009, a linguagem tornou-se ***Open Source***, permitindo que desenvolvedores de fora do Google começassem a adotá-la a partir de 2010.

- **Inspiração e Recursos:** Trata-se de uma linguagem inspirada no `C`, mas que incorpora recursos avançados como **coleta de lixo (*garbage collection*)**, abstração para estruturas de dados e um modelo de **concorrência intuitivo** baseado em *goroutines* e *channels*.

- **Estabilidade:** A primeira versão oficial (v1) foi lançada em 2012, estabelecendo uma base estável para adoção comercial em larga escala.

### Domínios de Aplicação
Os principais domínios de aplicação da linguagem Go, conforme as fontes, são:

#### 1. Serviços de Nuvem e Rede (Cloud & Network Services)
Este é um dos domínios mais fortes do Go devido ao seu suporte **nativo à concorrência** e ao uso eficiente de processadores multinúcleo.

- **Aplicações:** É amplamente utilizada para construir **microserviços**, arquiteturas ***serverless*** e sistemas de computação em nuvem escaláveis.

- **Exemplos Reais:** Ferramentas fundamentais da infraestrutura moderna de nuvem, como `Docker` e `Kubernetes`, são escritas em Go. Empresas como `Dropbox` migraram grande parte de sua infraestrutura crítica de Python para Go visando **melhor desempenho**.

#### 2. Interfaces de Linha de Comando (CLIs)
Desenvolvedores preferem Go para criar ferramentas de terminal pela sua portabilidade e velocidade de execução.

- **Vantagens:** O Go compila para um **binário único autossuficiente**, o que facilita a distribuição e instalação em qualquer sistema sem a necessidade de bibliotecas externas.

- **Ferramentas:** Bibliotecas como `Cobra` e `Viper` são comumente usadas para criar CLIs elegantes e poderosas. Exemplos incluem ferramentas do GitHub, `Stripe` e o gerador de sites estáticos `Hugo`.

#### 3. Desenvolvimento Web
O Go foi desenhado para permitir o desenvolvimento rápido de aplicações web seguras e escaláveis.

- **Recursos:** Possui um servidor web nativo performante e sua própria biblioteca de *templates*. 
    - Suporta as tecnologias mais recentes como HTTP/2 e bancos de dados modernos (MySQL, MongoDB, Elasticsearch).

- **Uso:** Empresas como `Medium` e `The Economist` utilizam Go para alimentar seus serviços de backend e fornecer conteúdo de forma flexível e eficiente.

#### 4. DevOps e Engenharia de Confiabilidade de Sites (SRE)
O Go é ideal para equipes de DevOps que buscam automatizar tarefas e melhorar processos de integração e entrega contínua (CI/CD).

- **Aplicações:** Utilizado desde pequenos scripts de automação até serviços complexos de gerenciamento de *rollout*.

- **Exemplos:** Ferramentas de monitoramento como `Prometheus` e sistemas de provisionamento de infraestrutura como `Terraform` são construídos em Go.

#### 5. Outros Domínios Específicos

- **Bioinformática e Processamento de Dados:** Utilizado para tarefas de processamento massivo de dados e machine learning em empresas como a `GRAIL`.

- **Bancos de Dados:** O Go foi a escolha para construir bancos de dados modernos como o `CockroachDB`, devido aos seus benefícios de desempenho e baixa barreira de entrada.

- **Aplicações Desktop:** Através de frameworks como o `Fyne`, é possível construir interfaces gráficas de usuário (GUI) para desktop de forma simples.

### Usuários Característicos
Os usuários característicos da linguagem Go (também conhecidos como ***"gophers"***
) abrangem desde desenvolvedores individuais até grandes equipes de engenharia em corporações globais. A linguagem é amplamente adotada em cenários que exigem alta performance, escalabilidade e facilidade de manutenção. Os perfis de usuários mais comuns incluem:

#### 1. Engenheiros de Sistemas em Larga Escala
`Go` é uma boa escolha de equipes que desenvolvem produtos e serviços que operam em **escala global** pois esses usuários buscam **eficiência** para lidar com milhares de linhas de código e processos de compilação rápidos.

#### 2. Equipes de DevOps e Engenharia de Confiabilidade de Sites (SRE)
Engenheiros de SRE utilizam a linguagem para transformar scripts simples de **"uso único"** em ferramentas complexas de gerenciamento de ***rollout*** e automação de implantação em nuvem.

#### 3. Desenvolvedores de Serviços de Nuvem e Redes
Este grupo utiliza `Go` para construir arquiteturas de **microserviços** e sistemas distribuídos. A linguagem é preferida por esses usuários devido ao seu **suporte nativo à concorrência**, permitindo a coordenação eficiente de recursos compartilhados e alto desempenho em processadores multinúcleo.

#### 4. Desenvolvedores de Ferramentas de Linha de Comando (CLI)
Muitos desenvolvedores preferem Go para criar CLIs devido à sua **portabilidade** e velocidade de inicialização imediata. O fato de o Go compilar para um único binário autossuficiente (sem dependências externas) torna a instalação e atualização dessas ferramentas trivial para os usuários finais.

#### 5. Desenvolvedores Web (Backend)
Usuários que precisam desenvolver rapidamente aplicações web seguras e **escaláveis** utilizam Go pelo seu servidor web nativo performante e suporte a tecnologias modernas como HTTP/2 e diversos bancos de dados (MySQL, MongoDB, ...).

#### Empresas que são Usuários Característicos:

- **Tecnologia e Infraestrutura:** Google, Microsoft, IBM, Facebook, GitHub, Cloudflare, Docker, Dropbox e MongoDB.
- **Serviços Financeiros e E-commerce:** PayPal, American Express, Capital One, MercadoLibre, Monzo e Curve.
- **Mídia e Entretenimento:** Netflix, YouTube, Twitch, Medium, The Economist e New York Times.
- **Serviços e Mobilidade:** Uber, SIXT, Stripe e Trivago.
- **Jogos:** Riot Games e Wildlife Studios.

### Premissas e Diretivas
As premissas e diretivas da linguagem Go baseiam-se na busca por um equilíbrio entre **eficiência de execução**, **velocidade de compilação** e **simplicidade de programação**. Abaixo estão as principais premissas e diretivas que guiam a linguagem:

#### 1. Filosofia de Concorrência (Modelo CSP)
Uma das premissas fundamentais do Go é o suporte nativo à concorrência através do modelo **Communicating Sequential Processes (CSP)**.

- **Mantra Principal:** A diretiva central da linguagem é: **"Não comunique compartilhando memória; em vez disso, compartilhe memória comunicando"**.

- **Goroutines como Recurso Livre:** `Go` incentiva o uso de ***goroutines***, tratando-as como recursos extremamente leves e "gratuitos" (chegando a ser 10 vezes mais baratas em recursos do que threads de Python), permitindo que desenvolvedores foquem no problema e não no gerenciamento complexo de threads.

- **Channels para Composição:** O uso de canais (*channels*) é a diretiva preferida para coordenar a entrada e saída entre subsistemas, pois eles são intrinsecamente seguros para uso concorrente e mais fáceis de compor do que travas de memória (locks). 

#### 2. Simplicidade e Engenharia de Software
Go foi construída com foco em **bons princípios de engenharia de software** e na redução do "atrito" no desenvolvimento.

- **Sintaxe Enxuta e Limpa:** A linguagem favorece a legibilidade, evitando recursos complexos que tornam o código difícil de manter.

- **Binário Único e Autossuficiente:** Uma premissa de distribuição é que o Go compila o código em um **binário único**, que inclui todas as bibliotecas e módulos necessários, permitindo que o programa rode em qualquer sistema sem exigir ranhuras de **tempo de execução** (*runtimes*) ou dependências externas.

- **Pacote Padrão Completo:** Os desenvolvedores do Go acreditam que a biblioteca padrão deve ser robusta o suficiente para eliminar a necessidade frequente de dependências de terceiros.

#### 3. Gerenciamento Automático e Desempenho
A linguagem assume a responsabilidade por tarefas complexas que costumam causar bugs em outras linguagens.

- **Garbage Collection de Baixa Latência:** A premissa é que o desenvolvedor não deve se preocupar com a gestão manual de memória. 
    - O coletor de lixo do Go é otimizado para pausas curtíssimas (entre 10 e 100 microssegundos), minimizando o impacto no desempenho de sistemas de tempo real.

- **Tipagem Estática Sem Verbocidade:** Embora seja **estaticamente tipada** para garantir segurança em larga escala, Go utiliza **inferência de tipos** (como o operador `:=`) para manter a escrita ágil.

- **Velocidade de Compilação:** Uma diretiva de design crítica foi garantir que sistemas massivos, com milhares de engenheiros e linhas de código, pudessem ser compilados de forma extremamente rápida, evitando gargalos no processo de desenvolvimento.

#### 4. Abordagem Orientada a Objetos
Go adota uma premissa distinta para a organização de código:

- **Estruturas em vez de Classes:** Go não possui classes, objetos ou hierarquia de tipos (herança) tradicional.

- **Composição e Métodos:** A diretiva de design utiliza `Structs` (tipos definidos pelo usuário) e métodos para permitir um estilo de programação orientado a objetos que favorece a composição sobre a herança.

### Referências
- https://go.dev/
- https://cbt.ifsp.edu.br/images/Documentos/2021/CTII/CTII418_Go.pdf
- COX-BUDAY, Katherine. Concurrency in Go: Tools and Techniques for Developers. Sebastopol: O'Reilly Media, 2017.
- DOXSEY, Caleb. Introducing Go: Build Reliable, Scalable Programs. Sebastopol: O'Reilly Media, 2016.

### Ideia do Projeto
Nosso projeto será um sistema backend, desenvolvido em Go, para gerenciar o aluguel e agendamento de equipamentos, acessado por múltiplos usuários via web. 

#### Justificativa
A escolha da linguagem Go se justifica porque ela foi projetada para serviços de backend e nuvem, com suporte nativo à concorrência por meio de goroutines e channels, o que facilita o tratamento de muitas requisições simultâneas com boa performance e uso eficiente de recursos. 
Além disso, Go gera um binário único e autossuficiente, simplificando a implantação do sistema em diferentes servidores ou ambientes, sem dependências complexas. 
A sintaxe enxuta, a tipagem estática e a biblioteca padrão robusta contribuem para um código mais simples de manter e menos propenso a erros, o que é adequado para um projeto que pode evoluir e ser mantido por diferentes equipes ao longo do tempo.

## 2º Seminário

