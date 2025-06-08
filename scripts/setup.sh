#!/bin/bash

echo "=== Setup do Servidor Minecraft Cobblemon ==="
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

# Verificar se Docker está instalado
print_step "Verificando dependências..."
if ! command -v docker &> /dev/null; then
    print_error "Docker não está instalado!"
    echo "Instale o Docker primeiro: https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose não está instalado!"
    echo "Instale o Docker Compose primeiro: https://docs.docker.com/compose/install/"
    exit 1
fi

print_status "Docker e Docker Compose encontrados!"

# Criar diretórios necessários
print_step "Criando estrutura de diretórios..."
mkdir -p world config logs crash-reports mods data/backups

# Copiar arquivos de configuração se não existirem
print_step "Configurando arquivos iniciais..."

if [ ! -f "configs/server.properties" ]; then
    if [ -f "configs/server.properties.example" ]; then
        cp configs/server.properties.example configs/server.properties
        print_status "configs/server.properties criado a partir do exemplo"
    else
        print_warning "Arquivo server.properties.example não encontrado"
    fi
else
    print_status "configs/server.properties já existe"
fi

if [ ! -f "docs/network-setup.md" ]; then
    if [ -f "docs/network-setup.example.md" ]; then
        cp docs/network-setup.example.md docs/network-setup.md
        print_status "network-setup.md criado a partir do exemplo"
        print_warning "Edite docs/network-setup.md com suas configurações de rede"
    fi
else
    print_status "network-setup.md já existe"
fi

# Garantir que EULA está aceito
print_step "Configurando EULA..."
echo "eula=true" > configs/eula.txt
print_status "EULA aceito automaticamente"

# Verificar se há mods na pasta
print_step "Verificando mods..."
if [ "$(ls -A mods/ 2>/dev/null)" ]; then
    print_status "Mods encontrados na pasta mods/"
else
    print_warning "Pasta mods/ está vazia"
    print_warning "Os mods serão baixados automaticamente durante o build do Docker"
fi

# Construir imagem Docker
print_step "Construindo imagem Docker..."
cd docker
if docker-compose build --no-cache; then
    print_status "Imagem Docker construída com sucesso!"
else
    print_error "Falha ao construir imagem Docker"
    exit 1
fi
cd ..

echo ""
echo -e "${GREEN}=== Setup Concluído! ===${NC}"
echo ""
echo "Próximos passos:"
echo "1. Edite configs/server.properties se necessário"
echo "2. Configure docs/network-setup.md para acesso externo"
echo "3. Execute: make start"
echo ""
echo "Comandos úteis:"
echo "  make start    - Iniciar servidor"
echo "  make logs     - Ver logs"
echo "  make stop     - Parar servidor"
echo "  make help     - Ver todos os comandos"
echo ""
print_status "Servidor pronto para uso!" 