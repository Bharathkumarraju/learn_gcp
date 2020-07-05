Module 2

Demo 1
gcloud auth application-default login
gcloud components update
gcloud components install beta


Module 3
Demo 1


gcloud functions deploy hello --entry-point helloworld --runtime nodejs6 --trigger-http

gcloud functions call hello



Demo 2


curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:application/json"  -d '{"name":"Jane","issue":"Order delayed"}'

curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:application/octet-stream"  -d ' name: John issue: Refund pending'

curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:text/plain" -d " name: Sam issue: Request cancellation"

curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:application/x-www-form-urlencoded"  -d 'name=Judy&issue=Payment failed'


2) Handling XML content type

	Edit raising ticket

	elif content_type == 'text/xml':
        temp_data = xmltodict.parse(request.data)
        name = temp_data['ticketraiser']['@name']
        issue = temp_data['ticketraiser']['issue']

     xmltodict==0.11.0

     curl -X PUT https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type: text/xml" -d '<ticketraiser name="Sarah"><issue>Faulty packaging</issue></ticketraiser>'

3) HANDLING HTTP METHODS

curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:text/plain" -d " name: Don issue: Payment failed"

curl -X PUT https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:application/x-www-form-urlencoded"  -d 'name=Shawn&issue=Request cancellation'


curl -X GET https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets?name=Judy&issue=Paymentfailed

curl -X GET https://us-central1-spikey-developers.cloudfunctions.net/function-3?name=Judy&issue=Paymentfailed

Edit cloud function

from flask import abort

if request.method == 'GET':
        name = request.args.get('name')
        issue = request.args.get('issue')
    elif request.method == 'PUT':



    else:
        return abort(405)

https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets?name=Leanne&issue=RequestReturn

curl -X GET 'https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets?name=Dana&issue=RequestReplacement'


curl -X PUT https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:application/x-www-form-urlencoded"  -d 'name=Peter&issue=Request cancellation'

curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/raising_tickets -H "Content-Type:text/plain" -d " name: Dominic issue: Delayed Delivery"


4 ) multipart form/data



curl -i -X POST -H "Content-Type: multipart/form-data" -F 'image_id=PD_IMG123' -F 'product_name=MensDenimShirt' -F 'PD_IMG124.jpg=shirt.jpg' https://us-central1-spikey-developers.cloudfunctions.net/function-1


Module 4

Demo 1

Invoke curl -i -X POST -H "Content-Type: multipart/form-data" -F 'image_id=PD_IMG123' -F 'product_name=MensDenimShirt' -F 'PD_IMG124.jpg=shirt.jpg' https://us-central1-spikey-developers.cloudfunctions.net/function-1

Invoke curl -i -X POST -H "Content-Type: multipart/form-data" -F 'image_id=PD_IMG123' -F 'product_name=MensDenimShirt' -F 'PD_IMG124.jpg=shirt.jpg' https://us-central1-spikey-developers.cloudfunctions.net/function-1



Demo 2
PubSub


gcloud pubsub topics create spikey-offer-topic

gcloud pubsub subscriptions create spikey-offers-sub --topic spikey-offer-topic


curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/writing_offers -H "Content-Type:application/json"  -d '{"offer_text":"Diwali special sale on Spikeysales!"}'

gcloud pubsub subscriptions pull --auto-ack spikey-offers-sub

Demo 3




gcloud source repos create spikey-offers-repo



gcloud source repos clone spikey-offers-repo

nano pubsub.py

git add .

git commit -m "Add function to Cloud Source Repositories"

git push origin master


trigger-pubsub


curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/writing_offers -H "Content-Type:application/json"  -d '{"offer_text":"Christmas special sale on Spikeysales!"}'


Module 5

Demo 1

mkdir health-check-function

cd health-check-function

nano health-check-function.py


import requests
import logging

def health_check(request):
    logging.info("Health check started.")
    try:
        logging.warn("Health check will raise an exception if request times out in 10s.")
        response = requests.get("http://wwww.spikeysales.com", verify=False,timeout=10)
        if response.status_code != requests.codes.OK:
            logging.error("website failed health check (got '{}', expected: '200')".format(response.status_code))
    except (requests.Timeout, requests.ConnectionError, KeyError) as e:
        logging.error("Request timed out.")

gcloud functions deploy health_check --entry-point health_check --runtime python37 --trigger-http

gcloud functions call  health_check

gcloud functions logs read health_check


Demo 3


Demo 4

Enable stacdriver error reporting api



curl -X PUT https://us-central1-spikey-developers.cl
ts -H "Content-Type: text/xml" -d '<ticketraiser name="Sarah"><issue>Faulty packaging</issue></ticketraiser>'

curl -X PUT https://us-central1-spikey-developers.cl
ts -H "Content-Type: text/xml" -d '<ticketraiser name="Sarah"><issue>Faulty packaging</issue></ticketraiser>'



curl -X PUT https://us-central1-spikey-developers.cl
ts -H "Content-Type: text/xml" -d '<ticketraiser name="Sarah"><issue>Faulty packaging</issue></ticketraiser>'
