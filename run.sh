#!/bin/bash
set -e

declare -r CONTAINER=$(docker ps -aq --filter name=airflow_webserver)
docker stop $CONTAINER && docker rm $CONTAINER
docker build -t airflow .
docker run -d --env-file=.env -p 8080 --name=airflow_webserver airflow:latest > airflow_webserver.log 2>&1 &

if [[ "$OSTYPE" == "msys"* ]]; then
  declare -r HOST=$(docker-machine ip):$(docker container port airflow_webserver | cut -d ":" -f2)
  echo $HOST > /dev/clipboard
  echo "Container running on $HOST and copied to clipboard for convenience"
else
  echo "Container running on localhost:8080"
fi
