#!/bin/bash
set -ex

docker build -t airflow .
docker run -p 8080 airflow:latest &

if [[ "$OSTYPE" == "msys"* ]]; then
  echo "Container running on $(docker-machine ip):$(docker ps | grep 8080)"
else
  echo "Container running on localhost:8080"
fi
