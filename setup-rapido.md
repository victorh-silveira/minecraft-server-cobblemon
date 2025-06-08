# Setup Rápido - Servidor Cobblemon

## Para o Administrador (Você)

```bash
# Clonar o repositório
git clone https://github.com/SEU-USUARIO/minecraft-server-cobblemon.git
cd minecraft-server-cobblemon

# Iniciar servidor
make build-run

# Verificar se está funcionando
make status
```

## Para os Jogadores (Seus Amigos)

### 1. Baixar TLauncher
- Download: https://tlauncher.org/

### 2. Configurar Minecraft
- Versão: **1.20.1-forge-47.3.0**
- Aguardar download do Forge

### 3. Baixar Mods (OBRIGATÓRIO)
**Baixe EXATAMENTE estes arquivos:**

1. **Cobblemon**: [Download](https://cdn.modrinth.com/data/MdwFAVRL/versions/vm5zUZAg/Cobblemon-forge-1.5.2%2B1.20.1.jar)
2. **Kotlin for Forge**: [Download](https://cdn.modrinth.com/data/ordsPcFz/versions/hmeyC41q/kotlinforforge-4.11.0-all.jar)

### 4. Instalar Mods
- No TLauncher: **Mods** → Copiar os 2 arquivos `.jar`
- Ou abrir pasta `mods` manualmente

### 5. Conectar ao Servidor
- **Multiplayer** → **Add Server**
- **Nome**: `Cobblemon Server`
- **IP**: `seu-servidor.exemplo.com:25566`

---

## Problemas Comuns

**"Incompatible mod set"**: Versões dos mods diferentes
**"Connection refused"**: Servidor offline ou porta errada
**"Failed to connect"**: Verificar se os mods estão instalados

## Suporte
- Leia o README.md completo
- Verifique se o servidor está online: `seu-servidor.exemplo.com:25566` 