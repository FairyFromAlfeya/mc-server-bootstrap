#!/bin/bash

JAVA_PATH_MAC_OS=$PWD/java/Contents/Home
JAVA_PATH_LINUX=$PWD/java

if [ "$(arch)" = "arm64" ]
then
  export JAVA_HOME=$JAVA_PATH_MAC_OS
elif [ "$(arch)" = "x86_64" ]
then
  export JAVA_HOME=$JAVA_PATH_LINUX
else
  echo "System architecture $(arch) is not supported. Aborting..."
  exit
fi

PATH=$JAVA_HOME/bin:$PATH

java -version
echo

cd ./server || exit
sh ./run.sh nogui > output.log & echo $! > server.pid

echo "Server is running! Logs will be saved to: server/output.log"
