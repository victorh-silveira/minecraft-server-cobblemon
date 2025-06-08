# Docker

Esta pasta contém todos os arquivos relacionados ao Docker para o servidor Minecraft Cobblemon.

## Arquivos

- `Dockerfile` - Definição da imagem Docker do servidor
- `docker-compose.yml` - Configuração dos serviços Docker
- `README.md` - Este arquivo

## Como usar

Execute os comandos Docker a partir da pasta raiz do projeto usando o Makefile:

```bash
# Construir a imagem
make build

# Iniciar o servidor
make start

# Parar o servidor
make stop

# Ver logs
make logs
```

Ou execute diretamente da pasta docker:

```bash
cd docker
docker-compose up -d
``` 