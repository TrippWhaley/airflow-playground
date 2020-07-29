from datetime import timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.email_operator import EmailOperator
from airflow.utils.dates import days_ago
from airflow.utils.trigger_rule import TriggerRule

default_args = {
    'owner': 'Tripp Whaley',
    'depends_on_past': False,
    'start_date': days_ago(5),
    'catchup': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
    'wait_for_downstream': False,
}

dag = DAG(
    'test',
    default_args=default_args,
    description='Test DAG',
    schedule_interval="0 0 * * *",
)

email_notifications = EmailOperator(
    task_id='Email',
    to='twhaley215@gmail.com',
    subject='Airflow processing report',
    html_content='Did it work?',
    trigger_rule=TriggerRule.ALL_DONE,
    dag=dag
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

t1 >> t2 >> email_notifications
