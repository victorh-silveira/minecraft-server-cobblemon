#!/bin/bash

echo "=== Restaurando Configurações Locais ==="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir com cor
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[PASSO]${NC} $1"
}

# Verificar se existe backup local
if [ -d ".local-backup" ]; then
    print_step "Restaurando configurações do backup local..."
    
    if [ -f ".local-backup/server.properties" ]; then
        cp .local-backup/server.properties configs/
        print_status "server.properties restaurado"
    fi
    
    if [ -f ".local-backup/network-setup.md" ]; then
        cp .local-backup/network-setup.md docs/
        print_status "network-setup.md restaurado"
    fi
    
    if [ -f ".local-backup/Makefile" ]; then
        cp .local-backup/Makefile .
        print_status "Makefile restaurado"
    fi
    
    print_status "Configurações locais restauradas!"
else
    print_warning "Backup local não encontrado"
    print_step "Configurando arquivos pela primeira vez..."
    
    # Configurar server.properties
    if [ ! -f "configs/server.properties" ]; then
        print_warning "Configure configs/server.properties com suas informações específicas"
        print_warning "Use configs/server.properties.example como referência"
    fi
    
    # Configurar network-setup.md
    if [ ! -f "docs/network-setup.md" ]; then
        print_warning "Configure docs/network-setup.md com suas informações de rede"
        print_warning "Use docs/network-setup.example.md como referência"
    fi
    
    # Configurar Makefile
    print_warning "Configure a variável DDNS_HOST no Makefile com seu domínio"
    
    echo ""
    print_step "Próximos passos:"
    echo "1. Edite configs/server.properties (nome do servidor, mundo, etc.)"
    echo "2. Edite docs/network-setup.md (IPs, DDNS, etc.)"
    echo "3. Edite Makefile (variável DDNS_HOST)"
    echo "4. Execute: make setup"
fi

echo ""
print_status "Script concluído!" 