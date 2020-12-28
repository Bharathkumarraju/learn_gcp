


* Module 1 Demo 1

export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"

gcloud auth application-default login

sudo pip install -r requirements.txt 

dev_appserver.py app.yaml

gcloud app create --region=us-central

gcloud app deploy --version spikey-greetings

- Show automatic staging in gloud storage

gcloud app describe 

gcloud app logs read -s default

gcloud app browse

- Show all monitoring and degugging stuff

sudo apt-get install siege

siege -c 250 https://spikey-apps.appspot.com/



* Module 2 Demo 1

gcloud app deploy --version spikey-prod-website-v1

gcloud app services describe spikey-app-service

gcloud app deploy --version spikey-prod-website-v2

- Show traffic splitting 

- Show traffic migration to website-v2 again

gcloud app services delete spikey-app-service --version spikey-prod-website-v1



* Demo 2

dev_appserver.py app.yaml

gcloud app deploy app.yaml index.yaml --version  spikey-guestbook

- Add data and show that data is present in datastore


# Reviews
Easy online ordering and we received the medicine we needed for my pet quickly. Will use them again.

Customer service give all information you need to choose the right dog, from the best breeder.

Spikey customer service guide you through the whole process

* Demo 3 

- Explain concept of memcache by adding cache

dev_appserver.py app.yaml

gcloud app deploy app.yaml index.yaml --version  spikey-guestbook

- Observe hits and miss of cache in website and memcache console both



* Module 3 Demo 1

gcloud app deploy -v spikey-nginx-website


Demo 2

gcloud beta pubsub topics create spikey-coupon-topic

gcloud beta pubsub subscriptions create spikey-coupon-subscription \
     --topic spikey-coupon-topic \
     --push-endpoint \
         https://spikey-app-service-dot-spikey-apps.appspot.com/pubsub/push?token=1234abc \
     --ack-deadline 30


gcloud app deploy -v spikey-coupon








