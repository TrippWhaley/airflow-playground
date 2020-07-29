#!/bin/bash
set -e

# Would prefer to do this in the dockerfile but it's giving me issues on envsubst
envsubst < airflow.cfg.template > /root/airflow/airflow.cfg

echo "Starting airflow db" && airflow initdb

echo "Starting airflow scheduler" && airflow scheduler &

echo "Starting airflow server" && airflow webserver -p 8080

echo "Done"
