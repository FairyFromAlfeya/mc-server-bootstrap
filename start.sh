#!/bin/bash

# M means Megabyte, G means Gigabyte
MINIMUM_RAM_USAGE="3G"
MAXIMUM_RAM_USAGE="6G"

JAVA_PATH_MAC_OS=$PWD/java/Contents/Home
JAVA_PATH_LINUX=$PWD/java
JAVA_PATH_WINDOWS=$PWD/java

if [[ "$OSTYPE" = "darwin"* ]]
then
  export JAVA_HOME=$JAVA_PATH_MAC_OS
elif [[ "$OSTYPE" = "linux-gnu"* ]]
then
  export JAVA_HOME=$JAVA_PATH_LINUX
elif [[ "$OSTYPE" = "msys" ]]
then
  export JAVA_HOME=$JAVA_PATH_WINDOWS
else
  echo "System type $OSTYPE is not supported. Aborting..."
  exit
fi

PATH=$JAVA_HOME/bin:$PATH

java -version
echo

cd ./server || exit
java -Xms"$MINIMUM_RAM_USAGE" -Xmx"$MAXIMUM_RAM_USAGE" -jar ./start.jar nogui > output.log & echo $! > server.pid

echo "Server is running! Logs will be saved to: server/output.log"
