#!/bin/bash

export JAVA_HOME=$PWD/java/Contents/Home
java -version
echo

cd ./server || exit
sh ./run.sh nogui > output.log & echo $! > server.pid

echo "Server is running! Logs will be saved to: server/output.log"
