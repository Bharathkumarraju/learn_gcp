bharath@cloudshell:~/bharath_gae_code/bharath-prod-website (bharathpoc)$ gcloud app deploy --version bharath-prod-website-v1
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/bharath-prod-website/app.yaml]
source:          [/home/bharath/bharath_gae_code/bharath-prod-website]
target project:  [bharathpoc]
target service:  [bharath-app-service]
target version:  [bharath-prod-website-v1]
target url:      [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [bharath-app-service]...
Created .gcloudignore file. See `gcloud topic gcloudignore` for details.
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 3 files to Google Cloud Storage                ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Updating service [bharath-app-service]...done.
Setting traffic split for service [bharath-app-service]...done.
Deployed service [bharath-app-service] to [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s bharath-app-service

To view your application in the web browser run:
  $ gcloud app browse -s bharath-app-service
bharath@cloudshell:~/bharath_gae_code/bharath-prod-website (bharathpoc)$

