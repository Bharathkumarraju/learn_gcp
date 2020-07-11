gcloud config set project spikey-gcp
gcloud config set compute/zone us-central1-a
gcloud container get-server-config

#Creating a VPC-native cluster
gcloud container clusters create spikey-test-cluster \
    --enable-ip-alias \
    --create-subnetwork="" \
    --network=default \
    --zone=us-central1-a
    --cluster-version=1.11.5-gke.4

#Creating a Deployment
#Create a floder
Name = container-native-lb-files
spikeysales-app.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    run: spikeysales-app 
  name: spikeysales-app 
spec: 
  minReadySeconds: 60 
  selector:
    matchLabels:
      run: spikeysales-app
  template: 
    metadata:
      labels:
        run: spikeysales-app 
    spec: 
      containers:
      - image: k8s.gcr.io/serve_hostname:v1.4 
        name: hostname 
        ports:
        - containerPort: 9376 
          protocol: TCP
      terminationGracePeriodSeconds: 60

Save this manifest as spikysales-aap.yaml, then create the Deployment by running the following command:

  kubectl apply -f spikeysales-app.yaml

#Creating a Service for a container-native load balancer
spikeysales-service.yaml

apiVersion: v1
kind: Service
metadata:
  name: spikeysales-service 
  annotations:
    cloud.google.com/neg: '{"ingress": true}' 
spec: 
  selector:
    run: spikeysales-app 
  ports:
  - port: 80 
    protocol: TCP
    targetPort: 9376 

Save this manifest as spikey-service.yaml, then create the Service by running the following command:
kubectl apply -f spikeysales-service.yaml

#Creating an Ingress for the Service
spikeysales-ing.yaml

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: spikeysales-ing
spec:
  backend:
    serviceName: spikeysales-service 
    servicePort: 80

Save this manifest as spikeysales-ing.yaml, then create the Ingress by running the following command:
kubectl apply -f spikeysales-ing.yaml

#Verifying the Ingress
kubectl describe ingress spikeysales-ing

#Testing load balancer functionality
#Visit Ingress IP address
kubectl get ingress spikeysales-ing

#Check backend service health status
#First, get a list of the backend services running in your project
gcloud beta compute backend-services list

Copy of the name of the backend that includes the name of the Service,
gcloud compute backend-services get-health [BACKEND_SERVICE_NAME] --global

#Verifying Ingress functionality


#The following command scales the spikysales-aap Deployment from one instance to two instances:
kubectl scale deployment spikeysales-app  --replicas 5

#To verify that the rollout is complete, run the following command:
kubectl get deployment spikeysales-app

#You can get the Ingress IP address from 
kubectl describe ingress spikeysales-ing

#Then, run the following command to count the number of distinct responses from the load balancer:

for i in `seq 1 100`; do \
  curl --connect-timeout 1 -s [IP_ADDRESS] && echo; \
done  | sort | uniq -c

#where [IP_ADDRESS] is the Ingress' IP address
