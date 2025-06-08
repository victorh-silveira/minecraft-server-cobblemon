# Configurações

Esta pasta contém todos os arquivos de configuração do servidor Minecraft Cobblemon.

## Arquivos

- `server.properties` - Configurações principais do servidor Minecraft
- `server.properties.example` - Exemplo de configuração com comentários
- `eula.txt` - Acordo de licença do Minecraft (EULA)
- `README.md` - Este arquivo

## Como usar

### server.properties

Este arquivo contém as configurações principais do servidor, como:
- Porta do servidor
- Modo de jogo (survival, creative, etc.)
- Dificuldade
- Configurações de mundo
- Limites de jogadores
- E muito mais...

Para modificar as configurações:
1. Edite o arquivo `configs/server.properties`
2. Reinicie o servidor: `make restart`

### eula.txt

Arquivo que indica aceitação do EULA (End User License Agreement) do Minecraft.
- Deve conter `eula=true` para o servidor funcionar
- É criado automaticamente pelo script de setup

### server.properties.example

Arquivo de exemplo com todas as configurações disponíveis e comentários explicativos.
Use como referência para entender as opções disponíveis. 