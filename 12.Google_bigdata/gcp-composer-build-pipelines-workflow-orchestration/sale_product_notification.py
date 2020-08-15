import datetime
import time

from airflow import models
from airflow.contrib.operators import bigquery_operator
from airflow.contrib.operators import bigquery_to_gcs
from airflow.operators import email_operator
from airflow.contrib.operators import bigquery_table_delete_operator
from airflow.utils import trigger_rule

updated_time = time.strftime('%d-%m-%Y %H:%M:%S')

bq_dataset_name = models.Variable.get('bq_dataset_name')
bq_products_on_sale_table_id = bq_dataset_name + '.temp_sale_table'
output_file = '{gcs_bucket}/products_on_sale {current_time}.csv'.format(
    gcs_bucket=models.Variable.get('gcs_bucket'), current_time=updated_time)

yesterday = datetime.datetime.combine(
    datetime.datetime.today() - datetime.timedelta(1),
    datetime.datetime.min.time())

email_id = models.Variable.get('email')

default_dag_args = {
    'start_date': yesterday,
    'email': email_id,
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=2),
    'project_id': models.Variable.get('gcp_project')
}

with models.DAG(
        'current_products_on_sale_notification',
        schedule_interval=datetime.timedelta(days=1),
        default_args=default_dag_args) as dag:

    query_current_sales_products = bigquery_operator.BigQueryOperator(
        task_id='query_products_on_sale',
        bql="""
        SELECT product_id, product_name
        FROM `{bq_table_id}` 
        WHERE sale = True
        """.format(bq_table_id=models.Variable.get('bq_table_id')),
        use_legacy_sql=False,
        destination_dataset_table=bq_products_on_sale_table_id,
        write_disposition='WRITE_TRUNCATE')

    export_data_to_gcs = bigquery_to_gcs.BigQueryToCloudStorageOperator(
        task_id='export_sale_data_to_gcs',
        source_project_dataset_table=bq_products_on_sale_table_id,
        destination_cloud_storage_uris=[output_file],
        export_format='CSV')

    email_updation_notification = email_operator.EmailOperator(
        task_id='email_notification',
        to=email_id,
        subject='Sale product data updated',
        html_content="""
        Updated sale products for {current_time}.
        """.format(current_time=updated_time),
        trigger_rule=trigger_rule.TriggerRule.ALL_SUCCESS)

    delete_bq_table = bigquery_table_delete_operator.BigQueryTableDeleteOperator(
        task_id='delete_bigquery_table',
        deletion_dataset_table=bq_products_on_sale_table_id)
    ( 
    query_current_sales_products 
    >> export_data_to_gcs 
    >> email_updation_notification 
    >> delete_bq_table
    )