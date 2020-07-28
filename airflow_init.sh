#!/bin/bash
set -ex

echo "Starting airflow db" && airflow initdb

echo "Starting airflow scheduler" && airflow scheduler &

echo "Starting airflow server" && airflow webserver -p 8080
