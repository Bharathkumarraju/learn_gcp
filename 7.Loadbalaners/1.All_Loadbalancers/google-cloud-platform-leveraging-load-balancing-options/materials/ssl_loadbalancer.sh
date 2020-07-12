

#Configure instances
Go to the VM instances page in the Google Cloud Platform Console. 
Click Create instance.
Set Name to bharath-us-central1-webserver1.
Set the Zone to us-central1-b.
Change the machine type to micro
Click Management, security, disks, networking, sole tenancy to reveal advanced settings.
Under Management, click Networking and populate the Tags field with bharath-lb.
Leave the default values for rest of the fields.
Click Management and set the Startup script to
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>bharath-us-central-server1</h1></body></html>' | sudo tee /var/www/html/index.html

Click on the First instance
Then click Create Similar 
Change the instance name as bharath-us-central1-webserver2
In Startup script change the page text as bharath-us-central-server2
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>bharath-us-central-server2</h1></body></html>' | sudo tee /var/www/html/index.html


Create bharath-us-west1-webserver1 with the same settings, except with Zone set to us-west-b
Change the machine type to micro and Startup script set to
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>bharath-us-west1-server1</h1></body></html>' | sudo tee /var/www/html/index.html
Under Management, click Networking and populate the Tags field with bharath-lb.

Create bharath-us-west1-webserver2 with the same settings, except with Zone set to us-west-b
Change the machine type to micro and Startup script set to
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo service apache2 restart
echo '<!doctype html><html><body><h1>bharath-us-west1-server2</h1></body></html>' | sudo tee /var/www/html/index.html
Under Management, click Networking and populate the Tags field with bharath-lb.

#Create an instance group for each zone and add instances
Click Create instance group.
Set the Name to bharath-us-instancegroup1 bharath-us-instancegroup-1
Set the Zone to us-central1-b
Add port name =bharath-lb port = 443
Under Group type, select Unmanaged instance group.
Set Network to bharath-custom-network.
From VM instances select bharath-us-central1-1 and bharath-us-central1-2
Leave other settings as they are.
Click Create.
Repeat steps, but set the following:
Name: bharath-us-instancegroup2
Zone: us-west-b
Instances: bharath-us-central1-3 and bharath-us-central1-4.
Confirm that you now have two instance groups, each with two instances.

#Configure the load balancer
Go to the Load balancing page in the Google Cloud Platform Console. 
Click Create load balancer.
Under SSL load balancing, click Start configuration.
Under Internet facing or internal only select From the internet to my VM
Select multiregions
yes tcp proxy
Set the Name to bharath-ssl-lb.

#Configure backend services
Click Backend configuration.
Set protocol to ssl
Named port= bharath-lb
Select the first instance group
port number=443
Add second instance group and add port 443

#Under Health check, select Create another health check.
Set the health check Name to bharath-ssl-health-check.
Set Protocol to SSl.
Leave the other settings the same.
Click Save and continue.


#Creating a self-signed certificate
https://www.akadia.com/services/ssh_test_certificate.html

openssl genrsa -des3 -out bharath-server.key 2048
openssl req -new -key bharath-server.key -out bharath-server.csr
cp bharath-server.key bharath-server.key.org
openssl rsa -in bharath-server.key.org -out bharath-server.key
openssl x509 -req -days 365 -in bharath-server.csr -signkey bharath-server.key -out bharath-server.crt


#Configure frontend services
Click Frontend configuration.
name = bharath-ssl-lb-forwarding-rule
Set the IP address we want
Set Ports to 443
Under IP address, select Create IP address.
	Enter a Name of bharath-ssl-static-ip.
	Click Reserve.
Add self signed certificate
name= bharath-sssc

Click Add frontend IP and port.
Enter a Name of bharath-ssl-lb-ipv6-forwarding-rule
Set IP version to IPv6.
Under IP address, select Create IP address.
Enter a Name of bharath-ssl-lb-static-ipv6.
Click Reserve.
Under Certificate, select bharath-ssc.
Click Done.

Go to the Firewall rules page in the Google Cloud Platform Console
Click Create firewall rule.
Enter a Name of allow-bharath-ssl-lb-and-health.
Under Network, select default.
Under Targets, select Specified target tags.
Set Target tags to ssl-lb.
Set Source filter to IP ranges.
Set Source IP ranges to 130.211.0.0/22 and 35.191.0.0/16.
Set Allowed protocols and ports to tcp:443.
Click Create.

#Test your load balancer
Copy the IP address from the Frontend
open it using https:// in the new tab