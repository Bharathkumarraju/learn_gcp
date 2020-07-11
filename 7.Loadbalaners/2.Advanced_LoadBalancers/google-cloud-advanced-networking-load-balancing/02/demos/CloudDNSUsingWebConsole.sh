#Enable the APIs
Go to the APIs & services
			Click on the Dashboard
			Go on the Enable APIs and services
			Go to Google cloud DNS APIs


#Create an instance
	Name = spikey-webserver-instance
	zone = us-central1-b
	Machine = micro
Allow the HTTP traffic

Go to the management,disk
	 Go to the disk
	 uncheck the box of delete boot disk when instance is deleted
startup-script=
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>Spikey Home Page</h1></body></html>' | sudo tee /var/www/html/index.html
In the network give a network tag - 
	  http-tag
Click Create

#create a firewall rule using console

go to the VPC network
then select firewall-rules option
click create firewall rule
Give name of the firewall spikey-firewall
leave the network as default
specify the target so that traffic can trasfer to that tag
for my case it should be http-tag
specify the source filter to IP ranges
then change the source IP range to 0.0.0.0/0
then select the specified protocols to tcp and prots to 80
then hit the create option

Go back to the instance Page
Click on the external IP address
check the homepage is available or Not

Delete the instance
Go to the disks
Check that the instance is present over there or not

#Create custom image out of it
	Create a image
		name = spikey-webserver-image
		sourcedisk = spikey-webserver-instance

#Create an instance template using this custom image

Go to the instance page -> create a new instance template
	name= spikey-webserver-template
	machine = micro
	boot-disk = spikey-webserver-image
	allow both HTTPS and HTTP traffic

#create a Health check
name = spikey-webserver-health-check
protocol = HTTP
Port = 80
Check-interval = 5
Timeout = 5
Healthy threshold =2
Unhealthy threshold =2


#Create a Firewall Rule
name = spikey-webserver-firewall-rule
Network = default
Add target tags = http-tag
Source Filter = IP ranges
Source IP ranges = 130.211.0.0/22 and 35.191.0.0/16
protocols and ports, 
Specified protocols and ports
tcp:80

#Create an instance group
 Go to the instance group
 	name= spikey-us-webserver-instancegroup
 	location = multizone
 	region = us-central
 	instance-templet=spikey-webserver-template
 	Autoscale =on
 	Maximum instances = 5

 	create a new health-check = spikey-webserver-health-check
 	delay = 60


#Create a load balancer
Create a load balancer
	type = HTTP load balancer
	name = spikey-webserver-lb

	Backend configuration
		name= spikey-webserver-backend
		instance group = spikey-us-webserver-instancegroup
		health-check = spikey-webserver-health-check

	Add host and path rules:
		hosts= spikeysales.com
		paths = /*
		Backends = spikey-webserver-backend

	Frontend configuration
		name = spikey-webserver-frontend
create


#Creating cloud DNS managed zone from console

Go to cloud DNS page
Click create zone
	Zone type = public
	Zone name =	spikeysales-us-managed-zone
	DNS name= spikeysales.com
	Description =spikeysales-us-public-zone
Create

In the GCP Console, select Navigation menu (mainmenu.png), click Storage > Browser.
Click Create bucket.
Create public bucket and Specify values for the following fields, leave all others at their defaults:
	Name = spikeysales-accessories
	zone = us-central1-a
Click Create

Change the TTl to 300sec for NS and SOA

Add an A record:

Go to the Add record set
	Resource record Type: A
	TTl =5 mins
	ip address: Load balancer IP

hit the create option


#Upload the nameserver names to the spikeysales.com domain on the godaddy website

Go to the godaddy website:https://sso.godaddy.com/?realm=idp&path=%2Fproducts&app=account

Give the credential and sign in 

Click on the DNS option for spikeysales.com domain

Copy the registrar setup from the managed zone

Go back to the godaddy page 

change the Choose your new nameserver type to custom

copy all the nameserver names

save the changes

hit the spikeysales.com domain from the new tab

Check the home page is coming or not




