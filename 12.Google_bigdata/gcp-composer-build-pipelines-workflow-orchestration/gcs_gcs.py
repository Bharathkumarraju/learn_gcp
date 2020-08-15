import datetime

from airflow import models
from airflow.operators import bash_operator

default_dag_args = {
    'start_date': datetime.datetime(2018, 12, 17, 0, 0),
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=2),
    'project_id': models.Variable.get('gcp_project')
}

source_bucket = models.Variable.get('gcs_source_bucket')
dest_bucket = models.Variable.get('gcs_dest_bucket')

with models.DAG(
        'transferring_data_from_gcs_to_gcs',
        schedule_interval=None,
        default_args=default_dag_args) as dag:

    transfer_data_gcs_to_gcs = bash_operator.BashOperator(
        task_id='data_transfer_gcs_to_gcs',
        bash_command='gsutil cp -r {source} {dest}'.format(
        source=source_bucket, dest=dest_bucket))

    transfer_data_gcs_to_gcs