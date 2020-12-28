~/bharath_gae_code/bharath-greetings>
-->gcloud app deploy --version bharath-greetings1
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/bharath-greetings/app.yaml]
source:          [/home/bharath/bharath_gae_code/bharath-greetings]
target project:  [bharathpoc]
target service:  [default]
target version:  [bharath-greetings1]
target url:      [https://bharathpoc.et.r.appspot.com]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [default]...
Created .gcloudignore file. See `gcloud topic gcloudignore` for details.
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 3 files to Google Cloud Storage                ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Updating service [default]...⠧





==============================================================================>
~/bharath_gae_code/bharath-greetings>
-->gcloud app deploy --version bharath-greetings1
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/bharath-greetings/app.yaml]
source:          [/home/bharath/bharath_gae_code/bharath-greetings]
target project:  [bharathpoc]
target service:  [default]
target version:  [bharath-greetings1]
target url:      [https://bharathpoc.et.r.appspot.com]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [default]...
Created .gcloudignore file. See `gcloud topic gcloudignore` for details.
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 3 files to Google Cloud Storage                ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Updating service [default]...done.
Setting traffic split for service [default]...done.
Deployed service [default] to [https://bharathpoc.et.r.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s default

To view your application in the web browser run:
  $ gcloud app browse
~/bharath_gae_code/bharath-greetings>
-->gcloud app browse
Did not detect your browser. Go to this link to view your app:
https://bharathpoc.et.r.appspot.com
~/bharath_gae_code/bharath-greetings>
-->




~/bharath_gae_code/bharath-greetings>
-->gcloud app describe
authDomain: gmail.com
codeBucket: staging.bharathpoc.appspot.com
databaseType: CLOUD_DATASTORE_COMPATIBILITY
defaultBucket: bharathpoc.appspot.com
defaultHostname: bharathpoc.et.r.appspot.com
featureSettings:
  splitHealthChecks: true
  useContainerOptimizedOs: true
gcrDomain: asia.gcr.io
id: bharathpoc
locationId: asia-southeast2
name: apps/bharathpoc
servingStatus: SERVING
~/bharath_gae_code/bharath-greetings>
-->



~/bharath_gae_code/bharath-greetings>
-->siege -c 250 https://bharathpoc.et.r.appspot.com/
** SIEGE 4.0.4
** Preparing 250 concurrent users for battle.
The server is now under siege...[error] A temporary resolution error for bharathpoc.et.r.appspot.com
: Resource temporarily unavailable
[error] A temporary resolution error for bharathpoc.et.r.appspot.com

[error] A temporary resolution error for bharathpoc.et.r.appspot.com

[error] A temporary resolution error for bharathpoc.et.r.appspot.com

[error] A temporary resolution error for bharathpoc.et.r.appspot.com
: Resource temporarily unavailable
[error] A temporary resolution error for bharathpoc.et.r.appspot.com
: Resource temporarily unavailable

-->

