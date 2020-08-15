import datetime
from scipy import stats

from airflow import models
from airflow.operators import python_operator

yesterday = datetime.datetime.combine(
    datetime.datetime.today() - datetime.timedelta(1),
    datetime.datetime.min.time())

default_dag_args = {
    'start_date': yesterday,
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=2)
}

with models.DAG(
        'finding_the_most_common_element',
        schedule_interval=datetime.timedelta(days=1),
        default_args=default_dag_args) as dag:

    def print_most_common_number():
        num = stats.mode(["9","5","2","5","1","6"])
        print(num)
        return('Successfully printed most common element!')


    printing_most_common_element = python_operator.PythonOperator(
        task_id='most_common_number',
        python_callable=print_most_common_number)

    printing_most_common_element