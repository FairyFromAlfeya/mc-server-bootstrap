#!/bin/bash

# -------------- Files download URLs -------------

FORGE_INSTALLER_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.4-45.1.0/forge-1.19.4-45.1.0-installer.jar"

JAVA_SE_MAC_OS_URL="https://download.oracle.com/java/17/archive/jdk-17.0.8_macos-aarch64_bin.tar.gz"
JAVA_SE_LINUX_URL="https://download.oracle.com/java/17/archive/jdk-17.0.8_linux-x64_bin.tar.gz"

JAVA_PATH_MAC_OS=$PWD/java/Contents/Home
JAVA_PATH_LINUX=$PWD/java

MODS=(
  # Default
  "https://mediafilez.forgecdn.net/files/4442/439/theoneprobe-1.19.4-8.0.0.jar"
  "https://mediafilez.forgecdn.net/files/4532/920/journeymap-1.19.4-5.9.7-forge.jar"
  "https://mediafilez.forgecdn.net/files/4640/130/SimpleBackups-1.19.4-2.2.4.jar"
)

# ------------- Emojis octet streams -------------

COFFEE_EMOJI="\342\230\225"
ARCHIVE_EMOJI="\360\237\227\203"
HAMMER_EMOJI="\360\237\224\250"
OFFICE_EMOJI="\360\237\217\242"
CLEARING_EMOJI="\360\237\247\271"
GEAR_EMOJI="\342\232\231"

# -------------- JDK SE installation -------------

if [ "$(arch)" = "arm64" ]
then
  JAVA_SE_URL=$JAVA_SE_MAC_OS_URL
  export JAVA_HOME=$JAVA_PATH_MAC_OS
elif [ "$(arch)" = "x86_64" ]
then
  JAVA_SE_URL=$JAVA_SE_LINUX_URL
  export JAVA_HOME=$JAVA_PATH_LINUX
else
  echo "System architecture $(arch) is not supported. Aborting..."
  exit
fi

PATH=$JAVA_HOME/bin:$PATH

mkdir -p ./temp

printf "%b Downloading JDK SE...\n" "${COFFEE_EMOJI}"
curl --silent --output ./temp/jdk-se.tar.gz $JAVA_SE_URL

printf "%b Unpacking JDK SE...\n" "${ARCHIVE_EMOJI}"
tar -xf ./temp/jdk-se.tar.gz

OLD_JAVA_DIR=$(find . -type d -name 'jdk*' -print -quit)
mv "${OLD_JAVA_DIR[0]}" java

echo
java -version
echo

# -------------- Creating Forge server -------------

printf "%b Downloading Forge installer...\n" "${HAMMER_EMOJI}"
curl --silent --output ./temp/forge-installer.jar $FORGE_INSTALLER_URL

printf "%b Creating server...\n" "${OFFICE_EMOJI}"
java -jar ./temp/forge-installer.jar --installServer ./server > installer.log

# IMPORTANT: By changing the setting below to TRUE script's user are indicating his agreement to Mojang AB EULA.
# https://aka.ms/MinecraftEULA
printf "eula=true\n" > ./server/eula.txt
[ -f ./server-icon.png ] && mv server-icon.png ./server/server-icon.png

# -------------- Clearing temp files -------------

printf "%b Clearing temp files...\n" "${CLEARING_EMOJI}"
rm -r ./temp
rm forge-installer.jar.log

# --------------- Mods installation -------------

printf "%b Setup mods...\n" "${GEAR_EMOJI}"
mkdir -p ./server/mods
cd ./server/mods || exit

for mod in "${MODS[@]}"
do
  echo "$mod"
  curl --silent -O "$mod"
done

echo "Server is installed. You can remove this script"
