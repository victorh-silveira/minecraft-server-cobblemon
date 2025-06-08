.PHONY: help build start stop restart logs shell clean backup restore status network-test

# Variáveis
CONTAINER_NAME = minecraft-cobblemon-server
BACKUP_DIR = data/backups
TIMESTAMP = $(shell date +%Y%m%d_%H%M%S)
DDNS_HOST = seu-servidor.ddns.net
SERVER_PORT = 25565

# Comando padrão
help: ## Mostra esta mensagem de ajuda
	@echo "=== Servidor Minecraft Cobblemon ==="
	@echo "Comandos disponíveis:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Constrói a imagem Docker
	@echo "Construindo imagem Docker..."
	cd docker && docker-compose build --no-cache

build-run: ## Constrói a imagem e inicia o servidor
	@echo "Construindo imagem Docker (build limpo)..."
	cd docker && docker-compose build --no-cache --pull
	@echo "Iniciando servidor Minecraft Cobblemon..."
	cd docker && docker-compose up -d
	@echo "Servidor buildado e iniciado! Acesse em localhost:25565"
	@echo "Amigos podem acessar em: $(DDNS_HOST):$(SERVER_PORT)"

start: ## Inicia o servidor
	@echo "Iniciando servidor Minecraft Cobblemon..."
	cd docker && docker-compose up -d
	@echo "Servidor iniciado! Acesse em localhost:25565"
	@echo "Amigos podem acessar em: $(DDNS_HOST):$(SERVER_PORT)"

stop: ## Para o servidor
	@echo "Parando servidor..."
	cd docker && docker-compose down
	@echo "Servidor parado!"

restart: stop start ## Reinicia o servidor

logs: ## Mostra os logs do servidor
	@echo "Logs do servidor:"
	cd docker && docker-compose logs -f

shell: ## Acessa o shell do container
	@echo "Acessando shell do container..."
	docker exec -it $(CONTAINER_NAME) /bin/bash

status: ## Mostra o status do servidor
	@echo "Status do servidor:"
	cd docker && docker-compose ps

clean: ## Remove containers e imagens
	@echo "Limpando containers e imagens..."
	cd docker && docker-compose down --rmi all --volumes --remove-orphans
	@echo "Limpeza concluída!"

backup: ## Cria backup do mundo
	@echo "Criando backup do mundo..."
	@mkdir -p $(BACKUP_DIR)
	@if [ -d "world" ]; then \
		tar -czf $(BACKUP_DIR)/world_backup_$(TIMESTAMP).tar.gz world/; \
		echo "Backup criado: $(BACKUP_DIR)/world_backup_$(TIMESTAMP).tar.gz"; \
	else \
		echo "Diretório 'world' não encontrado!"; \
	fi

restore: ## Restaura backup do mundo (uso: make restore BACKUP=nome_do_arquivo)
	@if [ -z "$(BACKUP)" ]; then \
		echo "Especifique o arquivo de backup: make restore BACKUP=world_backup_YYYYMMDD_HHMMSS.tar.gz"; \
		exit 1; \
	fi
	@if [ -f "$(BACKUP_DIR)/$(BACKUP)" ]; then \
		echo "Restaurando backup $(BACKUP)..."; \
		rm -rf world/; \
		tar -xzf $(BACKUP_DIR)/$(BACKUP); \
		echo "Backup restaurado!"; \
	else \
		echo "Arquivo de backup não encontrado: $(BACKUP_DIR)/$(BACKUP)"; \
	fi

setup: ## Configuração inicial (primeira execução)
	@echo "Executando script de setup..."
	@chmod +x scripts/setup.sh
	@./scripts/setup.sh

update: ## Atualiza e reinicia o servidor
	@echo "Atualizando servidor..."
	@make stop
	@make build
	@make start
	@echo "Servidor atualizado!"

console: ## Acessa o console do Minecraft
	@echo "Acessando console do Minecraft..."
	docker attach $(CONTAINER_NAME)

network-test: ## Testa conectividade de rede
	@echo "Testando conectividade de rede..."
	@echo "Testando resolução DNS do DDNS:"
	@nslookup $(DDNS_HOST) || echo "Erro na resolução DNS"
	@echo ""
	@echo "Testando ping para DDNS:"
	@ping -c 4 $(DDNS_HOST) || echo "Erro no ping"
	@echo ""
	@echo "Verificando se o servidor está rodando localmente:"
	@cd docker && docker-compose ps | grep $(CONTAINER_NAME) || echo "Container não está rodando"
	@echo ""
	@echo "Para testar porta externamente, acesse:"
	@echo "   https://www.yougetsignal.com/tools/open-ports/"
	@echo "   Host: $(DDNS_HOST) | Porta: $(SERVER_PORT)"

firewall-setup: ## Configura firewall do Windows (executar como admin)
	@echo "Configurando firewall do Windows..."
	@echo "Execute este comando como Administrador!"
	@echo "Comando: netsh advfirewall firewall add rule name=\"Minecraft Server\" dir=in action=allow protocol=TCP localport=$(SERVER_PORT)" 