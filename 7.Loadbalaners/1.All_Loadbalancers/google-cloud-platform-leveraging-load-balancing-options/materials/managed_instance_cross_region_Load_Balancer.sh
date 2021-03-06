#Create an instance

Go to the compute engine -> VM instances ->
	Name = bharath-webserver-instance
	zone = us-central1-b
	Machine = micro
Allow both the HTTP and HTTPS traffic

Go to the management,disk
	 Go to the disk
	 uncheck the box of delete boot disk when instance is deleted
Create

#Install apache2 webserver on this instance
SSH into the host
#Run an app to get update
	sudo apt-get update
#Install apache2
	sudo apt-get install -y apache2
#Restart apache2
	sudo service apache2 start

#Check whether the apache2 home page is accessable or not
Go to instance -> copy the url -> open it from new tab

Delete the instance
Go to the disks
Check wheter the instance is present over there or not


#Create custom image out of it
	Create a image
		name = bharath-webserver-image
		sourcedisk = bharath-webserver-instance

#Create an instance template using this custom image

Go to the instance page -> create a new instance template
	name= bharath-webserver-template
	machine = micro
	boot-disk = bharath-webserver-image
	allow both HTTPS and HTTP traffic


#create a Health check
name = bharath-webserver-health-check
protocol = HTTP
Port = 80
Check-interval = 5
Timeout = 5
Healthy threshold =2
Unhealthy threshold =2

#Create a Firewall Rule
name = bharath-webserver-firewall-rule
Network = default
Add target tags = http-tag
Source Filter = IP ranges
Source IP ranges = 130.211.0.0/22 and 35.191.0.0/16
protocols and ports, 
Specified protocols and ports
tcp:80



#Create an instance group
 Go to the instance group
 	name= bharath-us-webserver-instancegroup
 	location = multizone
 	region = us-central
 	instance-templet=bharath-webserver-template
 	Autoscale =on
 	Maximum instances = 5

 	create a new health-check = bharath-webserver-health-check
 	delay = 60

#Create 2nd Instance group
 Go to the instance group
 	name= bharath-europe-webserver-instancegroup
 	location = multizone
 	region = europe-north
 	instance-templet=-bharath-webserver-template
 	Autoscale =on
 	Maximum instances = 5

 	create a new health-check = bharath-webserver-health-check
 	delay = 60

Copy the link and check in a new tab

#Create a load balancer
Create a load balancer
	type = HTTP load balancer
	name = bharath-webserver-lb
	Frontend configuration
		name = bharath-webserver-frontend
	Backend configuration
		name= bharath-webserver-backend
		instance group = bharath-us-webserver-instancegroup
						 bharath-europe-webserver-instancegroup
		health-check = bharath-webserver-health-check
create

check whether the instance group is up or not
Heat the IP address of Frontend

#Add traffic in the Load balancer

Create an instance
	name=bharath-traffic-test
	zone=us-central1-c
	machine-type= micro
	boot-disk= asian-1
	Allow both HTTP and HTTPS

Go to the terminal use the apache2 benchmark tool
	ab -n 500000 -c 1000 http://35.244.193.195/

Go to the console
Go to the instance group
Go to the Monitoring




















