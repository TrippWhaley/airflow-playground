from datetime import timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': days_ago(2),
    'email': ['airflow@example.com'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'wait_for_downstream': False,
}

dag = DAG(
        'test',
        default_args=default_args,
        description='Test DAG',
        schedule_interval="0 0 * * *",
    )

t1 = BashOperator(
        task_id='t1',
        bash_command='echo $(date)',
        dag=dag
    )

t2 = BashOperator(
        task_id='t2',
        bash_command='ls -la',
        dag=dag
    )

t1 >> t2
