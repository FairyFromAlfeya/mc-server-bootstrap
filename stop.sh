#!/bin/bash

PID=$(cat ./server/server.pid)

echo "Stopping process $PID"

kill -15 "$PID"
rm ./server/server.pid

echo "Server was stopped"
