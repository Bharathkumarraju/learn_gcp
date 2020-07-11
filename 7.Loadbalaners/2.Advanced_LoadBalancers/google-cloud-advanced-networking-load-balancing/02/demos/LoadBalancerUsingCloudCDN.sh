create a bucket
	Name = spikeysales-accessories-bucket
	zone = us-central1-a
	Default storage class = Regional
Click Create.

#Create a folder
Click on the create a folder
	Name= music-system

#Copy an image file into your bucket
Upload the images from the system

In the Console, click Refresh Bucket to verify that the image was copied.


#Publish Cloud Storage image file to the web
gsutil acl ch -u AllUsers:R gs://spikeysales-accessories-bucket/music-system/ipod.jpg
gsutil acl ch -u AllUsers:R gs://spikeysales-accessories-bucket/music-system/ipod-touch.jpg
gsutil acl ch -u AllUsers:R gs://spikeysales-accessories-bucket/music-system/black-and-white-brand-data.jpg
gsutil acl ch -u AllUsers:R gs://spikeysales-accessories-bucket/music-system/analogue-blur-classic.jpg
gsutil acl ch -u AllUsers:R gs://spikeysales-accessories-bucket/music-system/music-retro-turntable.jpg


Refresh your bucket again, then click Public Link under Publick access to verify that you can access the image


#Create the HTTP Load Balancer with Cloud CDN
#Start the HTTP Load Balancer Configuration
In the GCP Console, select Navigation menu (mainmenu.png) > Network Services > Load balancing, and click Create load balancer.
Under HTTP(S) Load Balancing, click Start configuration.
Set Name to spikeysales-accessories-lb
#Configure the backend
Click on Backend configuration.
For Backend services & backend buckets, click Create or select backend services & backend buckets, then click Backend buckets, and then click Create a backend bucket.
Give backend bucket name as spikeysales-accessories-lb-backend
Set the Name to spikeysales-product-bucket
Click Browse under Cloud Storage bucket.
Select your bucket and click Select.
Check Enable Cloud CDN.
Click Create.
#Configure the frontend
Click Frontend configuration
Specify the following, leave all other values with their defaults:

	Property	Value (type value or select option as specified)
	Name        spikeysales-accessories-lb-forwarding-rules
	Protocol	HTTP
	IP version	IPv4
	IP address	Ephemeral
	Port	80

Click Done.

#Review and create the HTTP Load Balancer
Click Review and finalize.

Review the Backend Buckets and Frontend.
Click Create.

Wait for the load balancer to be created.

Click on the name of the load balancer spikey-us-cdn-lb

Note the IP address of the load balancer for the next task

#Verify the caching of your bucket's content
In Cloud Shell command line, store the IP address of the Load Balancer in an environment variable:
	

Run the following to time 6 consecutive HTTP requests:
	for i in {1..3};do curl -s -w "%{time_total}\n" -o /dev/null http://35.227.230.172/music-systems/black-and-white-brand-data.jpg; done
	for i in {1..10};do curl -s -w "%{time_total}\n" -o /dev/null http://35.227.230.172/music-systems/analogue-blur-classic.jpg; done
	for i in {1..3};do curl -s -w "%{time_total}\n" -o /dev/null http://35.227.230.172/music-systems/music-retro-turntable.jpg; done
	for i in {1..3};do curl -s -w "%{time_total}\n" -o /dev/null http://35.227.230.172/music-systems/ipod.jpg; done
	for i in {1..3};do curl -s -w "%{time_total}\n" -o /dev/null http://35.227.230.172/music-systems/ipod-touch.jpg; done

Repeat the command a few times to provide logs.

#Explore the Cloud CDN logs
In the Console, select Navigation menu (mainmenu.png) > Logging > Logs.
Under the Resources filter, select Cloud HTTP Load Balancer > spikey-cdn-lb-forwarding-rule > spikey-us-cdn-lb

Expand the first log entry (on top)
Within the entry, expand the httpRequest and notice that the cacheLookup is true but there is no cacheHit field.
	This illustrates that the cache did not contain the image on this first request.
Expand the jsonPayload and notice that the statusDetails field contains response_sent_by_backend.
	This also illustrates that the image came from the backend bucket on this first request.
Close the current log entry and expand a different log entry.
Within the entry, expand the httpRequest and notice that the cacheHit is true.
	This illustrates that the cache contained the image on this request.
Expand the jsonPayload and notice that the statusDetails field contains response_from_cache.
	This also illustrates that the cache provided the image on this request, instead of the backend.


#To invalidate just one file
Go to the Cloud CDN page in the Google Cloud Platform Console. 
Click on the origin name of the relevant origin.
Click Cache invalidation.
Enter the path to the file.
	i)If you want to invalidate a path for all hostnames, enter just the path. (Ex: /music-system/ipod.jpg)
Click Invalidate.

#To invalidate the whole directory:
Go to the Cloud CDN page in the Google Cloud Platform Console
Click on the origin name of the relevant origin.
Click Cache invalidation
Enter the directory path and wildcard:
	i)If you want to invalidate the whole directory for all hostnames, enter just the path and wildcard. (Ex: /music-system/*)

Click Invalidate.


bharathkumarraju@R77-NB193 external % for i in {1..5};do curl -s -w "%{time_total}\n" -o /dev/null https://apple.com; done
1.288857
0.835002
0.986192
0.943412
0.850016
bharathkumarraju@R77-NB193 external %