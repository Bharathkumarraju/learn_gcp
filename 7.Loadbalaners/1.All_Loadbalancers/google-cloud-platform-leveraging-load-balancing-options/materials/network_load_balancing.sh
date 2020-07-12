# create a bucket

bharath_startup_script_bucket

# to write a  new script

nano bharathstartupscript

#! /bin/bash
SERVER_ID=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/bharath-SERVER-ID -H "Metadata-Flavor: Google")
apt-get update
apt-get install -y apache2
cat <<EOF > /var/www/html/index.html
<html><body><h1>Welcome to bharathsales!</h1>
<p>The Server_Id is : $SERVER_ID</p>
</body></html>
EOF


#copy the script into bucket

gsutil cp bharathstartupscript gs://bharath_startup_script_bucket


#create instances

go to compute engine->VM instances-> create instance->

give instance name bharath-us-central-webserver1

#change the region

choose region us-central1 and zone us-central1-a

Change the machine to micro


#go to the management section

go to the Metadata

give key and value

i) key= startup-script-url      value = gs://bharath_startup_script_bucket/bharathstartupscript
ii)key= bharath-SERVER-ID           value = bharath-us-webserver1


Under Networking, populate the Tags field with bharath-network-lb-tag

Leave the default values for rest of the fields.
Click Create

Go to the first instance
Click on the create Similar option
Name =bharath-us-central-webserver2

change the metadata secon value to
key= bharath-SERVER-ID           value = bharath-us-webserver2

Go to the first instance
Click on the create Similar option
Name =bharath-us-central-webserver3

change the metadata secon value to
key= bharath-SERVER-ID           value = bharath-us-webserver3

#1 First instance
gcloud compute instances create bharath-us-central-webserver1 \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-central1-b \
  --tags network-lb-tag \
  --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>bharath-us-webserver-1</h1></body></html>' | tee /var/www/html/index.html
    EOF"
#2 Second instance
gcloud compute instances create bharath-us-central-webserver2 \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-central1-b \
  --tags network-lb-tag \
  --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>bharath-us-webserver2</h1></body></html>' | tee /var/www/html/index.html
    EOF"
#3 Third instance
gcloud compute instances create bharath-us-central-webserver3 \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-central1-b \
  --tags network-lb-tag \
  --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>bharath-us-webserver3</h1></body></html>' | tee /var/www/html/index.html
    EOF"

#Create a firewall rule to allow external traffic to these VM instances
gcloud compute firewall-rules create bharath-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80

#Get the external IP addresses of your instances and verify that they are running
#1.List your instances to get their IP addresses from the EXTERNAL_IP column.
gcloud compute instances list
#2.Verify that each instance is running.
curl http://[IP_ADDRESS]

#Configure the load balancing service

#1.Create a static external IP address for your load balancer
gcloud compute addresses create bharath-network-lb-ip-1 \
    --region us-central1

#2.Add a legacy HTTP health check resource
gcloud compute http-health-checks create bharath-health-check

#3.Add a target pool
gcloud compute target-pools create bharath-target-pool \
    --region us-central1 --http-health-check bharath-health-check

#4.Add your instances to the target pool
gcloud compute target-pools add-instances bharath-target-pool \
    --instances bharath-us-central-webserver1,bharath-us-central-webserver2,bharath-us-central-webserver3 \
    --instances-zone us-central1-a

#5.Add a forwarding rule
gcloud compute forwarding-rules create bharath-forward-rule \
    --region us-central1 \
    --ports 80 \
    --address bharath-network-lb-ip-1 \
    --target-pool bharath-target-pool

#Send traffic to your instances
#Look up the forwarding rule's external IP address
gcloud compute forwarding-rules describe bharath-forward-rule --region us-central1


#Use the curl command to access the external IP address
while true; do curl -m1 35.184.227.68; done

