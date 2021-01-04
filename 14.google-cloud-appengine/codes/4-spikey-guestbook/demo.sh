bharath@cloudshell:~/bharath_gae_code/bk-guestbook (bharathpoc)$ gcloud app deploy app.yaml index.yaml --version bharath-guestbook
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/bk-guestbook/app.yaml]
source:          [/home/bharath/bharath_gae_code/bk-guestbook]
target project:  [bharathpoc]
target service:  [bharath-app-service]
target version:  [bharath-guestbook]
target url:      [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]


Configurations to update:

descriptor:      [/home/bharath/bharath_gae_code/bk-guestbook/index.yaml]
type:            [datastore indexes]
target project:  [bharathpoc]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [bharath-app-service]...
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 4 files to Google Cloud Storage                ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Updating service [bharath-app-service]...done.
Setting traffic split for service [bharath-app-service]...done.
Stopping version [bharathpoc/bharath-app-service/bharath-prod-website-v3].
Sent request to stop version [bharathpoc/bharath-app-service/bharath-prod-website-v3]. This operation may take some time to complete. If you would like to verify that it succeeded, run:
  $ gcloud app versions describe -s bharath-app-service bharath-prod-website-v3
until it shows that the version has stopped.
Deployed service [bharath-app-service] to [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]
.... 100%...done.
Updating config [index]...done.

Indexes are being rebuilt. This may take a moment.

You can stream logs from the command line by running:
  $ gcloud app logs tail -s bharath-app-service

To view your application in the web browser run:
  $ gcloud app browse -s bharath-app-service
bharath@cloudshell:~/bharath_gae_code/bk-guestbook (bharathpoc)$ gcloud app browse
Did not detect your browser. Go to this link to view your app:
https://bharathpoc.et.r.appspot.com
bharath@cloudshell:~/bharath_gae_code/bk-guestbook (bharathpoc)$

============================================================================================================================================================================================================>

bharath@cloudshell:~/bharath_gae_code/bk-guestbook (bharathpoc)$ gcloud app browse -s bharath-app-service
Did not detect your browser. Go to this link to view your app:
https://bharath-app-service-dot-bharathpoc.et.r.appspot.com
bharath@cloudshell:~/bharath_gae_code/bk-guestbook (bharathpoc)$


