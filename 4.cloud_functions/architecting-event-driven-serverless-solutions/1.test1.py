import os
import json
import random
import xmltodict
from google.cloud import storage
from flask import abort

storage_client = storage.Client()
TICKETS_BUCKET = os.environ.get('bharath-cloudfunctions-bucket')
def raise_ticket(request):
    content_type = request.headers['content-type']

    if content_type == 'application/json':
        name = request.json.get('name')
        issue = request.json.get('issue')
    elif content_type == 'application/octet-stream':
        temp_data = request.data.decode("utf-8")
        words = temp_data.split()
        name = words[words.index('name:') + 1]
        issue = temp_data.split("issue:",1)[1]
    elif content_type == 'text/plain':
        temp_data = request.data.decode("utf-8")
        words = temp_data.split()
        name = words[words.index('name:') + 1]
        issue = temp_data.split("issue:",1)[1]
    elif content_type == 'application/x-www-form-urlencoded':
        name = request.form.get('name')
        issue = request.form.get('issue')
    else:
        raise ValueError("Unknown content type: {}".format(content_type))

    id = random.randint(1000,2000)

    tickets_dict = {}
    tickets_dict['id']=id
    tickets_dict['name']=name
    tickets_dict['issue']=issue
    bucket = storage_client.get_bucket(TICKETS_BUCKET)
    blob = bucket.blob('parsed_data/tickets.json')
    if blob.exists():
        blob.download_to_filename('/tmp/tickets.json')
    with open("/tmp/tickets.json", 'a') as fp:
        json.dump(tickets_dict,fp,indent=2)

    blob.upload_from_filename('/tmp/tickets.json')
    return 'Ticket generated with id, {}'.format(id)
