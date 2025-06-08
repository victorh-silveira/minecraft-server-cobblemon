#!/bin/bash

echo "Iniciando Servidor Minecraft Cobblemon..."
echo "Configurações:"
echo "   - Minecraft: ${MINECRAFT_VERSION}"
echo "   - Forge: ${FORGE_VERSION}"
echo "   - Cobblemon: ${COBBLEMON_VERSION}"
echo "   - Memória: ${JAVA_MEMORY}"
echo "   - Mundo: GLS-Pokemon"
echo ""

# Aguardar um pouco para garantir que tudo está pronto
sleep 2

# Garantir que o EULA está aceito
echo "eula=true" > eula.txt

# Parâmetros otimizados da JVM para servidor Minecraft
JVM_ARGS="-Xms${JAVA_MEMORY} -Xmx${JAVA_MEMORY} \
-XX:+UseG1GC \
-XX:+ParallelRefProcEnabled \
-XX:MaxGCPauseMillis=200 \
-XX:+UnlockExperimentalVMOptions \
-XX:+DisableExplicitGC \
-XX:+AlwaysPreTouch \
-XX:G1NewSizePercent=30 \
-XX:G1MaxNewSizePercent=40 \
-XX:G1HeapRegionSize=8M \
-XX:G1ReservePercent=20 \
-XX:G1HeapWastePercent=5 \
-XX:G1MixedGCCountTarget=4 \
-XX:InitiatingHeapOccupancyPercent=15 \
-XX:G1MixedGCLiveThresholdPercent=90 \
-XX:G1RSetUpdatingPauseTimePercent=5 \
-XX:SurvivorRatio=32 \
-XX:+PerfDisableSharedMem \
-XX:MaxTenuringThreshold=1 \
-Dusing.aikars.flags=https://mcflags.emc.gs \
-Daikars.new.flags=true"

# Encontrar o arquivo JAR do servidor Forge
# Após a instalação, o Forge cria um arquivo run.sh ou o JAR correto tem nome específico
if [ -f "run.sh" ]; then
    echo "Usando script run.sh do Forge"
    chmod +x run.sh
    exec ./run.sh
elif [ -f "minecraft_server.${MINECRAFT_VERSION}.jar" ]; then
    SERVER_JAR="minecraft_server.${MINECRAFT_VERSION}.jar"
elif [ -f "server.jar" ]; then
    SERVER_JAR="server.jar"
else
    # Procurar por qualquer JAR que não seja installer, universal ou launcher
    SERVER_JAR=$(find . -maxdepth 1 -name "*.jar" -not -name "*installer*" -not -name "*universal*" -not -name "*launcher*" | head -1)
fi

if [ -z "$SERVER_JAR" ]; then
    echo "Arquivo do servidor não encontrado!"
    echo "Arquivos JAR disponíveis:"
    find . -name "*.jar" -type f
    exit 1
fi

echo "Iniciando servidor com: $SERVER_JAR"
echo "Parâmetros JVM otimizados aplicados"
echo ""

# Iniciar o servidor
exec java $JVM_ARGS -jar "$SERVER_JAR" nogui 