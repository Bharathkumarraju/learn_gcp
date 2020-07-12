#Configuring instances
#(By using console)
#1 Go to the VM instances page in the Google Cloud Platform Console.

Click Create instance.
Set the Name to bharath-us-webserver1
Set the region =us-central-1
Set the Zone to us-central1-a.
Change the machine type to micro
#allow the HTTP traffic by setting the firewall rule
Add HTTP traffic 
Click Management, Security, Disks, Networking, Sole Tenancy to to reveal advanced settings.
Click Management and set the Startup script to the following
	sudo apt-get update
	sudo apt-get install apache2 -y
	sudo a2ensite default-ssl
	sudo a2enmod ssl
	sudo service apache2 restart
	echo '<!doctype html><html><body><h1>bharath-us-webserver1</h1></body></html>' | sudo tee /var/www/html/index.html

Leave the default values for rest of the fields.
Add network tags as http-tag

Click Create.

#create the second instance for same zone using gcloud

gcloud compute instances create bharath-us-webserver2 \
--image-family debian-9 \
--image-project debian-cloud \
--zone us-central1-a \
--tags http-tag \
--metadata startup-script="#! /bin/bash
	sudo apt-get update
	sudo apt-get install apache2 -y
	sudo service apache2 restart
	echo '<!doctype html><html><body><h1>bharath-us-webserver2</h1></body></html>' | tee /var/www/html/index.html
	EOF"

Select the instance and edit the instance to allow the HTTP traffic 
Add HTTP traffic 


#create the third instance for europe zone using gcloud

Click Create instance.
Set the Name to bharath-europe-webserver1
Set the region = europe-west-1
Set the Zone to europe-west-1-b.
Change the machine type to micro
#allow the HTTP traffic by setting the firewall rule
Add HTTP traffic 
Click Management, Security, Disks, Networking, Sole Tenancy to to reveal advanced settings.
Click Management and set the Startup script to the following
	sudo apt-get update
	sudo apt-get install apache2 -y
	sudo a2ensite default-ssl
	sudo a2enmod ssl
	sudo service apache2 restart
	echo '<!doctype html><html><body><h1>bharath-europe-server1</h1></body></html>' | sudo tee /var/www/html/index.html

#create the fourt instance for europe zone using gcloud
 Go to the bharath-europe-webserver1
 Click on the CREATE SIMILAR option
 Change the name to bharath-europe-webserver2
Click Management, Security, Disks, Networking, Sole Tenancy to to reveal advanced settings
Change the startup script by just change the page name to bharath-europe-webserver2 leave remaining thing as it is


#Next, create a firewall rule to allow external traffic to your virtual machine instances. 
#From console
Go to VPC network->Firewall rules
Click Create firewall rule.
Set the Name to bharath-external-traffic
Leave the network as default.
Under Targets, select Specified target tags.
Populate the Target tags field with  http-tag
Set the Source IP Ranges field to 0.0.0.0/0.
Set Protocols and ports to For HTTP between the load balancer and the backends, use tcp:80.
Click Create.

#using gcloud
gcloud compute firewall-rules create bharath-external-traffic \
    --target-tags http-tag --allow tcp:80

#Verify that your instances are running(BY USING CONSOLE)
Go to the VM instances page in the GCP Console.
Copy an instances External IP and paste it into a browser.
#Verify that your instances are running(using gcloud)
#1List your instances to get their IP addresses from the EXTERNAL_IP column.
gcloud compute instances list

#2Run curl for each instance to confirm that they respond.
curl http://IP_ADDRESS

#Configuring services needed by the load balancing service
#Create IPv4  global static external IP addresses for your load balancer.
Go to the External IP addresses page in the GCP Console
Click Reserve static address to reserve an IPv4 address.
Set the Name to bharath-static-external-ipv4.
Leave the Type set to Global
Click Reserve

##Create IPv4  global static external IP addresses for your load balancer.(by using gcloud)
gcloud compute addresses create bharath-static-external-ip \
    --ip-version=IPV4 \
    --global

#Create an instance group for each of your zones.(using console)
Go to the Instance groups page in the GCP Console
Click Create instance group.
Set the Name to bharath-us-instancegroup for HTTP
Set the Zone to us-central1-a.
Under Group type, select Unmanaged instance group.
Select a Network and a Subnetwork.
Under VM instances, select one of the following:
bharath-us-webserver-1 and create bharath-us-webserver-2
Leave the other settings as they are.
Click Create.


#Create an instance group for each of your zones.(using gcloud)
gcloud compute instance-groups unmanaged create bharath-europe-instancegroup --zone europe-west1-b

#Add the instances you created earlier to the instance groups.

gcloud compute instance-groups unmanaged add-instances bharath-europe-instancegroup \
    --instances bharath-europe-webserver1,bharath-europe-webserver2 \
    --zone europe-west1-b


#Configuring the load balancing service

#Starting the load balancer configuration
Go to the Create load balancer. page in the GCP Console
Under HTTP(S) load balancing, click Start configuration.
For the Name of the load balancer, enter bharath-web-map.

#Backend configuration
In the left panel of the New HTTP(S) load balancer page, click Backend configuration.
In the Create or select backend services & backend buckets pull-down menu, select Backend services, then Create a backend service. You see the Create Backend Service dialog box.
Set the Name of the backend service to bharath-web-map-backend-service.
#Set the Protocol.
For HTTP protocol, leave the values set to the defaults.
Under Backends, set Instance group to bharath-us-instancegroup
#Set the port number.
For HTTP traffic between the load balancer and the instances, leave Port numbers at 80.
Leave the default values for rest of the fields.
Click Add backend.
Select the bharath-europe-instancegroup
For HTTP traffic between the load balancer and the instances, leave Port numbers at 80.
Leave the default values for rest of the fields.
Click Done.
Under Health check, select Create a health check or Create another health check.
	a)If you are creating an HTTP health check, set the following health check parameters:
		Name to bharath-http-basic-check
		Protocol to HTTP
		Port to 80

Click Create.

#Host and path rules
For this example, we donot need to configure any host or path rules since all traffic will go to the default rule.

#Frontend configuration
In the left panel of the New HTTP(S) load balancer page, click Frontend configuration.
Set Name to bharath-http-frontend-rule.
Set the Protocol.
	Select HTTP if you want HTTP between the client and the load balancer.
Set IP version to IPv4.
In the IP address field, select bharath-static-external-ipv4, which you created earlier.
Leave Port at 80 if you are using HTTP
Click Done.
#Review and finalize
In the left panel of the New HTTP(S) load balancer page, click Review and finalize.
Compare your settings to what you intended to create.
If the settings are correct, click Create.




#Sending traffic to your instances

Go to the Load balancing page in the GCP Console. 
Click on load balancer named bharath-web-map to expand the load balancer you just created.
In the Backend section of the page, confirm that instances are healthy by checking the Healthy column. It can take a few moments for the display to indicate that the instances are healthy.
Once the display shows that the instances are healthy, copy the IP:Port from the Frontend section and paste that into your browser.
In your browser you should see your default content page displayed. 

while true;do curl 35.241.37.112:80;done


Due to the geographical  issue we are getting only the response from the us instances to get the response from europe we stop the us instances and then try to now we can get the response
