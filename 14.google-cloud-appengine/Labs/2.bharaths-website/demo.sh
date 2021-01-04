bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ gcloud app describe
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
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$


bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ gcloud app services describe `gcloud app services list| awk '{print $1}'|awk 'NR==2'`
id: bharath-app-service
name: apps/bharathpoc/services/bharath-app-service
split:
  allocations:
    bharath-prod-website-v3: 1.0
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ gcloud app services describe `gcloud app services list| awk '{print $1}'|awk 'NR==3'`
id: bharath-first-app
name: apps/bharathpoc/services/bharath-first-app
split:
  allocations:
    20210102t052918: 1.0
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$ gcloud app services describe `gcloud app services list| awk '{print $1}'|awk 'NR==4'`
id: default
name: apps/bharathpoc/services/default
split:
  allocations:
    20201228t121902: 1.0
bharath@cloudshell:~/bharath_gae_code/bharath-greetings (bharathpoc)$






