bharath@cloudshell:~/bharath_gae_code/bk-guestbook-memcache (bharathpoc)$ gcloud app deploy app.yaml index.yaml --version bharath-guestbook-memcache
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/bk-guestbook-memcache/app.yaml]
source:          [/home/bharath/bharath_gae_code/bk-guestbook-memcache]
target project:  [bharathpoc]
target service:  [bharath-app-service]
target version:  [bharath-guestbook-memcache]
target url:      [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]


Configurations to update:

descriptor:      [/home/bharath/bharath_gae_code/bk-guestbook-memcache/index.yaml]
type:            [datastore indexes]
target project:  [bharathpoc]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [bharath-app-service]...
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 1 file to Google Cloud Storage                 ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Updating service [bharath-app-service]...done.
Setting traffic split for service [bharath-app-service]...done.
Deployed service [bharath-app-service] to [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]
....done.
Updating config [index]...done.

Indexes are being rebuilt. This may take a moment.

You can stream logs from the command line by running:
  $ gcloud app logs tail -s bharath-app-service

To view your application in the web browser run:
  $ gcloud app browse -s bharath-app-service
bharath@cloudshell:~/bharath_gae_code/bk-guestbook-memcache (bharathpoc)$


