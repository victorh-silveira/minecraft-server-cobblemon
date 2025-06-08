# Configuração de Rede - Servidor Cobblemon

## Suas Configurações (EXEMPLO)

- **IP Interno**: 192.168.1.100 (substitua pelo seu IP interno)
- **Porta**: 25565
- **DDNS**: seu-servidor.exemplo.com (substitua pelo seu domínio)
- **Acesso Externo**: seu-servidor.exemplo.com:25565

## Configuração do Roteador

### 1. Port Forwarding (Redirecionamento de Porta)
Configure no seu roteador:

```
Serviço: Minecraft Server
Porta Externa: 25565
Porta Interna: 25565
IP Interno: [SEU_IP_INTERNO] (ex: 192.168.1.100)
Protocolo: TCP
Status: Habilitado
```

### 2. Verificar Firewall
- Certifique-se que a porta 25565 está liberada no firewall do Windows
- Comando para liberar no Windows:
```cmd
netsh advfirewall firewall add rule name="Minecraft Server" dir=in action=allow protocol=TCP localport=25565
```

## Como Conectar

### Para você (rede local):
```
localhost:25565
ou
[SEU_IP_INTERNO]:25565
```

### Para seus amigos (internet):
```
[SEU_DOMINIO]:25565
```

## Teste de Conectividade

### 1. Teste Local
```bash
# Iniciar servidor
make start

# Verificar se está rodando
make status

# Testar conexão local
telnet localhost 25565
```

### 2. Teste Externo
Use um dos sites para testar se a porta está aberta:
- https://www.yougetsignal.com/tools/open-ports/
- https://portchecker.co/
- Digite: `[SEU_DOMINIO]` e porta `25565`

### 3. Verificar DDNS
```bash
# Verificar se o DDNS está apontando corretamente
nslookup [SEU_DOMINIO]
```

## Solução de Problemas

### Problema: Amigos não conseguem conectar

**1. Verificar Port Forwarding:**
- Acesse o painel do roteador
- Confirme que a regra está ativa
- Teste com outro dispositivo na rede local

**2. Verificar IP Interno:**
```bash
# Confirmar seu IP interno atual
ipconfig
```

**3. Verificar se o servidor está rodando:**
```bash
make logs
```

**4. Testar porta externamente:**
- Use os sites de teste de porta mencionados acima

### Problema: DDNS não resolve

**1. Verificar configuração do DDNS:**
- Confirme que o serviço está ativo
- Verifique se está atualizando o IP público

**2. Testar resolução:**
```bash
nslookup [SEU_DOMINIO]
ping [SEU_DOMINIO]
```

### Problema: Conexão lenta ou instável

**1. Otimizar configurações de rede:**
- Edite `server.properties`:
```properties
network-compression-threshold=256
max-tick-time=60000
```

**2. Verificar largura de banda:**
- Upload mínimo recomendado: 1 Mbps por jogador
- Para 5 jogadores: ~5 Mbps de upload

## Monitoramento

### Verificar conexões ativas:
```bash
# Ver logs em tempo real
make logs

# Acessar console do servidor
make console
```

### Comandos úteis no console do Minecraft:
```
/list                    # Ver jogadores online
/whitelist add jogador   # Adicionar à whitelist
/op jogador             # Dar OP a um jogador
/save-all               # Salvar mundo
```

## Segurança

### Recomendações:
1. **Ativar whitelist** quando necessário:
   ```properties
   white-list=true
   ```

2. **Backup regular**:
   ```bash
   make backup
   ```

3. **Monitorar logs**:
   ```bash
   make logs
   ```

4. **Limitar jogadores**:
   ```properties
   max-players=10
   ```

## Checklist de Configuração

- [ ] Port forwarding configurado (25565 → [SEU_IP_INTERNO]:25565)
- [ ] Firewall liberado na porta 25565
- [ ] DDNS funcionando ([SEU_DOMINIO] resolve para seu IP público)
- [ ] Servidor iniciado (`make start`)
- [ ] Teste local funcionando (localhost:25565)
- [ ] Teste externo funcionando (site de teste de porta)
- [ ] Amigos conseguem conectar ([SEU_DOMINIO]:25565)

---

**Endereço para compartilhar com amigos: `[SEU_DOMINIO]:25565`**

## Como Configurar

1. **Copie este arquivo para `network-setup.md`**
2. **Substitua os placeholders:**
   - `[SEU_IP_INTERNO]` → seu IP interno real (ex: 192.168.1.100)
   - `[SEU_DOMINIO]` → seu domínio DDNS real (ex: meuservidor.ddns.net)
   - `[SEU_DOMINIO]:25565` → seu endereço completo
3. **Configure seu roteador** com as informações corretas
4. **Teste a conectividade** seguindo os passos acima 