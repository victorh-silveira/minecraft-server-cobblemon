# Servidor Minecraft Cobblemon

Um servidor Minecraft com o mod Cobblemon rodando em Docker, permitindo capturar e treinar Pokémon no mundo do Minecraft!

## Especificações

- **Minecraft**: 1.20.1
- **Forge**: 47.3.0  
- **Cobblemon**: 1.5.2+1.20.1
- **Kotlin for Forge**: 4.11.0-all
- **Memória**: 6GB RAM
- **Porta**: 25565
- **Mundo**: 
- **Modo**: Survival
- **Dificuldade**: Normal

## Início Rápido

### Configuração inicial (automática):
```bash
make setup
```

Este comando irá:
- Verificar dependências (Docker/Docker Compose)
- Criar estrutura de diretórios
- Copiar arquivos de configuração
- Construir imagem Docker
- Preparar servidor para uso

### Configuração manual (opcional):
1. **Configure arquivos básicos**:
   ```bash
   # Editar configurações
   # - docs/network-setup.md: configure seu IP e domínio
   # - configs/server.properties: ajuste configurações do servidor
   ```

2. **Ajuste configurações avançadas**:
   - Modifique `docker/docker-compose.yml` se precisar alterar portas ou memória

### Comandos básicos:
```bash
make start    # Iniciar servidor
make stop     # Parar servidor  
make logs     # Ver logs
make status   # Ver status
```

## Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `make help` | Mostra todos os comandos disponíveis |
| `make setup` | Configuração inicial (primeira vez) |
| `make build` | Constrói a imagem Docker |
| `make start` | Inicia o servidor |
| `make stop` | Para o servidor |
| `make restart` | Reinicia o servidor |
| `make logs` | Mostra logs em tempo real |
| `make status` | Mostra status do servidor |
| `make shell` | Acessa shell do container |
| `make console` | Acessa console do Minecraft |
| `make backup` | Cria backup do mundo |
| `make restore BACKUP=arquivo` | Restaura backup |
| `make clean` | Remove containers e imagens |
| `make update` | Atualiza e reinicia servidor |

## Como Conectar

### Para você (rede local):
1. Abra o Minecraft 1.20.1 com Forge 47.3.0 instalado
2. Instale os mods necessários (veja seção "Mods Necessários")
3. Conecte-se ao servidor: `localhost:25565`

### Para seus amigos (internet):
1. Eles precisam ter exatamente as mesmas versões dos mods
2. Conectar em: **`noobz.ddns.net:25565`**

  > **Configuração de rede**: Veja o arquivo `network-setup.md` para detalhes completos

## Mods Necessários para Jogar

**IMPORTANTE**: Todos os jogadores devem ter exatamente estas versões instaladas:

### Mods Obrigatórios:
1. **Cobblemon** - Versão `1.5.2+1.20.1` para Forge
   - Download: [Modrinth](https://modrinth.com/mod/cobblemon/version/vm5zUZAg)
   - Arquivo: `Cobblemon-forge-1.5.2+1.20.1.jar` (~100MB)

2. **Kotlin for Forge** - Versão `4.11.0-all`
   - Download: [Modrinth](https://modrinth.com/mod/kotlin-for-forge/version/hmeyC41q)
   - Arquivo: `kotlinforforge-4.11.0-all.jar` (~7MB)

### Como Instalar os Mods:

#### Opção 1: Launcher Oficial (Premium)
1. Instale o **Minecraft Forge 47.3.0** para Minecraft 1.20.1
2. Baixe os mods acima
3. Coloque os arquivos `.jar` na pasta `mods` do seu perfil
4. Inicie o Minecraft com o perfil Forge

#### Opção 2: Launchers Não Oficiais (Recomendado)
**Prism Launcher** (Mais fácil):
1. Baixe: https://prismlauncher.org/
2. Crie nova instância: Minecraft 1.20.1 + Forge 47.3.0
3. Adicione os mods pela interface do launcher
4. Configure conta offline se necessário

**TLauncher** (Alternativa):
1. Baixe: https://tlauncher.org/
2. Selecione Minecraft 1.20.1 + Forge 47.3.0
3. Instale os mods na pasta `mods`

### Verificação Importante:
- **Versões devem ser EXATAS** - diferenças causam incompatibilidade
- **Forge 47.3.0** é obrigatório para Minecraft 1.20.1
- Sem os mods, você não conseguirá entrar no servidor

## Configurações

### Modificar configurações do servidor:
Edite o arquivo `configs/server.properties` e reinicie:
```bash
make restart
```

### Adicionar mods:
1. Coloque os arquivos `.jar` na pasta `mods/`
2. Reinicie o servidor:
```bash
make restart
```

### Ajustar memória:
Edite a variável `JAVA_MEMORY` no `docker-compose.yml`

## Backups

### Criar backup:
```bash
make backup
```

### Restaurar backup:
```bash
make restore BACKUP=world_backup_20240125_143022.tar.gz
```

Os backups ficam salvos na pasta `backups/`

## Estrutura de Arquivos

```
minecraft-server-cobblemon/
├── docker/                 # Arquivos Docker
│   ├── Dockerfile          # Imagem Docker
│   ├── docker-compose.yml  # Orquestração
│   ├── .dockerignore       # Arquivos ignorados no build
│   └── README.md           # Documentação Docker
├── scripts/                # Scripts do projeto
│   ├── start.sh            # Script de inicialização
│   ├── setup.sh            # Script de configuração inicial
│   └── README.md           # Documentação scripts
├── docs/                   # Documentação
│   ├── network-setup.md    # Configuração de rede
│   ├── setup-rapido.md     # Guia rápido
│   └── SECURITY.md         # Políticas de segurança
├── configs/                # Configurações
│   ├── server.properties   # Configurações do servidor
│   ├── server.properties.example # Exemplo de configuração
│   ├── eula.txt            # Acordo de licença
│   └── README.md           # Documentação configurações
├── data/                   # Dados do servidor
│   └── backups/            # Backups do mundo
├── Makefile                # Comandos automatizados
├── world/                  # Mundo do servidor
├── mods/                   # Mods instalados
├── config/                 # Configurações dos mods
├── logs/                   # Logs do servidor
└── crash-reports/          # Relatórios de crash
```

## Solução de Problemas

### Servidor não inicia:
```bash
make logs  # Verificar logs de erro
```

### Problemas de memória:
- Reduza `JAVA_MEMORY` no `docker-compose.yml`
- Verifique se tem RAM suficiente disponível

### Mods não carregam:
- Verifique compatibilidade das versões
- Confira logs para erros específicos

### Mundo corrompido:
```bash
make restore BACKUP=seu_backup.tar.gz
```

## Recursos do Cobblemon

- Captura de Pokémon no mundo
- Sistema de batalhas
- Evolução de Pokémon  
- Pokédex integrada
- Centros Pokémon
- Criação de Pokémon
- Mais de 400 Pokémon disponíveis

## Links Úteis

- [Cobblemon Wiki](https://wiki.cobblemon.com/)
- [Discord Cobblemon](https://discord.gg/cobblemon)
- [Modrinth Cobblemon](https://modrinth.com/mod/cobblemon)

## Requisitos

- Docker e Docker Compose instalados
- Make instalado
- Pelo menos 8GB de RAM disponível
- Porta 25565 liberada

## Notas

- O servidor aceita conexões não-premium (`online-mode=false`)
- PvP está habilitado por padrão
- Backups automáticos não estão configurados (use `make backup`)
- **Mods obrigatórios**: Cobblemon 1.5.2+1.20.1 e Kotlin for Forge 4.11.0-all
- Servidor roda na porta padrão **25565**
- Compatível apenas com Minecraft 1.20.1 + Forge 47.3.0

## Links Diretos dos Mods

Para facilitar o download pelos seus amigos:

- **Cobblemon 1.5.2**: https://cdn.modrinth.com/data/MdwFAVRL/versions/vm5zUZAg/Cobblemon-forge-1.5.2%2B1.20.1.jar
- **Kotlin for Forge 4.11.0**: https://cdn.modrinth.com/data/ordsPcFz/versions/hmeyC41q/kotlinforforge-4.11.0-all.jar

---

**Boa sorte capturando Pokémon!** 
