import random
import datetime

from airflow import models
from airflow.operators import bash_operator
from airflow.operators import python_operator
from airflow.operators import dummy_operator

yesterday = datetime.datetime.combine(
    datetime.datetime.today() - datetime.timedelta(1),
    datetime.datetime.min.time())

default_dag_args = {
    'start_date': yesterday
}

with models.DAG(
        'branching_python_operator',
        schedule_interval=datetime.timedelta(days=1),
        default_args=default_dag_args) as dag:

    def greeting():
        print('Greetings from SpikeySales! Happy shopping.')
        return 'Greeting successfully printed.' 

    def makeBranchChoice():
        x = random.randint(1, 5)

        if(x <= 2):
            return 'hello_spikey'

        else:
            return 'dummy'  

    run_this_first = dummy_operator.DummyOperator(
        task_id='run_this_first'
    )

    branching = python_operator.BranchPythonOperator(
        task_id='branching',
        python_callable=makeBranchChoice
    )

    run_this_first >> branching
          
    spikeysales_greeting = python_operator.PythonOperator(
        task_id='hello_spikey',
        python_callable=greeting)

    dummy_followed_python = dummy_operator.DummyOperator(
        task_id='follow_python')

    dummy = dummy_operator.DummyOperator(
        task_id='dummy')

    bash_greeting = bash_operator.BashOperator(
        task_id='bye_bash',
        bash_command='echo Goodbye! Hope to see you soon.',
        trigger_rule='one_success'
    )

    branching >> spikeysales_greeting >> dummy_followed_python >> bash_greeting
    branching >> dummy >> bash_greeting
