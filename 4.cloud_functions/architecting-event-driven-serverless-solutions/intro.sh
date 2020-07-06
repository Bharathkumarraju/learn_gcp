harath@cloudshell:~ (srianjaneyam)$ gcloud functions call test_http_function
executionId: tmt7qngrmvgb
result: Hello World!
bharath@cloudshell:~ (srianjaneyam)$


bharath@cloudshell:~/test_http_trigger_function (srianjaneyam)$ gcloud functions deploy test_deploy_from_cli --entry-point helloWorld --runtime nodejs10 --trigger-http
Allow unauthenticated invocations of new function
[test_deploy_from_cli]? (y/N)?  y

Deploying function (may take a while - up to 2 minutes)...done.
availableMemoryMb: 256
entryPoint: helloWorld
httpsTrigger:
  url: https://us-central1-srianjaneyam.cloudfunctions.net/test_deploy_from_cli
ingressSettings: ALLOW_ALL
labels:
  deployment-tool: cli-gcloud
name: projects/srianjaneyam/locations/us-central1/functions/test_deploy_from_cli
runtime: nodejs10
serviceAccountEmail: srianjaneyam@appspot.gserviceaccount.com
sourceUploadUrl: https://storage.googleapis.com/gcf-upload-us-central1-8bb99363-cc94-4572-9907-7184e6bebb2e/2adfbb77-ff80-4986-b16d-d7270dac7146.zip?GoogleAccessId=service-202016682554@gcf-admin-robot.iam.gserviceaccount.com&Expires=1593988698&Signature=sh11JDOmQ3KCpYaq6diS2MQ2Ad1CTtLCYsQNZMi95n36H4EQlXb58hKajaTSUhcgCROThYlb%2Fm5ko8k4kUz4s7z2lZc4b%2BqL6GYnFcaBlmw%2BhONxQrwPrEjqt%2BXOa9cf6eZ1JwXzq8a2PVlGSvqxuuwRJEA55zJYJ0%2Fliq53EKYu79NFORCWG%2F%2FPj%2FnVoD1ThmOigF1KCnXtp5VMuhz1zFsaYGpP9n0wxrVcvwjf2oyh7NuiX2lGIl2eRpD7A0v0XteRCM%2BA9GlwREGl2BJrfXZOjTLUjacJ2TZ4kQyDGJ4U%2BiDAbGPHrUPrGRzGvnVEr9CJoholgxfgMb1rEZhAtQ%3D%3D
status: ACTIVE
timeout: 60s
updateTime: '2020-07-05T22:09:06.330Z'
versionId: '1'
bharath@cloudshell:~/test_http_trigger_function (srianjaneyam)$



bharath@cloudshell:~/test_http_trigger_function (srianjaneyam)$ gcloud functions call test_deploy_from_cli
executionId: sbuwsjamt64l
result: Hello From BHARATH!!!
bharath@cloudshell:~/test_http_trigger_function (srianjaneyam)$




bharath@cloudshell:~/test_http_trigger_function (srianjaneyam)$ curl -X POST https://us-central1-srianjaneyam.cloudfunctions.net/pythonweb -H "Content-Type:application/json" -d '{"name":"Bharath","issue":"order delayed"}'
Ticket generated with id, 1524
bharath@cloudshell:~/test_http_trigger_function (srianjaneyam)$




