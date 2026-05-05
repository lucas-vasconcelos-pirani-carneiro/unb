# Docker + PostgreSQL
- Aqui estão alguns comandos do `Docker` e também uma maneira de usar ele junto com o servidor do `PostgreSQL`.

## Comandos Docker
- Abaixo está listado os principais comandos utilizados no `Docker` e uma breve explicação sobre o que ele faz.

```bash
# Listar containers em execução:
docker ps

# Listar todos os containers, incluindo os parados:
docker ps -a

# Parar um ou mais containers:
docker stop <nome/id> <nome/id> ...

# Remover forçadamente, mesmo que esteja rodando:
docker rm <nome/id> <nome/id>

# Listar imagens baixadas:
docker images

# Rede
# Descobrir o IP do container:
docker inspect <nome-do-container> | grep IPAddress
```

> [!NOTE]
> 
> O IP interno costuma ser algo como `172.17.0.2`, mas o mais comum é acessar via `localhost` usando o mapeamento de porta `-p`.

## Criando o Container com o PostgreSQL
- Aqui estão algumas instruções de como criar um container Docker com o `PostgreSQL`.

```bash
# Baixar a imagem mais recente do PostgreSQL:
docker pull postgres

# Baixar uma versão específica:
docker pull postgres:15

# Criar e rodar um container:
docker run --name <nome-do-container> -e POSTGRES_PASSWORD=<senha> -d postgres:<tag>
```

|              Parâmetro              |                  Descrição                 |
| :---------------------------------: | :----------------------------------------: |
|               `--name`              |         Define o nome do container         |
|                 `-e`                |        Define variáveis de ambiente        |
|                 `-d`                | Roda em background (sem travar o terminal) |
|               `<tag>`               |     Versão do PostgreSQL que será usada    |
| `-p <porta-host>:<porta-container>` |  Mapeia uma porta do host para o container |


- Exemplo mais completo:
```bash
docker run --name meu-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=meubanco -p 5432:5432 -d postgres:15
```

> [!NOTE]
>
> O mapeamento `-p 5432:5432` faz com que toda requisição em `localhost:5432` seja redirecionada para o container. Sem isso, o PostgreSQL fica acessível apenas internamente.

### Variáveis de Ambiente
- Aqui estão algumas variáveis úteis ao criar um container com `PostgreSQL`:

|           Variável          |                  Descrição                 |
| :-------------------------: | :----------------------------------------: |
| `POSTGRES_PASSWORD=<senha>` | **Obrigatória**, define a senha do usuário |
|  `POSTGRES_USER=<usuario>`  |           Define o usuário padrão          |
|     `POSTGRES_DB=<nome>`    |       Cria um banco de dados inicial       |

- Exemplo:
```bash
docker run --name <nome-container> -e POSTGRES_USER=<usuario> -e POSTGRES_PASSWORD=<senha> -e POSTGRES_DB=<nome-banco> -p 5432:5432 -d postgres:15
```

## Acessando o PostgreSQL dentro do container

```bash
docker exec -it <nome-do-container> bash
```

- Dentro do container, conecte-se ao PostgreSQL:
```bash
psql -U <usuario> -d <nome-do-banco>
```

- Acessando direto pelo terminal sem entrar pelo `bash`:
```bash
docker exec -it <nome-do-container> psql -U <usuario> -d <nome-do-banco>
```

## Observações importantes
- Porta padrão do PostgreSQL: **5432**.
- Usuário padrão geralmente: `postgres`.
- O PostgreSQL já cria automaticamente o banco definido em `POSTGRES_DB`.
