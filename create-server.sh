#!/bin/bash

# ---------------- Server settings ---------------

# Whether or not the user must be logged in to the Mojang account
ONLINE_MODE=false
SERVER_DESCRIPTION="Bootstrapped Forge 1.12.2 server"
RESOURCE_PACK="https://mediafilez.forgecdn.net/files/2929/732/Faithful32_MC1.12.2_v1.0.6.zip"
RESOURCE_PACK_CHECKSUM="23fa2caf76aba4e18f60b7096c99d51d59047013"

# -------------- Files download URLs -------------

FORGE_INSTALLER_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2859/forge-1.12.2-14.23.5.2859-installer.jar"

JAVA_SE_MAC_OS_URL="https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247940_0ae14417abb444ebb02b9815e2103550"
JAVA_SE_LINUX_URL="https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247938_0ae14417abb444ebb02b9815e2103550"
JAVA_SE_WINDOWS_URL="https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247948_0ae14417abb444ebb02b9815e2103550"

JAVA_PATH_MAC_OS=$PWD/java/Contents/Home
JAVA_PATH_LINUX=$PWD/java
JAVA_PATH_WINDOWS=$PWD/java

MODS=(
  "https://mediafilez.forgecdn.net/files/2949/817/SmoothFont-mc1.12.2-2.1.2.jar"
  "https://mediafilez.forgecdn.net/files/2858/569/plethora-1.12.2-1.2.3.jar"
  "https://mediafilez.forgecdn.net/files/2834/651/StevesCarts-1.12.2-2.4.32.137.jar"
  "https://mediafilez.forgecdn.net/files/2854/990/SimpleCorn1.12-2.5.12.jar"
  "https://mediafilez.forgecdn.net/files/2783/832/JustEnoughEnergistics-1.12.2-1.0.8.jar"
  "https://mediafilez.forgecdn.net/files/2595/728/longfallboots-1.2.1b.jar"
  "https://mediafilez.forgecdn.net/files/2855/61/MagicBees-1.12.2-3.2.25.jar"
  "https://mediafilez.forgecdn.net/files/2785/465/Forgelin-1.8.4.jar"
  "https://mediafilez.forgecdn.net/files/2664/449/Morpheus-1.12.2-3.5.106.jar"
  "https://mediafilez.forgecdn.net/files/2891/841/tesla-core-lib-1.12.2-1.0.17.jar"
  "https://mediafilez.forgecdn.net/files/2966/845/RebornCore-1.12.2-3.19.4.529-universal.jar"
  "https://mediafilez.forgecdn.net/files/2745/657/moreoverlays-1.15.1-mc1.12.2.jar"
  "https://mediafilez.forgecdn.net/files/2819/161/YABBA-1.1.2.54.jar"
  "https://mediafilez.forgecdn.net/files/2745/547/ProjectRed-1.12.2-4.9.4.120-fabrication.jar"
  "https://mediafilez.forgecdn.net/files/2735/197/MrTJPCore-1.12.2-2.1.4.43-universal.jar"
  "https://mediafilez.forgecdn.net/files/2926/428/ThermalFoundation-1.12.2-2.6.7.1-universal.jar"
  "https://mediafilez.forgecdn.net/files/2920/433/CoFHCore-1.12.2-4.6.6.1-universal.jar"
  "https://mediafilez.forgecdn.net/files/2755/787/EnderStorage-1.12.2-2.4.6.137-universal.jar"
  "https://mediafilez.forgecdn.net/files/2926/431/ThermalExpansion-1.12.2-5.5.7.1-universal.jar"
  "https://mediafilez.forgecdn.net/files/2745/548/ProjectRed-1.12.2-4.9.4.120-integration.jar"
  "https://mediafilez.forgecdn.net/files/2745/549/ProjectRed-1.12.2-4.9.4.120-lighting.jar"
  "https://mediafilez.forgecdn.net/files/2745/550/ProjectRed-1.12.2-4.9.4.120-mechanical.jar"
  "https://mediafilez.forgecdn.net/files/2745/551/ProjectRed-1.12.2-4.9.4.120-world.jar"
  "https://mediafilez.forgecdn.net/files/2745/546/ProjectRed-1.12.2-4.9.4.120-compat.jar"
  "https://mediafilez.forgecdn.net/files/2920/434/CoFHWorld-1.12.2-1.4.0.1-universal.jar"
  "https://mediafilez.forgecdn.net/files/2694/382/Placebo-1.12.2-1.6.0.jar"
  "https://mediafilez.forgecdn.net/files/2667/280/theoneprobe-1.12-1.4.28.jar"
  "https://mediafilez.forgecdn.net/files/2801/262/iChunUtil-1.12.2-7.2.2.jar"
  "https://mediafilez.forgecdn.net/files/2550/450/TheFramework-1.12.2-1.0.1-build-T23.jar"
  "https://mediafilez.forgecdn.net/files/2801/274/GravityGun-1.12.2-7.1.0.jar"
  "https://mediafilez.forgecdn.net/files/2685/984/BetterAdvancements-1.12.2-0.1.0.77.jar"
  "https://mediafilez.forgecdn.net/files/2755/798/WR-CBE-1.12.2-2.3.2.33-universal.jar"
  "https://mediafilez.forgecdn.net/files/2636/186/PeripheralsPlusOne-1.12.2-1.2-build-T71.jar"
  "https://mediafilez.forgecdn.net/files/2761/319/Reliquary-1.12.2-1.3.4.796.jar"
  "https://mediafilez.forgecdn.net/files/2918/418/forestry_1.12.2-5.8.2.422.jar"
  "https://mediafilez.forgecdn.net/files/2920/436/RedstoneFlux-1.12-2.1.1.1-universal.jar"
  "https://mediafilez.forgecdn.net/files/2700/845/Gravitation%20Suite-3.1.1.jar"
  "https://mediafilez.forgecdn.net/files/2684/33/PortalGun-1.12.2-7.1.0.jar"
  "https://mediafilez.forgecdn.net/files/2897/811/Harvest-1.12-1.2.8-25.jar"
  "https://mediafilez.forgecdn.net/files/2992/872/cc-tweaked-1.12.2-1.89.2.jar"
  "https://mediafilez.forgecdn.net/files/2559/89/ThaumicInventoryScanning_1.12.2-2.0.10.jar"
  "https://mediafilez.forgecdn.net/files/2491/32/ae2stuff-0.7.0.4-mc1.12.2.jar"
  "https://mediafilez.forgecdn.net/files/3168/863/GunpowderLib-1.12.2-1.1.jar"
  "https://mediafilez.forgecdn.net/files/2668/704/letsencryptcraft-1.10.2-1.2.0.jar"
  "https://mediafilez.forgecdn.net/files/2916/129/binnie-mods-1.12.2-2.5.1.203.jar"
  "https://mediafilez.forgecdn.net/files/2966/851/TechReborn-1.12.2-2.27.3.1084-universal.jar"
  "https://mediafilez.forgecdn.net/files/2920/505/ThermalDynamics-1.12.2-2.5.6.1-universal.jar"
  "https://mediafilez.forgecdn.net/files/2715/827/flatcoloredblocks-mc1.12-6.8.jar"
  "https://mediafilez.forgecdn.net/files/2819/669/FTBBackups-1.1.0.1.jar"
  "https://mediafilez.forgecdn.net/files/2954/953/modular-routers-1.12.2-3.3.0-33.jar"
  "https://mediafilez.forgecdn.net/files/3048/77/Netherending-Ores-1.12.2-1.4.2.jar"
  "https://mediafilez.forgecdn.net/files/2658/176/Morph-o-Tool-1.2-21.jar"
  "https://mediafilez.forgecdn.net/files/2919/497/phosphor-forge-mc1.12.2-0.2.7-universal.jar"
  "https://mediafilez.forgecdn.net/files/2574/880/BiblioCraft%5Bv2.4.5%5D%5BMC1.12.2%5D.jar"
  "https://mediafilez.forgecdn.net/files/2951/731/jeiintegration_1.12.2-1.6.0.jar"
  "https://mediafilez.forgecdn.net/files/3243/257/mysticallib-1.12.2-1.10.0.jar"
  "https://mediafilez.forgecdn.net/files/2741/336/SoulShardsRespawn-1.12.2-1.1.1-13.jar"
  "https://mediafilez.forgecdn.net/files/2915/375/Chisel-MC1.12.2-1.0.2.45.jar"
  "https://mediafilez.forgecdn.net/files/2974/106/ImmersiveEngineering-0.12-98.jar"
  "https://mediafilez.forgecdn.net/files/2915/363/CTM-MC1.12.2-1.0.2.31.jar"
  "https://mediafilez.forgecdn.net/files/2562/139/CraftingTweaks_1.12.2-8.1.9.jar"
  "https://mediafilez.forgecdn.net/files/2857/869/CustomMainMenu-MC1.12.2-2.0.9.1.jar"
  "https://mediafilez.forgecdn.net/files/2992/813/energyconverters_1.12.2-1.3.7.30.jar"
  "https://mediafilez.forgecdn.net/files/2746/11/AutoRegLib-1.3-32.jar"
  "https://mediafilez.forgecdn.net/files/3064/112/WanionLib-1.12.2-2.5.jar"
  "https://mediafilez.forgecdn.net/files/2745/321/industrialforegoing-1.12.2-1.12.13-237.jar"
  "https://mediafilez.forgecdn.net/files/2629/23/Thaumcraft-1.12.2-6.1.BETA26.jar"
  "https://mediafilez.forgecdn.net/files/4658/328/XaerosWorldMap_1.31.0_Forge_1.12.jar"
  "https://mediafilez.forgecdn.net/files/3051/236/torchmaster_1.12.2-1.8.4.84.jar"
  "https://mediafilez.forgecdn.net/files/2745/1/Charset-Crafting-0.5.6.0.jar"
  "https://mediafilez.forgecdn.net/files/2482/481/InventoryTweaks-1.63.jar"
  "https://mediafilez.forgecdn.net/files/3025/548/Controlling-3.0.10.jar"
  "https://mediafilez.forgecdn.net/files/3268/501/UniDict-1.12.2-3.0.8.jar"
  "https://mediafilez.forgecdn.net/files/2581/227/MFFS-1.12.2-4.0.1.0_1.12_cc3a5aa.jar"
  "https://mediafilez.forgecdn.net/files/2477/566/ResourceLoader-MC1.12.1-1.5.3.jar"
  "https://mediafilez.forgecdn.net/files/2705/304/ThaumicJEI-1.12.2-1.6.0-27.jar"
  "https://mediafilez.forgecdn.net/files/2915/506/thaumicenergistics-2.2.4.jar"
  "https://mediafilez.forgecdn.net/files/2680/269/SplashAnimation-0.2.1.jar"
  "https://mediafilez.forgecdn.net/files/2518/31/bdlib-1.14.3.12-mc1.12.2.jar"
  "https://mediafilez.forgecdn.net/files/2745/545/ProjectRed-1.12.2-4.9.4.120-Base.jar"
  "https://mediafilez.forgecdn.net/files/3294/372/CraftTweaker2-1.12-4.1.20.646.jar"
  "https://mediafilez.forgecdn.net/files/2684/561/MTLib-3.0.6.jar"
  "https://mediafilez.forgecdn.net/files/2838/777/FastWorkbench-1.12.2-1.7.3.jar"
  "https://mediafilez.forgecdn.net/files/2739/582/modnametooltip_1.12.2-1.10.1.jar"
  "https://mediafilez.forgecdn.net/files/3078/604/industrialcraft-2-2.8.221-ex112.jar"
  "https://mediafilez.forgecdn.net/files/2887/479/topaddons-1.12.2-1.13.0.jar"
  "https://mediafilez.forgecdn.net/files/2987/247/AppleSkin-mc1.12-1.0.14.jar"
  "https://mediafilez.forgecdn.net/files/2667/335/playerplates-1.12.2-1.3.1.1.jar"
  "https://mediafilez.forgecdn.net/files/3157/548/FTBUtilities-5.4.1.131.jar"
  "https://mediafilez.forgecdn.net/files/2914/62/Aroma1997Core-1.12.2-2.0.0.2.b167.jar"
  "https://mediafilez.forgecdn.net/files/2716/712/blockcraftery-1.12.2-1.3.1.jar"
  "https://mediafilez.forgecdn.net/files/2881/277/modtweaker-4.0.18.jar"
  "https://mediafilez.forgecdn.net/files/2518/667/Baubles-1.12-1.5.2.jar"
  "https://mediafilez.forgecdn.net/files/3043/174/jei_1.12.2-4.16.1.302.jar"
  "https://mediafilez.forgecdn.net/files/2715/198/Numina-1.12.2-1.0.38.jar"
  "https://mediafilez.forgecdn.net/files/2747/935/ironchest-1.12.2-7.0.72.847.jar"
  "https://mediafilez.forgecdn.net/files/2680/516/Retro-Exchange-1.12.2-1.0.7.jar"
  "https://mediafilez.forgecdn.net/files/2692/999/WorldControl-1.0.31.jar"
  "https://mediafilez.forgecdn.net/files/2633/646/CompactSolars-1.12.2-5.0.18.341-universal.jar"
  "https://mediafilez.forgecdn.net/files/3051/450/twilightforest-1.12.2-3.11.1021-universal.jar"
  "https://mediafilez.forgecdn.net/files/2743/885/ModularPowersuits-1.12.2-1.0.46.jar"
  "https://mediafilez.forgecdn.net/files/2652/182/Advanced%20Solar%20Panels-4.3.0.jar"
  "https://mediafilez.forgecdn.net/files/2957/213/thaumictinkerer-1.12.2-5.0-620a0c5.jar"
  "https://mediafilez.forgecdn.net/files/2613/657/Traverse-1.12.2-1.6.0-69.jar"
  "https://mediafilez.forgecdn.net/files/2560/638/reauth-3.6.0.jar"
  "https://mediafilez.forgecdn.net/files/2624/732/DefaultOptions_1.12.2-9.2.8.jar"
  "https://mediafilez.forgecdn.net/files/3162/874/Patchouli-1.0-23.6.jar"
  "https://mediafilez.forgecdn.net/files/3133/651/randompatches-1.12.2-1.22.1.10.jar"
  "https://mediafilez.forgecdn.net/files/2747/63/appliedenergistics2-rv6-stable-7.jar"
  "https://mediafilez.forgecdn.net/files/2985/811/FTBLib-5.4.7.2.jar"
  "https://mediafilez.forgecdn.net/files/2482/543/diethopper-1.1.jar"
  "https://mediafilez.forgecdn.net/files/2645/992/Guide-API-1.12-2.1.8-63.jar"
  "https://mediafilez.forgecdn.net/files/2689/835/TipTheScales-1.12.2-1.0.4.jar"
  "https://mediafilez.forgecdn.net/files/3034/109/advmachinespatch-1.0.jar"
  "https://mediafilez.forgecdn.net/files/2615/930/MCMultiPart-2.5.3.jar"
  "https://mediafilez.forgecdn.net/files/2575/404/Silverfish-1.12.2-0.0.19-universal.jar"
  "https://mediafilez.forgecdn.net/files/2595/13/ImmersiveCables-1.12.2-1.3.2.jar"
  "https://mediafilez.forgecdn.net/files/2707/353/Toast%20Control-1.12.2-1.8.1.jar"
  "https://mediafilez.forgecdn.net/files/3034/74/advsolarpatch-1.1.jar"
  "https://mediafilez.forgecdn.net/files/2723/382/Fancy%20Fluid%20Storage-1.12.2-2.2.5.jar"
  "https://mediafilez.forgecdn.net/files/2683/101/Aroma1997s-Dimensional-World-1.12.2-2.0.0.2.b89.jar"
  "https://mediafilez.forgecdn.net/files/2575/407/ProjectX-1.12.2-2.2.7-universal.jar"
  "https://mediafilez.forgecdn.net/files/2720/655/chiselsandbits-14.33.jar"
  "https://mediafilez.forgecdn.net/files/2490/58/jeibees-0.9.0.5-mc1.12.2.jar"
  "https://mediafilez.forgecdn.net/files/2687/757/railcraft-12.0.0.jar"
  "https://mediafilez.forgecdn.net/files/2779/848/CodeChickenLib-1.12.2-3.2.3.358-universal.jar"
  "https://mediafilez.forgecdn.net/files/2755/790/ForgeMultipart-1.12.2-2.6.2.83-universal.jar"
  "https://mediafilez.forgecdn.net/files/3204/475/buildcraft-all-7.99.24.8.jar"
  "https://mediafilez.forgecdn.net/files/3137/883/foamfix-0.10.11-1.12.2.jar"
  "https://mediafilez.forgecdn.net/files/3066/682/Charset-Lib-0.5.6.5.jar"
  "https://mediafilez.forgecdn.net/files/3200/529/IntegrationForegoing-1.12.2-1.11.jar"
  "https://mediafilez.forgecdn.net/files/2667/2/Advanced%20Machines-61.0.1.jar"
  "https://mediafilez.forgecdn.net/files/2671/937/MouseTweaks-2.10-mc1.12.2.jar"
  "https://mediafilez.forgecdn.net/files/4658/293/Xaeros_Minimap_23.6.0_Forge_1.12.jar"
  "https://mediafilez.forgecdn.net/files/3202/390/Computronics-1.12.2-1.6.6.jar"
  "https://mediafilez.forgecdn.net/files/2996/748/simplelogin-1.2.4-beta%2Bbuild127.jar"
  "https://mediafilez.forgecdn.net/files/3542/217/spark-forge.jar"
)

# ------------- Emojis octet streams -------------

COFFEE_EMOJI="\342\230\225"
ARCHIVE_EMOJI="\360\237\227\203"
HAMMER_EMOJI="\360\237\224\250"
OFFICE_EMOJI="\360\237\217\242"
CLEARING_EMOJI="\360\237\247\271"
GEAR_EMOJI="\342\232\231"
DONE_EMOJI="\342\234\205"

# -------------- JRE SE installation -------------

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
  printf "%b Downloading JRE SE...\n" "${COFFEE_EMOJI}"
  curl --silent -L --output ./temp/jre-se.tar.gz "$JAVA_SE_URL"

  printf "%b Unpacking JRE SE...\n" "${ARCHIVE_EMOJI}"
  tar -xf ./temp/jre-se.tar.gz

  OLD_JAVA_DIR=$(find . -type d -name 'jre*' -print -quit)
  mv "${OLD_JAVA_DIR[0]}" java
else
  printf "%b JRE SE already exists\n" "${DONE_EMOJI}"
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
  printf -- "online-mode=%s\n" "$ONLINE_MODE" >> ./server/server.properties
  printf -- "motd=%s\n" "$SERVER_DESCRIPTION" >> ./server/server.properties

  if [ -n "$RESOURCE_PACK" ]
  then
    printf -- "resource-pack=%s\n" "$RESOURCE_PACK" >> ./server/server.properties
    printf -- "resource-pack-sha1=%s\n" "$RESOURCE_PACK_CHECKSUM" >> ./server/server.properties
  fi

  [ -f ./server-icon.png ] && mv server-icon.png ./server/server-icon.png

  cd ./server || exit

  OLD_FORGE_JAR=$(find . -type f -name 'forge*.jar' -print -quit)
  mv "${OLD_FORGE_JAR[0]}" start.jar

  cd ../ || exit
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
