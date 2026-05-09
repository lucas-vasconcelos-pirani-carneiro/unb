# Projeto 

**Tema:** Qualquer banco de dados que possa ser utilizado para facilitar a vida acadêmica na UnB. 

- Pode ser para auxiliar os professores, alunos, reitoria, comunicação com a sociedade.  

## Ideia do Projeto
Um portal unificado para vagas de IC, estágio, monitoria, projetos de extensão, projetos voluntários que permitiria comunicação direta com o professor/orientador e no formato de fórum/comentários, a principal objetivo seria facilitar o acesso às oportunidades acadêmicas.

## Engenharia de Software

### Visão Geral
O sistema é um portal unificado de oportunidades acadêmicas da UnB (iniciação científica, monitoria, estágios, extensão, voluntariado, eventos, etc.), voltado para alunos, professores e demais servidores.

Seu objetivo principal é centralizar a divulgação de vagas e permitir que alunos se candidatem, conversem com orientadores/responsáveis e acompanhem o andamento das candidaturas, facilitando o acesso às oportunidades e a comunicação.

### Atores

#### Aluno
- Pode ver vagas, filtrar, favoritar e se candidatar.
- Pode manter um perfil acadêmico (curso, áreas de interesse, links).
- Pode enviar mensagens relacionadas às candidaturas.

#### Professor / Orientador / Servidor
- Pode criar, editar e encerrar vagas.
- Pode gerenciar candidaturas (analisar, aprovar, recusar).
- Pode enviar mensagens para candidatos.

#### Coordenador / Administração
- Pode visualizar estatísticas gerais (vagas por departamento, quantidade de candidaturas, etc.).
- Pode sinalizar/fechar vagas indevidas ou com problemas.

### Requisitos Funcionais

#### RF1: Cadastro e autenticação de usuários
- O sistema deve permitir o cadastro de usuários com:
    - Nome completo
    - E-mail institucional (preferencial para alunos/professores)
    - Tipo de usuário (aluno, professor, coordenador, empresa parceira)
    - Senha (ou algum identificador, mesmo que a autenticação real não seja implementada no projeto)

- O sistema deve armazenar dados adicionais conforme o tipo:
    - Aluno: matrícula, curso, nível (graduação/pós), período.
    - Professor/Servidor: departamento, cargo.
    - Empresa parceira: nome da empresa, CNPJ (opcional), contato principal.

- O sistema deve permitir atualização de dados cadastrais.

#### RF2: Perfil acadêmico do usuário
- O sistema deve permitir ao aluno manter um perfil com:
    - Áreas de interesse (Ex: IA, redes, teoria da computação).
    - Palavras-chave de interesse (skills): ex. “Python”, “Machine Learning”.
    - Links externos: Lattes, GitHub, LinkedIn.
    - Upload de currículo em PDF (armazenado como arquivo binário no BD).

- O sistema deve permitir o registro do histórico de oportunidades concluídas (vaga em que o aluno foi aprovado e finalizou).

#### RF3: Gestão de cursos, departamentos e unidades da UnB
- O sistema deve manter uma tabela de Cursos (Ex.: Engenharia de Computação, Ciência da Computação, Direito).
- O sistema deve manter uma tabela de Departamentos (Ex.: CIC, ENE, FT).
- O sistema deve manter uma tabela de Unidades/Campi (Ex.: Darcy Ribeiro, FGA, FUP, Planaltina).
- Cada aluno deve estar vinculado a somente um curso.
- Cada professor/servidor deve estar vinculado a somente um departamento.
- Vagas devem estar vinculadas a uma unidade e opcionalmente a um departamento e/ou laboratório/grupo de pesquisa.

#### RF4: Cadastro e gestão de oportunidades (vagas)
- O sistema deve permitir a criação de diferentes tipos de vagas/oportunidades, incluindo:
    - Iniciação científica (PIBIC, voluntária, etc.)
    - Monitoria
    - Estágio (interno na UnB, externo, empresa parceira)
    - Projeto de extensão
    - Projeto voluntário
    - Eventos (hackathons, escolas de inverno, oficinas)

- Para cada vaga, devem ser armazenados pelo menos:
    - Título
    - Descrição detalhada
    - Tipo de oportunidade
    - Responsável (professor/servidor/empresa)
    - Unidade, departamento, laboratório (quando aplicável)
    - Requisitos:
        - CRA mínimo (quando aplicável)
        - Disciplinas desejadas/concluídas
        - Conhecimentos técnicos desejados (ex.: “Python”, “Redes Neurais”)
    - Carga horária semanal
    - Modalidade (presencial, remoto, híbrido)
    - Período de vigência / datas importantes (início/fim da candidatura)
    - Número máximo de vagas/posições disponíveis
    - Status da vaga: rascunho, publicada, encerrada, cancelada.

- O sistema deve permitir que o responsável edite e encerre vagas.
- O sistema deve permitir que usuários visualizem as vagas publicadas.

#### RF5: Sistema de candidatura / aplicação às vagas
- O sistema deve permitir que o aluno se candidate a uma vaga publicada.
- Para cada candidatura, devem ser registrados:
    - Vaga
    - Aluno
    - Data/hora da candidatura
    - Mensagem/apresentação inicial do aluno (texto)
    - Status da candidatura: enviado, em análise, aprovado, recusado, cancelado.

- O sistema deve permitir que o responsável pela vaga altere o status da candidatura.
- O sistema deve impedir que o aluno se candidate mais de uma vez à mesma vaga (restrição).
- O sistema deve permitir ao aluno anexar documentos à candidatura (por exemplo, histórico em PDF, carta de motivação) – novamente como dados binários.
- O sistema deve permitir o registro de quando uma candidatura foi concluída com sucesso (aprovado e período finalizado), para alimentar o histórico/portfólio do aluno.

#### RF6: Comunicação e mensagens
- O sistema deve permitir mensagens privadas entre aluno e responsável, vinculadas a uma candidatura específica.
    - Cada mensagem deve ter: remetente, destinatário, data/hora, conteúdo textual.

- O sistema deve permitir comentários públicos em cada vaga (tópico de discussão da vaga):
    - Todo usuário autenticado pode visualizar os comentários.
    - Os comentários devem estar vinculados à vaga e ao autor.

- O sistema deve registrar notificações para eventos importantes, por exemplo:
    - Mudança de status de candidatura.
    - Nova mensagem recebida.
    - Novo comentário na vaga criada pelo professor.

- As notificações devem incluir:
    - Usuário destinatário
    - Tipo de evento
    - Referência (vaga/candidatura/mensagem)
    - Data/hora
    - Status (lida/não lida).

#### F7: Filtros, busca e tags
- O sistema deve permitir filtrar vagas por:
    - Tipo de oportunidade
    - Unidade/campus
    - Departamento
    - Modalidade (presencial/remoto/híbrido)
    - Nível (graduação/pós, quando aplicável)

- O sistema deve permitir a busca por palavras-chave no título/descrição da vaga.
- O sistema deve permitir o uso de tags (palavras-chave) associadas às vagas:
    - Exemplo: “Python”, “Redes Neurais”, “Educação”, “Direito Ambiental”.

- O sistema deve permitir sugerir vagas ao aluno com base:
    - No curso
    - Nas áreas de interesse
    - Nas tags das vagas.

#### RF8: Moderação e integridade das vagas
- O sistema deve permitir que usuários reportem uma vaga (denúncia de conteúdo indevido ou informação errada).
    - Ao menos, deve ser armazenado:
        - Vaga reportada
        - Usuário que reportou
        - Motivo (texto)
        - Data/hora
        - Status do reporte (pendente, em análise, resolvido).
    - Usuários com perfil de coordenação/admin podem:
        - Visualizar vagas reportadas
        - Marcar reportes como resolvidos
        - Alterar o status de uma vaga (por exemplo, de publicada para encerrada/cancelada).

#### RF9: Histórico e portfólio do aluno
- O sistema deve manter um histórico das oportunidades que o aluno:
    - Se candidatou
    - Foi aprovado
    - Efetivamente concluiu (participação finalizada).

- Esse histórico deve ser facilmente recuperado (ex.: “todas as oportunidades concluídas pelo aluno X”).
- Essas informações podem ser utilizadas para gerar uma espécie de “portfólio” acadêmico do aluno.

#### RF10: Consultas e relatórios (pensando em Views e Procedures)
- O sistema deve permitir consultas consolidadas, por exemplo:
    - Vagas abertas por departamento.
    - Número de candidaturas por vaga.
    - Candidaturas de um aluno com status mais recente.

- Deve ser possível obter informações de:
    - Quantidade de vagas por tipo (IC, extensão, estágio…).
    - Distribuição de vagas por unidade/campus.

- Algumas dessas consultas podem ser implementadas como Views no banco.

### Requisitos Não Funcionais

#### RNF1: Integridade referencial
- Todas as relações entre usuários, vagas, candidaturas, mensagens, cursos, departamentos etc. devem ser implementadas com chaves estrangeiras e restrições adequadas.

#### RNF2: Consistência dos dados
- O banco deve garantir que não haja candidaturas duplicadas do mesmo aluno para a mesma vaga (restrição única).
- O status de uma vaga e suas candidaturas devem manter coerência (não aceitar novas candidaturas se a vaga estiver encerrada).

#### RNF3: Segurança mínima dos dados sensíveis
- Senhas (se armazenadas) devem ser guardadas de forma não reversível (hash) — conceitualmente, você pode citar isso mesmo que não implemente no SQL cru.

#### RNF4: Desempenho básico
- Devem existir índices sobre colunas usadas com frequência em buscas/filtros (por exemplo, tipo de vaga, unidade, status).

#### RNF5 – Escalabilidade conceitual
- O modelo deve permitir inclusão de novos tipos de oportunidade e de novas tags sem necessidade de mudança no esquema principal.


### Regras de Negócio
- Um aluno não pode se candidatar a uma vaga que:
    - Não esteja com status “publicada”.
    - Esteja com prazo de candidatura expirado.

- Um aluno não pode ter mais de uma candidatura ativa para a mesma vaga.
- Ao mudar o status de uma candidatura para “aprovado”:
    - O sistema deve criar automaticamente uma notificação para o aluno.
    - (Opcional) Pode existir uma trigger que registre a data de aprovação.

- Ao mudar o status de uma candidatura para “aprovado” e, posteriormente, “concluída”:
    - O sistema deve registrar essa oportunidade no histórico de participações do aluno (pode ser a própria tabela de candidaturas com um campo de conclusão).

- Uma vaga só pode ser “encerrada” se:
    - O período de candidatura já tiver passado, ou
    - O responsável decidir encerrá-la manualmente.

- (Opcional) Limite de vagas por professor:
    - Poderia existir uma regra (e eventualmente uma trigger) que limita, por exemplo, a quantidade de vagas simultaneamente abertas por um professor.

- Não devem ser aceitos uploads de arquivos acima de um tamanho máximo (regra conceitual; você pode apenas documentar no requisito).

## Datas Importantes
- [ X ] 05/05: Nomes dos Grupos e o Tema do Projeto
- [ ] 30/05: Primeira Parte
- [ ] 30/06 ou 02/07: Entrega Final e Apresentação

## 1º Seminário
- [ ] Introdução  
- [ ] Modelo de Entidade Relacionamento. **Usando alguma ferramenta de modelagem**.  
- [ ] Modelo Relacional. **Usando alguma ferramenta de modelagem**.  
- [ ] O script SQL que gerou o banco de dados  
- [ ] A indicação do uso de IA.

- Deverá ser entregue em apenas um arquivo `.pdf` contendo todaa essas partes.

## 2º Seminário

- [ ] Introdução  
- [ ] Modelo de Entidade Relacionamento. **Usando alguma ferramenta de modelagem.**  
- [ ] Modelo Relacional. **Usando alguma ferramenta de modelagem.**  
- [ ] O script SQL que gerou o banco de dados. 
    - Na  implementação  de pelo **menos uma tabela** usar um gerador de chave  primária automástico do SGBD selecionado para o projeto. 
- [ ] **A construção da camada de persistência.** Enviar o link do github com os códigos fontes e um diagrama apresentando como a interface gráfica do programa acessa a camada de persistência.  
- [ ] **Um programa com as funções de CRUD (Create Read Update Delete) para o seu sistema**.   
    - Acessar mais de uma tabela nas mesmas funções CRUD para garantir integridade referencial. 
- [ ] Utilização de pelo menos uma *View*.  
- [ ] Utilização de pelo menos uma *Procedure*.  
- [ ] Utilização de pelo menos um *Trigger*.  
- [ ] Inserção de um dado binário no banco, pode ser foto, arquivo PDF ou outro tipo 
de arquivo.  
- [ ] A indicação do uso de IA.
- [ ] No início do PDF informar o endereço do github no início do projeto.

- Deverá ser entregue em apenas um arquivo `.pdf` contendo todas essas partes.

> [!NOTE] 
> 
> Tem que colocar no GitHub: O script SQL que gerou o banco de dados e Todos os códigos do projeto.
