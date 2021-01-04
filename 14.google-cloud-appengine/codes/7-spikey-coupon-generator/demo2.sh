bharath@cloudshell:~/bharath_gae_code/appengine-flexible-env2 (bharathpoc)$ gcloud app deploy -v bharath-app-pubsub-coupon
Services to deploy:

descriptor:      [/home/bharath/bharath_gae_code/appengine-flexible-env2/app.yaml]
source:          [/home/bharath/bharath_gae_code/appengine-flexible-env2]
target project:  [bharathpoc]
target service:  [bharath-app-service]
target version:  [bharath-app-pubsub-coupon]
target url:      [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]


Do you want to continue (Y/n)?  Y

Beginning deployment of service [bharath-app-service]...
Building and pushing image for service [bharath-app-service]
Started cloud build [52ec70ef-68a6-4341-9495-fe0fdfca94b4].
To see logs in the Cloud Console: https://console.cloud.google.com/cloud-build/builds/52ec70ef-68a6-4341-9495-fe0fdfca94b4?project=499322213275
-------------------------------------------------------------------------------- REMOTE BUILD OUTPUT ---------------------------------------------------------------------------------
starting build "52ec70ef-68a6-4341-9495-fe0fdfca94b4"

FETCHSOURCE
Fetching storage object: gs://staging.bharathpoc.appspot.com/asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-pubsub-coupon:latest#1609729648986743
Copying gs://staging.bharathpoc.appspot.com/asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-pubsub-coupon:latest#1609729648986743...
- [1 files][  3.0 KiB/  3.0 KiB]
Operation completed over 1 objects/3.0 KiB.
BUILD
Starting Step #0
Step #0: Pulling image: gcr.io/gcp-runtimes/python/gen-dockerfile@sha256:ac444fc620f70ff80c19cde48d18242dbed63056e434f0039bf939433e7464aa
Step #0: sha256:ac444fc620f70ff80c19cde48d18242dbed63056e434f0039bf939433e7464aa: Pulling from gcp-runtimes/python/gen-dockerfile
Step #0: Digest: sha256:ac444fc620f70ff80c19cde48d18242dbed63056e434f0039bf939433e7464aa
Step #0: Status: Downloaded newer image for gcr.io/gcp-runtimes/python/gen-dockerfile@sha256:ac444fc620f70ff80c19cde48d18242dbed63056e434f0039bf939433e7464aa
Step #0: gcr.io/gcp-runtimes/python/gen-dockerfile@sha256:ac444fc620f70ff80c19cde48d18242dbed63056e434f0039bf939433e7464aa
Finished Step #0
Starting Step #1
Step #1: Pulling image: gcr.io/cloud-builders/docker@sha256:fb864d4f2bc3b4642a77cfb96adab6c449b2592ba6d41db388c171134b12b275
Step #1: sha256:fb864d4f2bc3b4642a77cfb96adab6c449b2592ba6d41db388c171134b12b275: Pulling from cloud-builders/docker
Step #1: 75f546e73d8b: Already exists
Step #1: 3c2cba919283: Already exists
Step #1: ea4bb9fa6007: Pulling fs layer
Step #1: 33f2cb8e56da: Pulling fs layer
Step #1: 33f2cb8e56da: Verifying Checksum
Step #1: 33f2cb8e56da: Download complete
Step #1: ea4bb9fa6007: Verifying Checksum
Step #1: ea4bb9fa6007: Download complete
Step #1: ea4bb9fa6007: Pull complete
Step #1: 33f2cb8e56da: Pull complete
Step #1: Digest: sha256:fb864d4f2bc3b4642a77cfb96adab6c449b2592ba6d41db388c171134b12b275
Step #1: Status: Downloaded newer image for gcr.io/cloud-builders/docker@sha256:fb864d4f2bc3b4642a77cfb96adab6c449b2592ba6d41db388c171134b12b275
Step #1: gcr.io/cloud-builders/docker@sha256:fb864d4f2bc3b4642a77cfb96adab6c449b2592ba6d41db388c171134b12b275
Step #1: Sending build context to Docker daemon  15.87kB
Step #1: Step 1/9 : FROM gcr.io/google-appengine/python@sha256:fc9d9f429bf75b8369f7894b7eb24098418050557b889f4b02aa4c93fdb5e161
Step #1: sha256:fc9d9f429bf75b8369f7894b7eb24098418050557b889f4b02aa4c93fdb5e161: Pulling from google-appengine/python
Step #1: Digest: sha256:fc9d9f429bf75b8369f7894b7eb24098418050557b889f4b02aa4c93fdb5e161
Step #1: Status: Downloaded newer image for gcr.io/google-appengine/python@sha256:fc9d9f429bf75b8369f7894b7eb24098418050557b889f4b02aa4c93fdb5e161
Step #1:  ---> 96b4d9af6594
Step #1: Step 2/9 : LABEL python_version=python3.6
Step #1:  ---> Running in 65c6c934b787
Step #1: Removing intermediate container 65c6c934b787
Step #1:  ---> 9e5685a2ccc2
Step #1: Step 3/9 : RUN virtualenv --no-download /env -p python3.6
Step #1:  ---> Running in 772c1a72093a
Step #1: created virtual environment CPython3.6.10.final.0-64 in 1337ms
Step #1:   creator CPython3Posix(dest=/env, clear=False, global=False)
Step #1:   seeder FromAppData(download=False, pip=bundle, wheel=bundle, setuptools=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
Step #1:     added seed packages: pip==20.2.2, setuptools==49.6.0, wheel==0.35.1
Step #1:   activators PythonActivator,FishActivator,XonshActivator,CShellActivator,PowerShellActivator,BashActivator
Step #1: Removing intermediate container 772c1a72093a
Step #1:  ---> 3ce10743288d
Step #1: Step 4/9 : ENV VIRTUAL_ENV /env
Step #1:  ---> Running in 0487bbb75ccd
Step #1: Removing intermediate container 0487bbb75ccd
Step #1:  ---> 182a874d29b3
Step #1: Step 5/9 : ENV PATH /env/bin:$PATH
Step #1:  ---> Running in 8424aa809d19
Step #1: Removing intermediate container 8424aa809d19
Step #1:  ---> 1d2e44caf1e4
Step #1: Step 6/9 : ADD requirements.txt /app/
Step #1:  ---> 38a07bcd0353
Step #1: Step 7/9 : RUN pip install -r requirements.txt
Step #1:  ---> Running in 8309018c2312
Step #1: Collecting Flask==0.12.2
Step #1:   Downloading Flask-0.12.2-py2.py3-none-any.whl (83 kB)
Step #1: Collecting google-cloud-pubsub==0.33.0
Step #1:   Downloading google_cloud_pubsub-0.33.0-py2.py3-none-any.whl (91 kB)
Step #1: Collecting gunicorn==19.7.1
Step #1:   Downloading gunicorn-19.7.1-py2.py3-none-any.whl (111 kB)
Step #1: Collecting Jinja2>=2.4
Step #1:   Downloading Jinja2-2.11.2-py2.py3-none-any.whl (125 kB)
Step #1: Collecting itsdangerous>=0.21
Step #1:   Downloading itsdangerous-1.1.0-py2.py3-none-any.whl (16 kB)
Step #1: Collecting click>=2.0
Step #1:   Downloading click-7.1.2-py2.py3-none-any.whl (82 kB)
Step #1: Collecting Werkzeug>=0.7
Step #1:   Downloading Werkzeug-1.0.1-py2.py3-none-any.whl (298 kB)
Step #1: Collecting grpc-google-iam-v1<0.12dev,>=0.11.1
Step #1:   Downloading grpc-google-iam-v1-0.11.4.tar.gz (12 kB)
Step #1: Collecting google-api-core[grpc]<2.0.0dev,>=0.1.3
Step #1:   Downloading google_api_core-1.24.1-py2.py3-none-any.whl (92 kB)
Step #1: Collecting psutil<6.0dev,>=5.2.2
Step #1:   Downloading psutil-5.8.0-cp36-cp36m-manylinux2010_x86_64.whl (291 kB)
Step #1: Collecting MarkupSafe>=0.23
Step #1:   Downloading MarkupSafe-1.1.1-cp36-cp36m-manylinux1_x86_64.whl (27 kB)
Step #1: Collecting grpcio<2.0.0dev,>=1.0.0
Step #1:   Downloading grpcio-1.34.0-cp36-cp36m-manylinux2014_x86_64.whl (4.0 MB)
Step #1: Collecting googleapis-common-protos[grpc]<2.0.0dev,>=1.5.2
Step #1:   Downloading googleapis_common_protos-1.52.0-py2.py3-none-any.whl (100 kB)
Step #1: Requirement already satisfied: setuptools>=34.0.0 in /env/lib/python3.6/site-packages (from google-api-core[grpc]<2.0.0dev,>=0.1.3->google-cloud-pubsub==0.33.0->-r requirements.txt (line 2)) (49.6.0)
Step #1: Collecting google-auth<2.0dev,>=1.21.1
Step #1:   Downloading google_auth-1.24.0-py2.py3-none-any.whl (114 kB)
Step #1: Collecting six>=1.13.0
Step #1:   Using cached six-1.15.0-py2.py3-none-any.whl (10 kB)
Step #1: Collecting pytz
Step #1:   Downloading pytz-2020.5-py2.py3-none-any.whl (510 kB)
Step #1: Collecting requests<3.0.0dev,>=2.18.0
Step #1:   Downloading requests-2.25.1-py2.py3-none-any.whl (61 kB)
Step #1: Collecting protobuf>=3.12.0
Step #1:   Downloading protobuf-3.14.0-cp36-cp36m-manylinux1_x86_64.whl (1.0 MB)
Step #1: Collecting cachetools<5.0,>=2.0.0
Step #1:   Downloading cachetools-4.2.0-py3-none-any.whl (12 kB)
Step #1: Collecting pyasn1-modules>=0.2.1
Step #1:   Downloading pyasn1_modules-0.2.8-py2.py3-none-any.whl (155 kB)
Step #1: Collecting rsa<5,>=3.1.4; python_version >= "3.6"
Step #1:   Downloading rsa-4.6-py3-none-any.whl (47 kB)
Step #1: Collecting urllib3<1.27,>=1.21.1
Step #1:   Downloading urllib3-1.26.2-py2.py3-none-any.whl (136 kB)
Step #1: Collecting certifi>=2017.4.17
Step #1:   Downloading certifi-2020.12.5-py2.py3-none-any.whl (147 kB)
Step #1: Collecting chardet<5,>=3.0.2
Step #1:   Downloading chardet-4.0.0-py2.py3-none-any.whl (178 kB)
Step #1: Collecting idna<3,>=2.5
Step #1:   Downloading idna-2.10-py2.py3-none-any.whl (58 kB)
Step #1: Collecting pyasn1<0.5.0,>=0.4.6
Step #1:   Downloading pyasn1-0.4.8-py2.py3-none-any.whl (77 kB)
Step #1: Building wheels for collected packages: grpc-google-iam-v1
Step #1:   Building wheel for grpc-google-iam-v1 (setup.py): started
Step #1:   Building wheel for grpc-google-iam-v1 (setup.py): finished with status 'done'
Step #1:   Created wheel for grpc-google-iam-v1: filename=grpc_google_iam_v1-0.11.4-py3-none-any.whl size=16130 sha256=8f403d262eee93c96f2891b6f99b8fe8cfd9abaa057a99a8b5b5255430b754a2
Step #1:   Stored in directory: /root/.cache/pip/wheels/76/ae/17/108ce2dcca55aae8a49fe725a883409ab17a3187b42bc4c63c
Step #1: Successfully built grpc-google-iam-v1
Step #1: Installing collected packages: MarkupSafe, Jinja2, itsdangerous, click, Werkzeug, Flask, six, grpcio, protobuf, googleapis-common-protos, grpc-google-iam-v1, cachetools, pyasn1, pyasn1-modules, rsa, google-auth, pytz, urllib3, certifi, chardet, idna, requests, google-api-core, psutil, google-cloud-pubsub, gunicorn
Step #1: Successfully installed Flask-0.12.2 Jinja2-2.11.2 MarkupSafe-1.1.1 Werkzeug-1.0.1 cachetools-4.2.0 certifi-2020.12.5 chardet-4.0.0 click-7.1.2 google-api-core-1.24.1 google-auth-1.24.0 google-cloud-pubsub-0.33.0 googleapis-common-protos-1.52.0 grpc-google-iam-v1-0.11.4 grpcio-1.34.0 gunicorn-19.7.1 idna-2.10 itsdangerous-1.1.0 protobuf-3.14.0 psutil-5.8.0 pyasn1-0.4.8 pyasn1-modules-0.2.8 pytz-2020.5 requests-2.25.1 rsa-4.6 six-1.15.0 urllib3-1.26.2
Step #1: WARNING: You are using pip version 20.2.2; however, version 20.3.3 is available.
Step #1: You should consider upgrading via the '/env/bin/python -m pip install --upgrade pip' command.
Step #1: Removing intermediate container 8309018c2312
Step #1:  ---> bcc00107ae84
Step #1: Step 8/9 : ADD . /app/
Step #1:  ---> db683ebb459b
Step #1: Step 9/9 : CMD exec gunicorn -b :$PORT main:app
Step #1:  ---> Running in 06ce478bd2f8
Step #1: Removing intermediate container 06ce478bd2f8
Step #1:  ---> f593e61afb2e
Step #1: Successfully built f593e61afb2e
Step #1: Successfully tagged asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-pubsub-coupon:latest
Finished Step #1
PUSH
Pushing asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-pubsub-coupon:latest
The push refers to repository [asia.gcr.io/bharathpoc/appengine/bharath-app-service.bharath-app-pubsub-coupon]
5b85372e12d6: Preparing
7825b2f60d9c: Preparing
ceb2049050fc: Preparing
aa4e65f2a13a: Preparing
3ec03be1bb38: Preparing
c5f91450ff31: Preparing
d8a99d217f22: Preparing
88cace8eb32b: Preparing
ae3630d8a5da: Preparing
f4abe2e82c92: Preparing
a43e6a3baa91: Preparing
41e2d890e349: Preparing
84ff92691f90: Preparing
6071362d21ac: Preparing
965eb7efdb65: Preparing
c5f91450ff31: Waiting
d8a99d217f22: Waiting
88cace8eb32b: Waiting
ae3630d8a5da: Waiting
f4abe2e82c92: Waiting
a43e6a3baa91: Waiting
41e2d890e349: Waiting
84ff92691f90: Waiting
6071362d21ac: Waiting
3ec03be1bb38: Layer already exists
c5f91450ff31: Layer already exists
d8a99d217f22: Layer already exists
88cace8eb32b: Layer already exists
ae3630d8a5da: Layer already exists
f4abe2e82c92: Layer already exists
a43e6a3baa91: Layer already exists
41e2d890e349: Layer already exists
ceb2049050fc: Pushed
5b85372e12d6: Pushed
84ff92691f90: Layer already exists
6071362d21ac: Layer already exists
965eb7efdb65: Layer already exists
aa4e65f2a13a: Pushed
7825b2f60d9c: Pushed
latest: digest: sha256:5625e84548ad4c159db305a522dddf61655c8f08429e96c3b707935f369c489b size: 3459
DONE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Updating service [bharath-app-service] (this may take several minutes)...done.
Setting traffic split for service [bharath-app-service]...done.
Stopping version [bharathpoc/bharath-app-service/bharath-app-flexible].
Sent request to stop version [bharathpoc/bharath-app-service/bharath-app-flexible]. This operation may take some time to complete. If you would like to verify that it succeeded, run:
  $ gcloud app versions describe -s bharath-app-service bharath-app-flexible
until it shows that the version has stopped.
Deployed service [bharath-app-service] to [https://bharath-app-service-dot-bharathpoc.et.r.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s bharath-app-service

To view your application in the web browser run:
  $ gcloud app browse -s bharath-app-service
bharath@cloudshell:~/bharath_gae_code/appengine-flexible-env2 (bharathpoc)$