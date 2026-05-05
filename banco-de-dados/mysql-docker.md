# Docker + MySQL
- Aqui estão alguns comandos do `Docker` e também uma maneira de usar ele junto com o servidor do `MySQL`.

## Comandos Docker
- Abaixo está listado os principais comandos do utilizados no `Docker` e uma breve explicação sobre o que ele faz.

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
>  O IP interno costuma ser algo como `172.17.0.2`, mas o mais comum é acessar via `localhost` usando o mapeamento de porta `-p`.

## Criando o Container com o MySQL
- Aqui está algumas intruções de como criar um container Docker com o `MySQL`.
```bash
# Baixar a imagem mais recente do MySQL:
docker pull mysql

# Baixar uma versão específica:
docker pull mysql:5.7

# Criar e rodar um container:
docker run --name <nome-do-container> -e MYSQL_ROOT_PASSWORD=<senha> -d mysql:<tag>
```

| Parâmetro | Descrição |
| :-------: | :-------: |
| `--name` | Define o nome do container |
| `-e` |	 Define variáveis de ambiente |
| `-d` |	 Roda em background (sem travar o terminal) |
| `<tag>` | Versão do MySQL que será usada |
| `-p <porta-host>:<porta-container>` 	Mapeia uma porta do host para o container |

- Exemplo mais Completo:
```bash
docker run --name meu-mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mysql:5.7
```

> [!NOTE]
> 
> O mapeamento `-p 3306:3306` faz com que toda requisição em `localhost:3306` seja redirecionada para o container. Sem isso, o MySQL fica acessível apenas internamente pelo IP do container.

### Variáveis de Ambiente
- Aqui estão listadas algumas variáveis de ambiente que podem ser úteis ao criar um Container com o `MySQL`.


| Variável | Descrição |
| :------: | :-------: |
| `MYSQL_ROOT_PASSWORD=<senha>` | Obrigatória, define a senha do usuário root |
| `MYSQL_DATABASE=<nome>` | Cria um banco de dados ao iniciar o container |
| `MYSQL_USER=<nome>` | Cria um novo usuário |
| `MYSQL_PASSWORD=<senha>` |	Define a senha do novo usuário criado |

- Exemplo:
```bash
docker run --name <nome-container> -e MYSQL_ROOT_PASSWORD=<senha> -e MYSQL_USER=<nome-usuario> -e MYSQL_PASSWORD=<senha> -e MYSQL_DATABASE=<nome-banco-de-dados> -p 3306:3306 -d mysql:5.7
```

## Acessando o MySQL dentro do container

```bash
docker exec -it <nome-do-container> bash
```

- Dentro do container, conecte-se ao MySQL:
```bash
mysql -u root -p
```

