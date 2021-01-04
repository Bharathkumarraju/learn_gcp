bharath@cloudshell:~/bharath_gae_code/appengine-flexible-env1 (bharathpoc)$ gcloud app deploy -v bharath-app-flexible
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/appengine-flexible-env1/app.yaml]
source:          [/home/bharath/bharath_gae_code/appengine-flexible-env1]
target project:  [bharathpoc]
target service:  [bharath-app-service]
target version:  [bharath-app-flexible]
target url:      [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]


Do you want to continue (Y/n)?  Y

Enabling service [appengineflex.googleapis.com] on project [bharathpoc]...
Operation "operations/acf.54a94f5b-d949-4194-ac83-915d9ae7af97" finished successfully.
Beginning deployment of service [bharath-app-service]...
Building and pushing image for service [bharath-app-service]
Started cloud build [2a4d26f2-9482-4b94-a626-7b3d73259b79].
To see logs in the Cloud Console: https://console.cloud.google.com/cloud-build/builds/2a4d26f2-9482-4b94-a626-7b3d73259b79?project=499322213275
----------------------------------------------------------------------------------------------------------------------------------------- REMOTE BUILD OUTPUT -----------------------------------------------------------------------------------------------------------------------------------------
starting build "2a4d26f2-9482-4b94-a626-7b3d73259b79"

FETCHSOURCE
Fetching storage object: gs://staging.bharathpoc.appspot.com/asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-flexible:latest#1609723987510561
Copying gs://staging.bharathpoc.appspot.com/asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-flexible:latest#1609723987510561...
- [1 files][  3.2 KiB/  3.2 KiB]
Operation completed over 1 objects/3.2 KiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  15.36kB
Step 1/6 : FROM nginx
latest: Pulling from library/nginx
6ec7b7d162b2: Already exists
cb420a90068e: Pulling fs layer
2766c0bf2b07: Pulling fs layer
e05167b6a99d: Pulling fs layer
70ac9d795e79: Pulling fs layer
70ac9d795e79: Waiting
2766c0bf2b07: Verifying Checksum
2766c0bf2b07: Download complete
e05167b6a99d: Verifying Checksum
e05167b6a99d: Download complete
70ac9d795e79: Verifying Checksum
70ac9d795e79: Download complete
cb420a90068e: Verifying Checksum
cb420a90068e: Download complete
cb420a90068e: Pull complete
2766c0bf2b07: Pull complete
e05167b6a99d: Pull complete
70ac9d795e79: Pull complete
Digest: sha256:4cf620a5c81390ee209398ecc18e5fb9dd0f5155cd82adcbae532fec94006fb9
Status: Downloaded newer image for nginx:latest
 ---> ae2feff98a0c
Step 2/6 : COPY nginx.conf /etc/nginx/nginx.conf
 ---> 89c38b6c92ac
Step 3/6 : RUN mkdir -p /var/log/app_engine
 ---> Running in bb7396c6bb70
Removing intermediate container bb7396c6bb70
 ---> 9377feb2c69d
Step 4/6 : RUN mkdir -p /usr/share/nginx/www/_ah &&     echo "healthy" > /usr/share/nginx/www/_ah/health
 ---> Running in a01220920d41
Removing intermediate container a01220920d41
 ---> cd7d4ab7ee0c
Step 5/6 : ADD www/ /usr/share/nginx/www/
 ---> 8f590a9f4689
Step 6/6 : RUN chmod -R a+r /usr/share/nginx/www
 ---> Running in d14d700b0a2a
Removing intermediate container d14d700b0a2a
 ---> 4c7a9e645734
Successfully built 4c7a9e645734
Successfully tagged asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-flexible:latest
PUSH
Pushing asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-flexible:latest
The push refers to repository [asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-flexible]
2a5d796581f8: Preparing
7b46bda9d9ba: Preparing
3017b851ea07: Preparing
ab0e0813757b: Preparing
8e1c29b93bbc: Preparing
4eaf0ea085df: Preparing
2c7498eef94a: Preparing
7d2b207c2679: Preparing
5c4e5adc71a8: Preparing
87c8a1d8f54f: Preparing
4eaf0ea085df: Waiting
2c7498eef94a: Waiting
7d2b207c2679: Waiting
5c4e5adc71a8: Waiting
87c8a1d8f54f: Waiting
8e1c29b93bbc: Pushed
7b46bda9d9ba: Pushed
3017b851ea07: Pushed
ab0e0813757b: Pushed
2a5d796581f8: Pushed
4eaf0ea085df: Layer already exists
2c7498eef94a: Layer already exists
5c4e5adc71a8: Layer already exists
7d2b207c2679: Layer already exists
87c8a1d8f54f: Layer already exists
latest: digest: sha256:0fa77acdd0f31b372a27c93ee27ba75c5184f66f467490a23d2df012ec47d5ab size: 2399
DONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Updating service [bharath-app-service] (this may take several minutes)...done.
Setting traffic split for service [bharath-app-service]...done.
Deployed service [bharath-app-service] to [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s bharath-app-service

To view your application in the web browser run:
  $ gcloud app browse -s bharath-app-service
bharath@cloudshell:~/bharath_gae_code/appengine-flexible-env1 (bharathpoc)$


When the app is deployed to flexible environment the application config file looks like this...


runtime: custom
api_version: '1.0'
env: flexible
threadsafe: true
automatic_scaling:
  cool_down_period: 120s
  min_num_instances: 2
  max_num_instances: 20
  cpu_utilization:
    target_utilization: 0.5
network: {}
liveness_check:
  initial_delay_sec: 300
  check_interval_sec: 30
  timeout_sec: 4
  failure_threshold: 4
  success_threshold: 2
readiness_check:
  check_interval_sec: 5
  timeout_sec: 4
  failure_threshold: 2
  success_threshold: 2
  app_start_timeout_sec: 300