# Projeto - LP

Colocar informações a colocar em cada slides, selecionar informações sobre o que colocar nos slides 

## Linguagem GO

- Go foi criado no Google em 2007 e, desde então, equipes de engenharia em todo o Google adotaram Go para criar produtos e serviços em grande escala.
- Empresas que utilizam GO:
	- Google, Netflix, Dropbox, Meta, Microsoft, Trivago, Uber, Twitch, ... 
- Foi projetada com o objetivo de resolver problemas de **escalabilidade** e **produtividade** em ambientes de sistemas complexos. 
- Foca em **simplicidade**, **eficiência** e, principalmente, no suporte nativo à **concorrência**.

### Domínios de Aplicação

- O Go não é uma linguagem de "propósito geral" da mesma forma que o Python ou Java, pois sua arquitetura é fortemente voltada para a **infraestrutura**.

	- **Serviços de Nuvem (*Cloud Native*):**  A maioria das ferramentas que compõem a <u>infraestrutura moderna de nuvem</u> foi feita em Go, como Docker, Kubernetes e Terraform.

    - **Microsserviços e APIs:** Devido ao seu <u>baixo consumo de memória</u> e <u>inicialização rápida</u> se torna ideal para arquiteturas de microsserviços.

    - **Sistemas de Redes e Distribuídos:** A facilidade de gerenciar milhares de <u>conexões simultâneas</u> (através das Goroutines) torna a linguagem perfeita para **servidores de chat**, **proxies** e ferramentas de **monitoramento de rede**.

    - **Ferramentas de CLI (Linha de Comando)**: Por compilar para um único binário <u>estático e independente</u> se eficiente para criar ferramentas de terminal rápidas e portáteis.

    - **DevOps e Site Reliability Engineering (SRE):** <u>Automação de infraestrutura e ferramentas de pipeline</u> utilizam Go pela sua <u>confiabilidade e performance</u>.

### Usuários Característicos

- **Engenheiros de Back-end:** Desenvolvedores que precisam construir sistemas escaláveis que suportem **alto tráfego** sem que o custo de servidor (CPU/RAM) dispare.

- **Profissionais de DevOps e SRE:** Usuários que precisam criar ferramentas de <u>automação robustas</u> que rodem de forma consistente em diferentes sistemas operacionais.

- **Contribuidores de Open Source:** Como o ecossistema de infraestrutura (Cloud Native Computing Foundation) é quase todo em Go, há uma comunidade enorme de desenvolvedores que mantêm essas ferramentas globais.

> [!IMPORTANT]
>
> Diferencial Técnico: O Modelo de Concorrência

### Casos de Uso

#### Interfaces de Linha de Comando (CLIs)

- **Portabilidade e Desempenho:** Go é preferido por desenvolvedores de CLIs devido à sua portabilidade e rapidez de execução.
- **Binário Único:** A linguagem compila o código em um único arquivo binário independente, o que torna a instalação e a distribuição extremamente simples, sem necessidade de bibliotecas ou runtimes externos.
- **Inicialização Instantânea:** Programas em Go têm um tempo de inicialização imediato, semelhante a C ou C++.
- **Ecossistema:** As bibliotecas Cobra e Viper são os padrões da comunidade para criar CLIs modernas e potentes.
- **Exemplos de Uso:** Docker, Kubernetes, GitHub CLI, Hugo e Stripe.

#### DevOps e Engenharia de Confiabilidade de Site (SRE)

- **Automação e Escala:** Go ajuda equipes de DevOps a automatizar tarefas e melhorar processos de CI/CD, permitindo que as organizações escalem com eficiência.
- **Robustez:** Mesmo scripts pequenos tornam-se mais seguros graças à tipagem estática e ao tratamento explícito de erros da linguagem.
- **Biblioteca Padrão:** Possui pacotes integrados poderosos para lidar com protocolos como HTTP, manipulação de arquivos JSON/CSV e expressões regulares.
- **Baixo Consumo:** O coletor de lixo (garbage collector) e o baixo uso de memória facilitam a manutenção de aplicações maiores.
- **Exemplos de Uso:** Terraform, Prometheus, Docker e Drone.

#### Serviços de Nuvem e Redes

- **Concorrência Nativa:** Go foi criado especificamente para lidar com as necessidades de concorrência de aplicações em nuvem e microsserviços, utilizando goroutines para gerenciar recursos de forma eficiente.
- **Custo-Benefício:** Devido ao baixo uso de CPU e memória, além da inicialização rápida, servidores em Go são mais baratos de rodar em ambientes de nuvem e serverless.
- **Ecossistema Cloud Native:** Mais de 75% dos projetos da Cloud Native Computing Foundation são escritos em Go.
- **Exemplos de Uso:** Google Cloud (Kubernetes, Istio), Dropbox (que migrou do Python para Go), MercadoLibre e Netflix.

#### Desenvolvimento Web

- **Escalabilidade e Segurança:** Go permite desenvolver aplicações web rápidas, seguras e altamente escaláveis.
- **Servidor Integrado:** A linguagem já vem com um servidor web de alto desempenho e um sistema de templates seguro, reduzindo a dependência de frameworks externos.
- **Suporte a Tecnologias Modernas:** Suporta nativamente padrões como HTTP/2, TLS 1.3 e diversos bancos de dados (MySQL, MongoDB, Elasticsearch).
- **Simplicidade:** Equipes relatam que o uso de Go resulta em menos código e maior facilidade de manutenção em comparação com outras linguagens.
- **Exemplos de Uso:** Caddy (servidor web), Cloudflare, Medium e Mattermost

> Informações retiradas da documentação oficial da linguagem disponível em: [Link](https://go.dev/)

## 1º Seminário

### Ideis de Projeto

- Um "Log Aggregator" em Tempo Real
- Um Proxy Reverso ou Balanceador de Carga
- Um Web Scraper Concorrente
- Uma Ferramenta de CLI para Processamento de Arquivos
- Sistema para lidar com o problema na fila de espera na matrícula do SIGAA. Quando é dia realizar matrícula a site da faculdade fica muito lento, ou não entra na página, ou aparece alguma mensagem pedindo para esperar na fila (algo parecido). A ideia seria do projeto seria tentar solucionar essa problema que provavelmente ocorre devido a diversos acesso simultâneos. 
	- ***"C10k problem":*** Gerenciar dez mil ou mais conexões simultâneas de forma eficiente.

Explicação da IA:

- O problema da sua faculdade geralmente não é falta de banco de dados, mas sim que o servidor web convencional "engasga" ao tentar manter tantas conexões abertas ao mesmo tempo, ou o sistema de arquivos/banco de dados trava com tantos pedidos idênticos.

Para transformar isso em um projeto que explore o potencial do Go, eu sugiro você focar em uma destas duas frentes:
1. Um Sistema de Fila de Espera (Virtual Queue)

Em vez de deixar o usuário dando "F5" e derrubando o servidor, você cria um serviço em Go que fica na frente do site da matrícula.

    Como funcionaria: O Go recebe a conexão, entrega um "token" de posição na fila para o aluno e mantém uma conexão leve (via WebSockets ou Long Polling) informando o tempo de espera.

    A "Essência" do Go aqui: Você usaria Goroutines para gerenciar cada aluno na fila e Channels para processar a entrada e saída da fila de forma sincronizada, garantindo que ninguém "fure" a posição.

2. Um Rate Limiter (Limitador de Taxa)

Muitas vezes o site cai porque alguns alunos (ou scripts criados por eles) fazem requisições rápidas demais.

    Como funcionaria: Um "pedágio" que analisa o IP do aluno. Se ele fizer mais de 2 requisições por segundo, o Go bloqueia temporariamente aquele usuário antes mesmo de a requisição chegar no servidor lento da faculdade.

    A "Essência" do Go aqui: Go é extremamente rápido para processar cabeçalhos HTTP. Você poderia usar uma estrutura de dados chamada Token Bucket implementada com concorrência, protegendo o servidor principal de um ataque de negação de serviço (DoS) acidental dos alunos.

3. Um Cache de Gravação Concorrente

Se o problema for o banco de dados travando na hora de salvar a matrícula:

    Como funcionaria: O site aceita a matrícula do aluno e joga em uma "fila de escrita" na memória (usando Go). O aluno recebe um "OK, estamos processando" instantâneo. O Go, então, vai salvando no banco de dados devagar, no ritmo que o banco aguenta.

    A "Essência" do Go aqui: O uso de Buffered Channels como um buffer de mensagens entre o tráfego pesado da web e a lentidão do banco de dados.

Por que isso é "puro Go"?

    Baixo Footprint: Enquanto um servidor em Java ou Python consumiria muita RAM para manter 5.000 alunos esperando, o Go faria isso usando pouquíssimos recursos.

    Segurança de Tipos e Dados: Ao lidar com matrículas, você não quer erros de memória. O sistema de tipos do Go ajuda a manter o código robusto.

    Simplicidade de Deploy: Você pode compilar esse sistema de fila e rodar em qualquer servidor Linux da faculdade sem precisar instalar dezenas de dependências.


1. Eficiência de Memória (Goroutines vs Threads)

Em linguagens tradicionais como Java ou Python, cada aluno conectado ao site ocuparia uma Thread do sistema operacional. Cada thread consome cerca de 1MB de memória. Se 5.000 alunos tentarem entrar ao mesmo tempo, o servidor precisaria de 5GB só para "manter as pessoas na linha".

No Go, usamos Goroutines.

    Cada uma começa ocupando apenas 2KB.

    Você consegue manter os mesmos 5.000 alunos esperando usando apenas 10MB de RAM.

    Isso impede que o servidor da faculdade trave por falta de memória (o famoso "Out of Memory").

2. O Modelo de Concorrência (CSP)

O Go utiliza um modelo chamado Communicating Sequential Processes. Em vez de travar o banco de dados com milhares de tentativas de escrita ao mesmo tempo (o que causa o erro no site da faculdade), você usa Channels.

    Os Channels funcionam como uma esteira de produção organizada.

    Você pode receber 10.000 pedidos de matrícula e enfileirá-los de forma segura, processando um por um (ou de dez em dez) sem que os dados se corrompam e sem derrubar a conexão do aluno.

3. Performance de Rede Nativa

O Go foi escrito para a era da internet. A biblioteca padrão de rede (net/http) é considerada uma das melhores do mundo.

    Diferente de outras linguagens que precisam de servidores externos (como Apache ou Nginx) para serem eficientes, um binário simples de Go já vem com um servidor de alta performance embutido.

    Para o seu projeto de matrícula, isso significa menos camadas de software onde algo pode dar errado.

4. Binários Estáticos (Portabilidade)

Se você desenvolver essa solução, você gera um único arquivo executável.

    Você não precisa instalar o "Go" no servidor da faculdade.

    Basta enviar o arquivo e rodar. Isso é vital em ambientes acadêmicos ou corporativos onde você não tem permissão para instalar diversas dependências ou máquinas virtuais (como a JVM do Java).

Resumo para o seu Professor:

Você pode argumentar que o projeto se adequa ao Go porque a linguagem foi desenhada para sistemas distribuídos de alta carga. O problema da matrícula não é de "lógica complexa", mas de gestão de tráfego e recursos, que é exatamente onde o runtime do Go brilha ao oferecer alta performance com um custo de hardware baixíssimo.

1. Concorrência na Entrada (O "Portão")

Quando 5.000 alunos acessam o site ao mesmo tempo, cada conexão é independente.

    Sem Go: O servidor teria que abrir uma "thread" pesada para cada aluno. Se o servidor só aguenta 500 threads, o aluno 501 recebe um erro de "Servidor Indisponível".

    Com Go: O servidor dispara uma Goroutine para cada conexão. Como elas são minúsculas, o Go consegue "segurar a mão" de todos os 5.000 alunos simultaneamente sem derrubar o sistema.

2. Concorrência na Fila (O "Canal")

Aqui entra o conceito de Channels (Canais). Imagine que a fila de matrícula é uma esteira rolante.

    Várias Goroutines (alunos chegando) estão "jogando" pedidos na esteira.

    Outras Goroutines (processadores de matrícula) estão do outro lado da esteira "pegando" os pedidos para salvar no banco de dados.

    O trunfo do Go: O canal sincroniza isso automaticamente. Se a esteira estiver cheia, quem está tentando entrar espera um milissegundo. Se estiver vazia, quem processa espera. Isso evita que dois alunos "atropelem" o banco de dados ao mesmo tempo.

3. Concorrência no Processamento (Os "Trabalhadores")

Você não precisa processar uma matrícula por vez. Você pode ter, por exemplo, 10 "trabalhadores" (Worker Pool) rodando em paralelo.

    Se um banco de dados demora 1 segundo para confirmar uma matrícula, 1 trabalhador faria 60 matrículas por minuto.

    Com concorrência, você coloca 10 Goroutines trabalhadoras e faz 600 matrículas por minuto, usando o mesmo tempo de espera.

A diferença entre Concorrência e Paralelismo

É um ponto que o seu professor pode perguntar, e o Go lida com os dois:

    Concorrência: É sobre lidar com muitas coisas ao mesmo tempo (gerenciar os 5.000 alunos esperando, mesmo que você só tenha 1 processador).

    Paralelismo: É sobre fazer muitas coisas ao mesmo tempo (usar os 4 ou 8 núcleos do processador da faculdade para salvar as matrículas de fato).

    A essência do Go: O Go foi desenhado para que você escreva código concorrente (fácil de entender) e o runtime da linguagem transforma isso em paralelismo (performance pura) automaticamente para você.


#### Informações sobre GO
- https://go.dev/
- https://cbt.ifsp.edu.br/images/Documentos/2021/CTII/CTII418_Go.pdf
- https://medium.com/@parvez0khan/building-a-simple-authentication-system-in-go-and-react-0859006632c2
- https://blog.devgenius.io/golang-concurrency-worker-pool-2aff9cbc6255
    - Pool Workers 

#### 

1º Seminário
- Justificar a linguagem GO
	- Domínio de Aplicação
	- Usuário Característico
- Por que ao projeto se adequa a linguagem escolhida ?

## 2º Seminário
