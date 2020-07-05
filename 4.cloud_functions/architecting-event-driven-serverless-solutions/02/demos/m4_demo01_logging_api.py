import os
import json
import requests
import logging
from google.cloud import storage
from google.cloud import logging as cloud_logging

def health_check(request):
    logging.info("Health check started.")
    try:
        logging.warn("Health check will raise an exception if request times out in 10s.")
        response = requests.get("http://wwww.spikeysales.com", verify=False,timeout=10)
        if response.status_code != requests.codes.OK:
            logging.error("website failed health check (got '{}', expected: '200')".format(response.status_code))
    except (requests.Timeout, requests.ConnectionError, KeyError) as e:
        logging.error("Request timed out.")
    
    logging_client = cloud_logging.Client()
    log_name = 'cloudfunctions.googleapis.com%2Fcloud-functions'
    logger = logging_client.logger(log_name.format(os.getenv('spikey-developers')))

storage_client = storage.Client()
    LOGS_BUCKET = 'spikey_cloud_functions'
    
    bucket = storage_client.get_bucket(LOGS_BUCKET)
    blob = bucket.blob('logs/logs.json')
    
    all_entries = logger.list_entries(page_size=10)
    entries = next(all_entries.pages)
    
    logs_dict = {}
    
    for entry in entries:
        timestamp = entry.timestamp.isoformat()
        logs_dict['timestamp'] = timestamp
        logs_dict['payload'] = entry.payload
        with open("/tmp/logs.json", 'a') as fp:
            json.dump(logs_dict,fp,indent=2)
        blob.upload_from_filename('/tmp/logs.json')

return 'Done!'

google-cloud-storage
google-cloud-logging



