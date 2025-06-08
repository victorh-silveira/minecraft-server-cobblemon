# Scripts

Esta pasta contém todos os scripts relacionados ao servidor Minecraft Cobblemon.

## Arquivos

- `start.sh` - Script de inicialização do servidor Minecraft
- `setup.sh` - Script de configuração inicial do projeto
- `README.md` - Este arquivo

## Scripts disponíveis

### setup.sh

Script de configuração inicial do projeto. Execute com:
```bash
make setup
# ou
./scripts/setup.sh
```

Este script:
- Verifica dependências (Docker/Docker Compose)
- Cria estrutura de diretórios necessária
- Copia arquivos de configuração de exemplo
- Aceita EULA automaticamente
- Constrói imagem Docker
- Prepara o servidor para uso

### start.sh

Script principal de inicialização do servidor Minecraft Cobblemon. Este script:

- Configura parâmetros otimizados da JVM
- Aceita automaticamente o EULA
- Detecta automaticamente o arquivo JAR do servidor
- Inicia o servidor com configurações otimizadas

O script é executado automaticamente pelo container Docker, mas também pode ser executado manualmente se necessário. 