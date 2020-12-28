bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ cp app.yaml app.yaml.org
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ vim app.yaml
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ gcloud app deploy app.yaml
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/bharath-greetings/app.yaml]
source:          [/home/bharath/bharath_gae_code/bharath-greetings]
target project:  [bharathpoc]
target service:  [default]
target version:  [20201228t121902]
target url:      [https://bharathpoc.et.r.appspot.com]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [default]...
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 1 file to Google Cloud Storage                 ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Updating service [default]...done.
Setting traffic split for service [default]...done.
Deployed service [default] to [https://bharathpoc.et.r.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s default

To view your application in the web browser run:
  $ gcloud app browse
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ gcloud app browse
Did not detect your browser. Go to this link to view your app:
https://bharathpoc.et.r.appspot.com
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$


