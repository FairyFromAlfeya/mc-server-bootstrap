#!/bin/bash

# ---------------- Server settings ---------------

# M means Megabyte, G means Gigabyte
MINIMUM_RAM_USAGE="2500M"
MAXIMUM_RAM_USAGE="4G"

# Whether or not the user must be logged in to the Mojang account
ONLINE_MODE=false
SERVER_DESCRIPTION="Bootstrapped Forge 1.19.4 server"
RESOURCE_PACK="https://database.faithfulpack.net/packs/32x-Java/May%202023/Faithful%2032x%20-%201.19.4.zip"
RESOURCE_PACK_CHECKSUM="2ee4dc41e7ed154d036710ec7c42acdec179215e"

# -------------- Files download URLs -------------

FORGE_INSTALLER_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.4-45.1.0/forge-1.19.4-45.1.0-installer.jar"

JAVA_SE_MAC_OS_URL="https://download.oracle.com/java/17/archive/jdk-17.0.6_macos-aarch64_bin.tar.gz"
JAVA_SE_LINUX_URL="https://download.oracle.com/java/17/archive/jdk-17.0.6_linux-x64_bin.tar.gz"
JAVA_SE_WINDOWS_URL="https://download.oracle.com/java/17/archive/jdk-17.0.6_windows-x64_bin.zip"

JAVA_PATH_MAC_OS=$PWD/java/Contents/Home
JAVA_PATH_LINUX=$PWD/java
JAVA_PATH_WINDOWS=$PWD/java

# Default mods set
MODS=(
  # https://www.curseforge.com/minecraft/mc-mods/jei
  "https://mediafilez.forgecdn.net/files/4592/504/jei-1.19.4-forge-13.1.0.15.jar"

  # https://www.curseforge.com/minecraft/mc-mods/journeymap
  "https://mediafilez.forgecdn.net/files/4532/920/journeymap-1.19.4-5.9.7-forge.jar"

  # https://www.curseforge.com/minecraft/mc-mods/appleskin
  "https://mediafilez.forgecdn.net/files/4440/123/appleskin-forge-mc1.19.4-2.4.3.jar"

  # https://www.curseforge.com/minecraft/mc-mods/just-enough-resources-jer
  "https://mediafilez.forgecdn.net/files/4543/906/JustEnoughResources-1.19.4-1.3.3.219.jar"

  # https://www.curseforge.com/minecraft/mc-mods/the-one-probe
  "https://mediafilez.forgecdn.net/files/4442/439/theoneprobe-1.19.4-8.0.0.jar"

  # https://www.curseforge.com/minecraft/mc-mods/spark
  "https://mediafilez.forgecdn.net/files/4505/309/spark-1.10.37-forge.jar"

  # https://www.curseforge.com/minecraft/mc-mods/simple-backups
  "https://mediafilez.forgecdn.net/files/4640/130/SimpleBackups-1.19.4-2.2.4.jar"

  # https://www.curseforge.com/minecraft/mc-mods/simple-login
  "https://raw.githubusercontent.com/FairyFromAlfeya/mc-simple-login/mc-1.19/release/SimpleLogin-1.19.4-1.0.2-all.jar"
)

# ------------- Emojis octet streams -------------

COFFEE_EMOJI="\342\230\225"
ARCHIVE_EMOJI="\360\237\227\203"
HAMMER_EMOJI="\360\237\224\250"
OFFICE_EMOJI="\360\237\217\242"
CLEARING_EMOJI="\360\237\247\271"
GEAR_EMOJI="\342\232\231"
DONE_EMOJI="\342\234\205"

# -------------- JDK SE installation -------------

mkdir -p ./temp

if [[ "$OSTYPE" = "darwin"* ]]
then
  JAVA_SE_URL=$JAVA_SE_MAC_OS_URL
  export JAVA_HOME=$JAVA_PATH_MAC_OS
elif [[ "$OSTYPE" = "linux-gnu"* ]]
then
  JAVA_SE_URL=$JAVA_SE_LINUX_URL
  export JAVA_HOME=$JAVA_PATH_LINUX
elif [[ "$OSTYPE" = "msys" ]]
then
  JAVA_SE_URL=$JAVA_SE_WINDOWS_URL
  export JAVA_HOME=$JAVA_PATH_WINDOWS
else
  echo "System type $OSTYPE is not supported. Aborting..."
  exit
fi

PATH=$JAVA_HOME/bin:$PATH

if [ ! -d "./java" ]
then
  if [[ "$OSTYPE" = "msys" ]]
  then
    printf "%b Downloading JDK SE...\n" "${COFFEE_EMOJI}"
    curl --silent --output ./temp/jdk-se.zip $JAVA_SE_URL

    printf "%b Unpacking JDK SE...\n" "${ARCHIVE_EMOJI}"
    unzip -q ./temp/jdk-se.zip
  else
    printf "%b Downloading JDK SE...\n" "${COFFEE_EMOJI}"
    curl --silent --output ./temp/jdk-se.tar.gz $JAVA_SE_URL

    printf "%b Unpacking JDK SE...\n" "${ARCHIVE_EMOJI}"
    tar -xf ./temp/jdk-se.tar.gz
  fi

  OLD_JAVA_DIR=$(find . -type d -name 'jdk*' -print -quit)
  mv "${OLD_JAVA_DIR[0]}" java
else
  printf "%b JDK SE already exists\n" "${DONE_EMOJI}"
fi

echo
java -version
echo

# -------------- Creating Forge server -------------

if [ ! -d "./server" ]
then
  printf "%b Downloading Forge installer...\n" "${HAMMER_EMOJI}"
  curl --silent --output ./temp/forge-installer.jar $FORGE_INSTALLER_URL

  printf "%b Creating server...\n" "${OFFICE_EMOJI}"
  java -jar ./temp/forge-installer.jar --installServer ./server > installer.log

  touch ./server/server.properties

  # IMPORTANT: By changing the setting below to TRUE script's user are indicating his agreement to Mojang AB EULA.
  # https://aka.ms/MinecraftEULA
  printf "eula=true\n" > ./server/eula.txt
  printf -- "-Xms%s -Xmx%s\n" "$MINIMUM_RAM_USAGE" "$MAXIMUM_RAM_USAGE" > ./server/user_jvm_args.txt
  printf -- "online-mode=%s\n" "$ONLINE_MODE" >> ./server/server.properties
  printf -- "motd=%s\n" "$SERVER_DESCRIPTION" >> ./server/server.properties

  if [ -n "$RESOURCE_PACK" ]
  then
    printf -- "resource-pack=%s\n" "$RESOURCE_PACK" >> ./server/server.properties
    printf -- "resource-pack-sha1=%s\n" "$RESOURCE_PACK_CHECKSUM" >> ./server/server.properties
  fi

  [ -f ./server-icon.png ] && mv server-icon.png ./server/server-icon.png
else
  printf "%b Server already exists\n" "${DONE_EMOJI}"
fi

# -------------- Clearing temp files -------------

printf "%b Clearing temp files...\n" "${CLEARING_EMOJI}"
rm -r ./temp
[ -f ./forge-installer.jar.log ] && rm forge-installer.jar.log

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
