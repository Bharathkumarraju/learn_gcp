
* MOdule 1 Demo 1
* Enable App Engine Admin API

sudo apt-get install python-yaml
git clone https://github.com/GoogleCloudPlatform/appengine-config-transformer.git

- converting app.yaml file to app.json
python appengine-config-transformer/convert_yaml.py  app.yaml > app.json

gcloud auth application-default login

export ACCESS_TOKEN=$(gcloud auth application-default print-access-token)
export PROJECT_ID=spikey-apps
export SERVICE=spikey-app-service

- Deployment 

curl -X POST -T "app.json" -H "Content-Type: application/json" \
 -H "Authorization: Bearer "$ACCESS_TOKEN \
 https://appengine.googleapis.com/v1/apps/$PROJECT_ID/services/$SERVICE/versions

- Verify Deployment

curl -H "Authorization: Bearer "$ACCESS_TOKEN \
 https://appengine.googleapis.com/v1/apps/spikey-apps/operations/04dd77cf-5bae-4a9b-9d7e-187e51c35bb2

curl -H "Authorization: Bearer "$ACCESS_TOKEN \
 https://appengine.googleapis.com/v1/apps/$PROJECT_ID/services/$SERVICE/versions/mail-alert/?view=FULL



* Module 1 Demo 2 

pip install -t lib -r requirements.txt

dev_appserver.py app.yaml

gcloud app deploy -v ticket-raiser-app


* Module 2 Demo 1

gcloud app deploy app.yaml cron.yaml -v weekly-offers

curl https://spikey-app-service-dot-spikey-apps.appspot.com/

* Module 2 Demo 2

dev_appserver.py app.yaml

gcloud app deploy app.yaml worker.yaml queue.yaml -v dog-push-counter


* Module 2 Demo 3

dev_appserver.py app.yaml

gcloud app deploy app.yaml worker.yaml queue.yaml -v dog-pull-counter 


* Module 3 Demo 1

sudo pip install -r requirements.txt

gsutil mb gs://dog-images

gsutil defacl set public-read gs://dog-images

http://spikey-apps.appspot.com/oauth2callback
https://spikey-apps.appspot.com/oauth2callback

http://spikeysales.com/oauth2callback
https://spikeysales.com/oauth2callback

http://www.spikeysales.com/oauth2callback
https://www.spikeysales.com/oauth2callback

* Here is your client ID
1066830280796-u5dg87ffqsvm826b0ltoea7tnt4151rd.apps.googleusercontent.com

* Here is your client secret
ZjydZXHFteNmIVqykP0CCZHK


python main.py

gcloud app deploy -v spikey-website

