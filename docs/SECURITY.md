# Segurança e Configuração

## Importante - Antes de Usar

Este projeto foi configurado para ser **seguro para repositórios públicos**. Todas as informações sensíveis foram removidas e substituídas por exemplos genéricos.

## Configuração Inicial Obrigatória

Antes de usar o servidor, você **DEVE** configurar os seguintes arquivos:

### 1. Configuração de Rede
```bash
cp network-setup.example.md network-setup.md
```
Edite `network-setup.md` e substitua:
- `[SEU_IP_INTERNO]` → seu IP interno real (ex: 192.168.1.100)
- `[SEU_DOMINIO]` → seu domínio DDNS real (ex: meuservidor.ddns.net)

### 2. Configuração do Servidor
```bash
cp server.properties.example server.properties
```
Edite `server.properties` conforme necessário:
- `level-name` → nome do seu mundo
- `motd` → mensagem do seu servidor
- `max-players` → limite de jogadores

## Arquivos Ignorados pelo Git

Os seguintes arquivos são automaticamente ignorados pelo Git para proteger suas informações:

- `network-setup.md` - Suas configurações de rede
- `server.properties` - Suas configurações do servidor
- `world/` - Mundo do servidor
- `logs/` - Logs do servidor
- `.env` - Variáveis de ambiente

## Recomendações de Segurança

### Para Uso Pessoal:
1. **Nunca commite** arquivos com suas informações reais
2. **Use whitelist** quando necessário:
   ```properties
   white-list=true
   ```
3. **Faça backups regulares**:
   ```bash
   make backup
   ```

### Para Compartilhar o Projeto:
1. **Sempre use os arquivos .example**
2. **Verifique se não há informações pessoais** antes de fazer push
3. **Documente mudanças** que outros precisam fazer

## Checklist Antes de Fazer Push

- [ ] Arquivos sensíveis estão no `.gitignore`
- [ ] Apenas arquivos `.example` estão sendo commitados
- [ ] Não há IPs, domínios ou nomes pessoais no código
- [ ] Documentação está atualizada

## Se Você Commitou Informações Sensíveis

Se acidentalmente commitou informações pessoais:

1. **Remova do histórico**:
   ```bash
   git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch arquivo-sensivel' --prune-empty --tag-name-filter cat -- --all
   ```

2. **Force push** (cuidado!):
   ```bash
   git push origin --force --all
   ```

3. **Considere trocar** informações expostas (senhas, tokens, etc.)

## Atualizando o Projeto

Quando atualizar o projeto:

1. **Mantenha seus arquivos locais**:
   ```bash
   git stash push network-setup.md server.properties
   git pull
   git stash pop
   ```

2. **Compare com os novos exemplos** se necessário

---

**Lembre-se**: Segurança é responsabilidade de todos! 