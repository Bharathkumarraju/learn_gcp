
#Configure a VPC network and subnet(gcloud)
gcloud compute networks create spikey-custom-network --subnet-mode custom

#Create a new subnet in your custom VPC network
gcloud compute networks subnets create spikey-custom-subnet \
    --network spikey-custom-network \
    --range 10.128.0.0/20 \
    --region us-central1

 #Configure a VPC network and subnet(console)
Go to the VPC networks page in the Google Cloud Platform Console.
Click Create VPC network.
Enter a Name of spikey-custom-network
Under subnets, enter a Name of spikey-custom-subnet
Set Region to us-central1.
Enter an IP address range of 10.128.0.0/20
Click Create.


#Create firewall rule that allows all traffic within the subnet(gcloud)

gcloud compute firewall-rules create allow-all-traffic \
        --network spikey-custom-network \
        --allow tcp,udp,icmp \
        --source-ranges 10.128.0.0/20
        
#Create firewall rule that allows SSH, RDP, and ICMP from anywhere
gcloud compute firewall-rules create allow-tcp-icmp-traffic \
   --network spikey-custom-network \
   --allow tcp:22,tcp:3389,icmp

#Create firewall rule that allows all traffic within the subnet(console)
Go to the Firewall rules page in the Google Cloud Platform Console. 
Click Create firewall rule.
Under Targets, select All instances in the network.
Enter a Name of allow-all-trsffic-within-VPC
Set Network to spikey-custom-subnet
Set Source filter to IP ranges.
Set Source IP ranges to 10.128.0.0/20
Set Specified protocols and ports to tcp;udp;icmp.
Click Create.

#Create firewall rule that allows SSH, RDP, and ICMP from anywhere(console)

Create a second firewall rule with a Name of allow-tcp-icmp-global-traffic
Set Network to spikey-custom-network
Under Targets, select All instances in the network.
Set Source filter to IP ranges.
Set Source IP ranges to 0.0.0.0/0 (allow from any source).
Set Specified protocols and ports to tcp:22;tcp:3389;icmp.
Click Create.

#Create two instances in each zone
gcloud compute instances create spikey-us-central-server1 \
        --image-family debian-9 \
        --image-project debian-cloud \
        --tags internal-loadbalancer \
        --zone us-central1-b \
        --subnet spikey-custom-subnet \
        --metadata startup-script="#! /bin/bash
          apt-get update
          apt-get install apache2 -y
          a2ensite default-ssl
          a2enmod ssl
          service apache2 restart
          echo '<!doctype html><html><body><h1>spikey-us-central-server1</h1></body></html>' \
          | tee /var/www/html/index.html
          EOF"

gcloud compute instances create spikey-us-central-server2 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags internal-loadbalancer\
    --zone us-central1-b \
    --subnet spikey-custom-subnet \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      a2ensite default-ssl
      a2enmod ssl
      service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-central-server2</h1></body></html>' | tee /var/www/html/index.html
      EOF"

gcloud compute instances create spikey-us-central-server3 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags internal-loadbalancer \
    --zone us-central1-c \
    --subnet spikey-custom-subnet \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      a2ensite default-ssl
      a2enmod ssl
      service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-central-server3</h1></body></html>' | tee /var/www/html/index.html
      EOF"

gcloud compute instances create spikey-us-central-server4 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --tags internal-loadbalancer \
    --zone us-central1-c \
    --subnet spikey-custom-subnet \
    --metadata startup-script="#! /bin/bash
      apt-get update
      apt-get install apache2 -y
      a2ensite default-ssl
      a2enmod ssl
      service apache2 restart
      echo '<!doctype html><html><body><h1>spikey-us-central-server4</h1></body></html>' | tee /var/www/html/index.html
      EOF"


#Create instances
Go to the VM instances page in the Google Cloud Platform Console. 
Click Create instance.
Set Name to spikey-us-server1
Set the Zone to us-central1-b.
Click Management, security, disks, networking, sole tenancy to reveal advanced settings.
Under Management, click Networking and populate the Tags field with initial-loadbalancer.
Under Networking, edit the network interface under Network interfaces.
Under Networking, ​set Network to my-custom-network and Subnetwork to spikey-custom-subnet
Leave the default values for rest of the fields.
Click Management and set the Startup script to

sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>spikey-us-central-server1</h1></body></html>' | sudo tee /var/www/html/index.html

#Create spikey-us-central-server2 with the same settings, except with Startup script set to

sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>spikey-us-central-server2</h1></body></html>' | sudo tee /var/www/html/index.html

#Create spikey-us-central-server3 with the same settings, except with except with Zone set to us-central1-c and Startup script set to
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>spikey-us-central-server3</h1></body></html>' | sudo tee /var/www/html/index.html

#Create spikey-us-central-server4 with the same settings, except with except with Zone set to us-central1-c and Startup script set to

sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>spikey-us-central-server4</h1></body></html>' | sudo tee /var/www/html/index.html

#Create an instance group for each zone and add instances(gcloud)
#Create the us-ig1 instance group
gcloud compute instance-groups unmanaged create spikey-us-instancegroup1 \
    --zone us-central1-b

#Add ig-us-central1-1 and ig-us-central1-2 to us-ig1
gcloud compute instance-groups unmanaged add-instances spikey-us-instancegroup1 \
    --instances spikey-us-central-server1,spikey-us-central-server2 --zone us-central1-b

#Create the us-ig2 instance group.
gcloud compute instance-groups unmanaged create spikey-us-instancegroup2 \
    --zone us-central1-c

#Add ig-us-central1-3 and ig-us-central1-4 to us-ig2
gcloud compute instance-groups unmanaged add-instances spikey-us-instancegroup2 \
    --instances spikey-us-central-server3,spikey-us-central-server4 \
    --zone us-central1-c


#Create an instance group for each zone and add instances
Go to the Instance groups page in the Google Cloud Platform Console
Click Create instance group
Set the Name to spikey-us-instancegroup1
Set the Zone to us-central1-b.
Under Group type, select Unmanaged instance group.
Set Network to  spikey- spikey-custom-network
Set Subnetwork to spikey-custom-subnet
From VM instances select spikey-us-central-server1
Leave other settings as they are
Click Create.
Repeat steps, but set the following:
Name: spikey-us-instancegroup2
Zone: us-central1-c
instances: spikey-us-central-server3,spikey-us-central-server4
Confirm that you now have two instance groups, each with two instances


#Create a health check
gcloud compute health-checks create tcp spikey-tcp-health-check \
    --port 80
    clear

#Create a backend service
gcloud compute backend-services create spikey-internal-lb \
    --load-balancing-scheme internal \
    --region us-central1 \
    --health-checks spikey-tcp-health-check \
    --protocol tcp

#Add instance groups to your backend service
gcloud compute backend-services add-backend spikey-internal-lb \
    --instance-group spikey-us-instancegroup1 \
    --instance-group-zone us-central1-b \
    --region us-central1

gcloud compute backend-services add-backend spikey-internal-lb \
    --instance-group spikey-us-instancegroup2 \
    --instance-group-zone us-central1-c \
    --region us-central1

clear

#Create a forwarding rule
gcloud beta compute forwarding-rules create spikey-internal-lb-forwarding-rule \
    --load-balancing-scheme internal \
    --address 10.128.0.6 \
    --ports 80 \
    --network spikey-custom-network \
    --subnet spikey-custom-subnet \
    --service-label spikey-ilb-label \
    --region us-central1 \
    --backend-service spikey-internal-lb

#Configure a firewall rule to allow Internal Load Balancing
gcloud compute firewall-rules create allow-internal-lb \
   --network spikey-custom-network \
    --source-ranges 10.128.0.0/20 \
    --target-tags internal-loadbalancer \
    --allow tcp:80,tcp:443


#Configure the load balancer
Go to the Load balancing page in the Google Cloud Platform Console. 
GO TO THE LOAD BALANCING PAGE
Click Create load balancer.
Under TCP load balancing, click Start configuration.
Under Internet facing or internal only select Only between my VMs.
Click Continue
Set the Name to spikey-internal-lb.
#Configure backend services
Click Backend configuration.
The Name of the backend service appears as spikey-internal-lb
Set Region to us-central1
Set Network to spikey-custom-network
Under Backends, select instance group spikey-us-instancegroup1
Click Add backend
Select instance group spikey-us-instancegroup2
Under Health check, select Create another health check.
Set the health check Name to spikey-tcp-health-check
Set Protocol to TCP
Leave the other settings the same.
Click Save and continue.

#Configure frontend services
Click Frontend configuration.
Under Subnetwork, select spikey-custom-subnet
Under Internal IP, select Ephemeral (Automatic).
Set Ports to 80.
Verify that there is a blue check mark next to Frontend configuration in the Google Cloud Platform Console. If not, double-check that you have completed all the steps above
Review and finalize

#Click Review and finalize.
Double-check your settings.
Click Create.

#Configure a firewall rule to allow Internal Load Balancing
Go to the Firewall rules page in the Google Cloud Platform Console. 
GO TO THE FIREWALL RULES PAGE
Click Create firewall rule.
Set Name to allow-internal-lb
Set Network to spikey-custom-network
Under Targets, select Specified target tags
Set Target tags to initial-loadbalancer
Set Target tags toSet Target tags to
Set Source IP ranges to 10.128.0.0/20.
Set Specified protocols and ports to tcp:80;tcp:443
Click Create

g
#Configure another firewall rule to allow health check probes from the health checker.

gcloud compute firewall-rules create allow-health-check \
    --network spikey-custom-network \
    --source-ranges 130.211.0.0/22,35.191.0.0/16 \
    --target-tags internal-loadbalancer\
    --allow tcp

##Configure another firewall rule to allow health check probes from the health checker.
Click Create firewall rule.
Set Name to spikey-allow-health-check
Set VPC network  to spikey-custom-network
Under Targets, select Specified target tags.
Set Target tags to internal-loadbalancer
Set Source filter to IP ranges
Set Source IP ranges to 130.211.0.0/22 and 35.191.0.0/16
Set Specified protocols and ports to tcp.
Click Create

#Create a standalone client instance

gcloud compute instances create spikey-standalone-instance \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-b \
    --tags standalone \
    --subnet spikey-custom-subnet



#Create astandalone client instance
Go to the VM instances page in the Google Cloud Platform Console. 
Click Create instance.
Set Name to spikey-standalone-instance1.
Set the Zone to us-central1-b.
Click Management, security, disks, networking, sole tenancy to to reveal advanced settings.
Under Networking, populate the Networking tags field with standalone.
Under Networking, edit the network interface. Set Network to spikey-custom-network and Subnetwork to spikey-custom-subnet
Click Create.


#Delete the external IP addresses from your instances(From gcloud)

gcloud compute instances delete-access-config spikey-us-central1-1 \
    --access-config-name = "External NAT" --zone us-central1-b

gcloud compute instances delete-access-config spikey-us-central1-2 \
    --access-config-name = "External NAT" --zone us-central1-b

gcloud compute instances delete-access-config spikey-us-central1-3 \
    --access-config-name = "External NAT" --zone us-central1-c

gcloud compute instances delete-access-config spikey-us-central1-4 \
    --access-config-name = "External NAT" --zone us-central1-c

#Delete the external IP addresses from your instances(from Console)
Go to the VM instances page in the Google Cloud Platform Console
Click on spikey-us-central-server1
Click Edit.
Expand "Network interfaces". Set External IP to None.
Click Save.
Repeat for rest of the instances

#Test your load balancer

gcloud compute --project spikey-lb ssh --zone us-central1-b spikey-standalone-instance

curl 10.128.0.6
curl 10.128.0.6
curl 10.128.0.6
curl 10.128.0.6

or

while true; do curl -m1 10.128.0.6; done