FROM python:3.7

RUN pip install \
 apache-airflow[postgres,gcp]==1.10.10 \
 --constraint \
        https://raw.githubusercontent.com/apache/airflow/1.10.10/requirements/requirements-python3.7.txt

RUN apt-get update && \
    apt-get install -y gettext-base

RUN mkdir -p /root/airflow/dags

RUN env

ADD airflow.cfg.template .

COPY dags/ /root/airflow/dags
COPY airflow_init.sh .

EXPOSE 8080

ENTRYPOINT ["./airflow_init.sh"]
