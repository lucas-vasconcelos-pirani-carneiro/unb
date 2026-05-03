# Projeto 

- **Tema:** Qualquer banco de dados que possa ser utilizado para facilitar a vida acadêmica na UnB. 
    - Pode ser para auxiliar os professores, alunos, reitoria, comunicação com a sociedade.  

### Ideia do Projeto
- Um portal unificado para vagas de IC, estágio, monitoria, projetos de extensão, projetos voluntários que permitiria comunicação direta com o professor/orientador e no formato de fórum/comentários, a principal objetivo seria facilitar o acesso às oportunidades acadêmicas.

### Ideias da IA
- Algumas sugestões para enriquecer a ideia (pensando tanto em utilidade quanto no modelo de dados):

1. Perfil detalhado de usuários (aluno/professor/servidor)
    - Diferenciar tipos de usuários (aluno, professor, coordenador, empresa parceira).
    - Áreas de interesse do aluno (IA, redes, teoria, etc.) para sugerir vagas relevantes.
    - Currículo simplificado do aluno (link Lattes, GitHub, PDF do currículo salvado como binário no BD).

2. Vagas e oportunidades bem estruturadas
    - Tipos de oportunidade:
        - Iniciação científica (PIBIC, voluntária, etc.)
        - Estágio (interno na UnB, externo, empresas parceiras)
        - Extensão, monitoria, projetos de pesquisa, eventos (hackathons, escolas de inverno).
        - Campos interessantes:
        - Requisitos (CRA mínimo, disciplinas já cursadas, conhecimentos técnicos).
        - Carga horária, modalidade (presencial/remoto/híbrido).
        - Unidade (ICC, FGA, FUP…), departamento, laboratório. 

3. Sistema de candidatura/aplicação  
Em vez de só “fórum”, vocês podem ter:
     - Entidade de Candidatura (aluno → vaga), com status: “enviado”, “em análise”, “aprovado”, “recusado”.
    - Registro de mensagens entre aluno e professor relacionadas a uma candidatura específica.
    - Upload de arquivos (currículo, histórico), o que já cumpre o requisito de dado binário no banco.

4. Comunicação / fórum
    - Tópicos de discussão por vaga (tipo “tópico do fórum” para cada oportunidade).
    - Comentários em vagas (dúvidas gerais) separados das mensagens privadas da candidatura.
    - Notificações básicas (por exemplo, tabela de Notificações: “sua candidatura foi atualizada”, “nova mensagem do professor”).

5. Filtros e busca
   -  Filtro por área, tipo de vaga, campus, nível (graduação/pós).
    - Palavras-chave: por exemplo, “Python”, “Redes neurais”, “Direito ambiental”.
    - Isso gera boas entidades auxiliares: Tag, VagaTag, etc.

6. Integração leve com dados da UnB (mesmo que só conceitual)
   -  Entidade Curso (Computação, Eng. Elétrica, etc.) e Departamento (CIC, ENE, etc.).
    - Ligar aluno a um curso, professor a um departamento.
    - Mesmo se vocês não forem integrar com nenhum sistema real da UnB, ter esses dados na modelagem dá um toque mais “realista”.

7. Coisas que ajudam muito no projeto da disciplina  
Pensando já nos requisitos técnicos (View, Procedure, Trigger, chave automática, etc.), esse tema abre espaço para:
    -  View:
        - Ex.: “Vagas abertas por departamento”
        - Ex.: “Candidaturas de um aluno com status mais recente”. 
    - Procedure:
        - Ex.: criar_candidatura que já verifica se a vaga está aberta, se o aluno não se candidatou antes, etc. 
    - Trigger:
        - Ex.: ao mudar status da candidatura para “aprovado”, criar automaticamente uma notificação para o aluno.
        - Ex.: impedir que se exceda um limite de vagas abertas por professor (só exemplo). 
    - Chave primária automática:
        -  Em Vaga, Usuário, Candidatura, Mensagem, etc. é natural usar AUTO_INCREMENT/IDENTITY/SERIAL.
    - Ideia opcional: histórico e “portfólio” do aluno
        - Registrar oportunidades concluídas (o aluno foi aprovado e finalizou).
        - Isso vira um “histórico de participações” que o aluno pode mostrar depois.
        - Pro lado acadêmico, ajuda a visualizar engajamento em pesquisa e extensão.
    - Moderation leve / status de vagas
        - Vaga com status: rascunho, publicada, encerrada.
        - Possibilidade de “reportar” uma vaga (em caso de informação errada ou conteúdo indevido) – mesmo que no CRUD vocês só registrem isso.

- **Resumo:** Sistema de gestão de oportunidades acadêmicas, com candidatura, acompanhamento e comunicação estruturada.

### Datas Importantes
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
