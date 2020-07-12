#Create bharath-us-central1-server1 in zone us-central1-b
gcloud compute instances create bharath-us-central1-server1 \
    --image-family debian-10 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-central1-b \
    --network bharaths-vpc \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>bharath-us-central1-1</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create bharath-us-central1-server2 in zone us-central1-b
gcloud compute instances create bharath-us-central1-server2 \
    --image-family debian-10 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --network bharaths-vpc \
    --zone us-central1-b \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>bharath-us-central1-2</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create bharath-us-east1-server1 in zone us-east1-b
gcloud compute instances create bharath-us-east1-server1 \
    --image-family debian-10 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-east1-b \
    --network bharaths-vpc \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>bharath-us-east1-1</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create bharath-us-east1-server2 in zone us-east1-b
gcloud compute instances create bharath-us-east1-server2 \
    --image-family debian-10 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-east1-b \
    --network bharaths-vpc \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>bharath-us-east1-2</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create an instance group for each zone and add instances
#1.Create the us-ig1 instance group.
gcloud compute instance-groups unmanaged create bharath-us-instancegroup1 \
    --zone us-central1-b

#2.Create a named port for the instance group.
gcloud compute instance-groups set-named-ports bharath-us-instancegroup1 \
    --named-ports tcp110:110 \
    --zone us-central1-b

 #3.Add  bharath-us-central1-1 and bharath-us-central1-2 to bharath-us-instancegroup-1
gcloud compute instance-groups unmanaged add-instances bharath-us-instancegroup1 \
    --instances bharath-us-central1-server1,bharath-us-central1-server2 \
    --zone us-central1-b

#4.Create the bharath-us-instancegroup2 instance group.
gcloud compute instance-groups unmanaged create bharath-us-instancegroup2 \
    --zone us-east1-b

#5.Create a named port for the instance group.
gcloud compute instance-groups set-named-ports bharath-us-instancegroup2 \
    --named-ports tcp110:110 \
    --zone us-east1-b

#6.Add bharath-us-east1-server1 and bharath-us-east1-server2 to bharath-us-instancegroup2
gcloud compute instance-groups unmanaged add-instances bharath-us-instancegroup2 \
    --instances bharath-us-east1-server1,bharath-us-east1-server2 \
    --zone us-east1-b

#7.Configure load balancer

#Create a health check
gcloud compute health-checks create tcp bharath-tcp-health-check --port 110

#Create a backend service
gcloud compute backend-services create bharath-tcp-lb \
    --global \
    --protocol TCP \
    --health-checks bharath-tcp-healthcheck \
    --timeout 5m \
    --port-name tcp110

#Add instance group to your backend service
gcloud compute backend-services add-backend bharath-tcp-lb \
    --global \
    --instance-group bharath-us-instancegroup1 \
    --instance-group-zone us-central1-b \
    --balancing-mode UTILIZATION \
    --max-utilization 0.8

gcloud compute backend-services add-backend bharath-tcp-lb \
    --global \
    --instance-group bharath-us-instancegroup2 \
    --instance-group-zone us-east1-b \
    --balancing-mode UTILIZATION \
    --max-utilization 0.8

#Configure a target TCP proxy
gcloud compute target-tcp-proxies create bharath-tcp-lb-target-proxy \
    --backend-service bharath-tcp-lb \
    --proxy-header NONE

#Reserve global static IPv4  addresses
gcloud compute addresses create bharath-lb-static-ipv4 \
    --ip-version=IPV4 \
    --global


#Find the IP addresses
gcloud compute addresses list 

#Configure global forwarding rules for the two addresses
gcloud beta compute forwarding-rules create bharath-tcp-lb-ipv4-forwarding-rule \
    --global \
    --target-tcp-proxy bharath-tcp-lb-target-proxy \
    --address 34.107.160.59 \
    --ports 110


#Create a firewall rule for the TCP load balancer
gcloud compute firewall-rules create allow-tcplb-and-health \
     --source-ranges 130.211.0.0/22,35.207.0.0/16 \
     --target-tags tcp-lb \
     --allow tcp:110


#Configure load balancer(console)

#Create the load balancer and configure a backend service

Go to the Load balancing page in the Google Cloud Platform Console. 
GO TO THE LOAD BALANCING PAGE
Click Create load balancer.
Under TCP load balancing, click Start configuration.
Set Internet facing or internal only to From Internet to my VMs.
Set Multiple regions or single region to Multiple regions.

Under Connection termination, select Yes (TCP Proxy or SSL Proxy).

Click Continue.
Set the Name to bharath-tcp-lb.
Click Backend configuration.
The Name of the backend service appears as my-tcp-lb.
Set Protocol to TCP.
Under New backend, select instance group bharath-us-instancegroup1.
In the Instance group has a named port dialog, click Use existing port name.
Leave other settings as they are.
Click Add backend.
Select instance group us-ig2.
Set Port numbers to 110.
Under Health check, select Create health check.
Set the health check Name to bharath-tcp-health-check.
Set Protocol to TCP.
Set Port to 110.
Leave the other settings the same.
Click Save and continue.
Verify that there is a green check mark next to Backend configuration in the Google Cloud Platform Console. If not, double-check that you have completed all the steps above.
Configure frontend services

Click Frontend configuration.
Enter a Name of bharath-tcp-lb-forwarding-rule.
Set Protocol to TCP
Under IP, select Create IP address:
Enter a Name of tcp-lb-static-ip.
Click Reserve.
Set Port to 110.
Turn on Proxy protocol if desired.
Click Done.
Turn on Proxy protocol if desired.
Click Done.
Verify that there is a green check mark next to Frontend configuration in the Google Cloud Platform Console. If not, double-check that you have completed all the steps above.
Review and finalize

Click Review and finalize.
Double-check your settings.
Click Create.


#Test your load balancer
curl [IP_ADDRESS]:110
while true; do curl -m1 35.241.37.112:110; done

#Create another instance to test load Balancer

Name = bharath-asia-southeast-server1

REgion = asia-southeast1-b

Name= bharath-europe-north1-server1

Region = europe-north


#Try to reach individual instances
#Open the firewall to allow traffic from any source to the tagged instances.
gcloud compute firewall-rules create allow-traffic   \
    --source-ranges 0.0.0.0/0   \
    --target-tags tcp-lb    \
    --allow tcp:110


#Look up the EXTERNAL_IP address of one of the instances.
gcloud compute instances list

#Create another two instances to test your load balancer
Name = bharath-asia-southeast-server1
        bharath-europe-north1-server1
#Then access one or more of your instances directly from your browser.
curl [EXTERNAL_IP]:110
 
