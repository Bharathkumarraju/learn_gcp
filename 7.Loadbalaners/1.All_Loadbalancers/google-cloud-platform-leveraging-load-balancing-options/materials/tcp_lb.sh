#Create spikey-us-central1-server1 in zone us-central1-b
gcloud compute instances create spikey-us-central1-server1 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-central1-b \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-central1-1</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create spikey-us-central1-server2 in zone us-central1-b
gcloud compute instances create spikey-us-central1-server2 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-central1-b \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-central1-2</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create spikey-us-east1-server1 in zone us-east1-b
gcloud compute instances create spikey-us-east1-server1 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-east1-b \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-east1-1</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create spikey-us-east1-server2 in zone us-east1-b
gcloud compute instances create spikey-us-east1-server2 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags tcp-lb \
    --zone us-east1-b \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo sed -i '/Listen 80/c\Listen 110' /etc/apache2/ports.conf
      sudo sed -i '/\<VirtualHost *:80>/c\' /etc/apache2/sites-enabled/000-default.conf
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-east1-2</h1></body></html>' | tee /var/www/html/index.html
      EOF"

#Create an instance group for each zone and add instances
#1.Create the us-ig1 instance group.
gcloud compute instance-groups unmanaged create spikey-us-instancegroup1 \
    --zone us-central1-b

#2.Create a named port for the instance group.
gcloud compute instance-groups set-named-ports spikey-us-instancegroup1 \
    --named-ports tcp110:110 \
    --zone us-central1-b

 #3.Add  spikey-us-central1-1 and spikey-us-central1-2 to spikey-us-instancegroup-1
gcloud compute instance-groups unmanaged add-instances spikey-us-instancegroup1 \
    --instances spikey-us-central1-server1,spikey-us-central1-server2 \
    --zone us-central1-b

#4.Create the spikey-us-instancegroup2 instance group.
gcloud compute instance-groups unmanaged create spikey-us-instancegroup2 \
    --zone us-east1-b

#5.Create a named port for the instance group.
gcloud compute instance-groups set-named-ports spikey-us-instancegroup2 \
    --named-ports tcp110:110 \
    --zone us-east1-b

#6.Add spikey-us-east1-server1 and spikey-us-east1-server2 to spikey-us-instancegroup2
gcloud compute instance-groups unmanaged add-instances spikey-us-instancegroup2 \
    --instances spikey-us-east1-server1,spikey-us-east1-server2 \
    --zone us-east1-b

#7.Configure load balancer

#Create a health check
gcloud compute health-checks create tcp spikey-tcp-health-check --port 110

#Create a backend service
gcloud compute backend-services create spikey-tcp-lb \
    --global \
    --protocol TCP \
    --health-checks spikey-tcp-health-check \
    --timeout 5m \
    --port-name tcp110

#Add instance group to your backend service
gcloud compute backend-services add-backend spikey-tcp-lb \
    --global \
    --instance-group spikey-us-instancegroup1 \
    --instance-group-zone us-central1-b \
    --balancing-mode UTILIZATION \
    --max-utilization 0.8

gcloud compute backend-services add-backend spikey-tcp-lb \
    --global \
    --instance-group spikey-us-instancegroup2 \
    --instance-group-zone us-east1-b \
    --balancing-mode UTILIZATION \
    --max-utilization 0.8

#Configure a target TCP proxy
gcloud compute target-tcp-proxies create spikey-tcp-lb-target-proxy \
    --backend-service spikey-tcp-lb \
    --proxy-header NONE

#Reserve global static IPv4  addresses
gcloud compute addresses create spikey-lb-static-ipv4 \
    --ip-version=IPV4 \
    --global


#Find the IP addresses
gcloud compute addresses list 

#Configure global forwarding rules for the two addresses
gcloud beta compute forwarding-rules create spikey-tcp-lb-ipv4-forwarding-rule \
    --global \
    --target-tcp-proxy spikey-tcp-lb-target-proxy \
    --address [LB_STATIC_IPV4] \
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
Set the Name to spikey-tcp-lb.
Click Backend configuration.
The Name of the backend service appears as my-tcp-lb.
Set Protocol to TCP.
Under New backend, select instance group spikey-us-instancegroup1.
In the Instance group has a named port dialog, click Use existing port name.
Leave other settings as they are.
Click Add backend.
Select instance group us-ig2.
Set Port numbers to 110.
Under Health check, select Create health check.
Set the health check Name to spikey-tcp-health-check.
Set Protocol to TCP.
Set Port to 110.
Leave the other settings the same.
Click Save and continue.
Verify that there is a green check mark next to Backend configuration in the Google Cloud Platform Console. If not, double-check that you have completed all the steps above.
Configure frontend services

Click Frontend configuration.
Enter a Name of spikey-tcp-lb-forwarding-rule.
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

Name = spikey-asia-southeast-server1

REgion = asia-southeast1-b

Name= spikey-europe-north1-server1

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
Name = spikey-asia-southeast-server1
        spikey-europe-north1-server1
#Then access one or more of your instances directly from your browser.
curl [EXTERNAL_IP]:110
 
