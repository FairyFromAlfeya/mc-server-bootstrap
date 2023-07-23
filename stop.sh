#!/bin/bash

PID=$(cat ./server/server.pid)

echo "Stopping process $PID"

pkill -15 -P "$PID"
rm ./server/server.pid

echo "Server was stopped"
