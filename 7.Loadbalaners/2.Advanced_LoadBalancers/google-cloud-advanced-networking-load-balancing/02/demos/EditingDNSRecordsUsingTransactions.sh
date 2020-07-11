Go to the storage section from navigation window
Select the browser option
open the bucket named as spikeysales-accessories-bucket
open the folder music-system
open the pictures from the bucket

Go back to the load balancer created in previous demo

Click on the edit option

Go to the backend configuration section
Add one backend bucket 
	backend buckets->create a backend bucket->name= spikey-us-lb-backend->choose the bucket->create
Edit the host and path rules too
	Host:product.spikeysales.com
	paths:/music-system/*
	Backends:spikey-us-lb-backend

second host and path rules
	Host: *
	paths:/music-system/*
	Backends:spikey-us-lb-backend

Review the changes and hit the update option

Hit the external load balancer IP address/music-system/photos name to check the changes are updated in load balancer or not

#Creating managed zones(Using gcloud)
#Create a managed zone
gcloud dns managed-zones create --dns-name="spikeysales.com." --description="spikeysales-us-public-zone" "spikeysales-us-managed-zone"

Change the TTL for NS and SOA to 5 mins


#Listing managed zones
gcloud dns managed-zones list



#Adding or removing records in a record set using transactions
1.Start a transaction by running the start command:
	gcloud dns record-sets transaction start -z=spikeysales-us-managed-zone
	#Whenever you run the start command, Cloud DNS creates a local file in YAML format called transaction.yaml

2.Run transaction commands to add or remove DNS records.
	gcloud dns record-sets transaction add -z=spikeysales-us-managed-zone \
	   --name="spikeysales.com." \
	   --type=A \
	   --ttl=300 "35.244.245.125"


    gcloud dns record-sets transaction add -z=spikeysales-europe-zone \
   --name="www.spikeysales.com." \
   --type=A \
   --ttl=300 "35.244.245.125"

#To replace an existing record, issue a remove command followed by an add command. For example:

gcloud dns record-sets transaction remove -z=spikeysales-europe-zone \
    --name="www.spikeysales.com." \
    --type=A \
   --ttl=300 "35.244.245.125"


gcloud dns record-sets transaction remove -z=spikeysales-europe-zone \
    --name="product.spikeysales.com." \
    --type=A \
   --ttl=300 "35.244.245.125"


cat transaction.yaml

3.When you are finished running the transaction commands, execute the transaction by running the execute command.

gcloud dns record-sets transaction execute -z=spikeysales-us-managed-zone 

cat transaction.yaml

#Displaying the current record set
gcloud dns record-sets list --zone=spikeysales-us-managed-zone


Go to the godaddy page

Sign in 

Change the your_zone_nameserver

check whether the pictures are accesseble or not by hiting the spikeysales.com/music-system/picturenames

