bharathkumarraju@R77-NB193 ntuc-coe-central-data % gcloud composer  environments list --locations australia-southeast1
┌───────────────────────┬──────────────────────┬─────────┬──────────────────────────┐
│          NAME         │       LOCATION       │  STATE  │       CREATE_TIME        │
├───────────────────────┼──────────────────────┼─────────┼──────────────────────────┤
│ test-composer-bharath │ australia-southeast1 │ RUNNING │ 2020-08-17T03:58:06.741Z │
└───────────────────────┴──────────────────────┴─────────┴──────────────────────────┘
bharathkumarraju@R77-NB193 ntuc-coe-central-data %


bharathkumarraju@R77-NB193 ntuc-coe-central-data % gsutil cat gs://australia-southeast1-test-c-36feca8a-bucket/airflow.cfg
[core]
dags_folder = /home/airflow/gcs/dags
base_log_folder = /home/airflow/gcs/logs
plugins_folder = /home/airflow/gcs/plugins
remote_logging = True
remote_log_conn_id = google_cloud_default
remote_base_log_folder = gs://australia-southeast1-test-c-36feca8a-bucket/logs
executor = CeleryExecutor
dags_are_paused_at_creation = False
load_examples = False
donot_pickle = True
dagbag_import_timeout = 30
parallelism = 30
dag_concurrency = 15
max_active_runs_per_dag = 15
enable_xcom_pickling = False
sql_alchemy_pool_recycle = 570
store_serialized_dags = False
min_serialized_dag_update_interval = 30

[webserver]
web_server_host = 0.0.0.0
web_server_port = 8080
secret_key = temporary_key
workers = 2
worker_class = sync
expose_config = True
web_server_name = test-composer-bharath
async_dagbag_loader = False
worker_refresh_interval = 60
web_server_worker_timeout = 60

[celery]
celery_app_name = airflow.executors.celery_executor
worker_concurrency = 6
worker_log_server_port = 8793
broker_url = redis://airflow-redis-service.default.svc.cluster.local:6379/0
result_backend = redis://airflow-redis-service.default.svc.cluster.local:6379/0
flower_port = 5555
default_queue = default
ssl_active = False

[email]
email_backend = airflow.contrib.utils.sendgrid.send_email

[smtp]
smtp_host = localhost
smtp_starttls = True
smtp_ssl = False
smtp_user = airflow
smtp_port = 25
smtp_password = airflow
smtp_mail_from = no-reply@cloud.google.com

[scheduler]
dag_dir_list_interval = 100
statsd_on = True
statsd_host = airflow-monitoring-service.default.svc.cluster.local
statsd_port = 8125
statsd_prefix = airflow

[kubernetes]
in_cluster = False

bharathkumarraju@R77-NB193 ntuc-coe-central-data %



