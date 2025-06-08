FROM openjdk:17-jdk-slim

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Criar diretório do servidor
WORKDIR /minecraft

# Definir variáveis de ambiente
ENV MINECRAFT_VERSION=1.20.1
ENV FORGE_VERSION=47.3.0
ENV COBBLEMON_VERSION=1.5.2
ENV JAVA_MEMORY=6G

# Baixar Forge Installer
RUN wget -O forge-installer.jar "https://maven.minecraftforge.net/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar"

# Instalar Forge
RUN java -jar forge-installer.jar --installServer && \
    rm forge-installer.jar

# Criar diretório de mods
RUN mkdir -p mods

# Baixar Cobblemon e dependências com verificação
RUN curl -L --fail --retry 3 --retry-delay 5 -o mods/cobblemon.jar "https://cdn.modrinth.com/data/MdwFAVRL/versions/vm5zUZAg/Cobblemon-forge-1.5.2%2B1.20.1.jar" && \
    echo "Cobblemon baixado: $(ls -lh mods/cobblemon.jar)"

RUN curl -L --fail --retry 3 --retry-delay 5 -o mods/kotlin-for-forge.jar "https://cdn.modrinth.com/data/ordsPcFz/versions/hmeyC41q/kotlinforforge-4.11.0-all.jar" && \
    echo "Kotlin for Forge baixado: $(ls -lh mods/kotlin-for-forge.jar)"

# Verificar se os mods foram baixados corretamente
RUN ls -la mods/ && \
    echo "Verificando integridade dos mods..." && \
    test -f mods/cobblemon.jar && echo "✓ Cobblemon OK" || (echo "✗ Cobblemon FALHOU" && exit 1) && \
    test -f mods/kotlin-for-forge.jar && echo "✓ Kotlin for Forge OK" || (echo "✗ Kotlin for Forge FALHOU" && exit 1)

# Criar estrutura de diretórios
RUN mkdir -p world config logs crash-reports

# Copiar arquivos de configuração
COPY configs/server.properties* ./
COPY configs/eula.txt .

# Usar server.properties se existir, senão usar o exemplo
RUN if [ ! -f server.properties ]; then cp server.properties.example server.properties; fi

# Garantir que o EULA está aceito
RUN echo "eula=true" > eula.txt

# Expor porta do servidor
EXPOSE 25565

# Script de inicialização
COPY scripts/start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"] 