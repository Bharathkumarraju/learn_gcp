#Migrating to Cloud DNS
#Create a managed zone
gcloud dns managed-zones create --dns-name="spikeysales.com." --description="spikeysales-europe-public-zone" "spikeysales-europe-managed-zone"

#Export your DNS configuration from your existing provider
gcloud dns record-sets export spikeysales.zone -z=spikeysales-us-managed-zone \
   --zone-file-format

#Import the record set

gcloud dns record-sets import -z=spikeysales-europe-managed-zone \
  --delete-all-existing \
  --zone-file-format spikeysales.zone

#Verify DNS propagation

Look up your zone Cloud DNS name servers:
gcloud dns managed-zones describe spikeysales-europe-managed-zone


Update your registrar name server records

Delete the spikeysales-us-managed-zone

Hit the spikeysales.com and see that the spikeysales page is accessible or not

#Wait for changes, then verify

dig +short NS spikysales.com



bharathkumarraju@R77-NB193 external % dig +short NS google.com
ns1.google.com.
ns3.google.com.
ns4.google.com.
ns2.google.com.

bharathkumarraju@R77-NB193 external % dig +short NS ntucenterprise.sg
ns-1518.awsdns-61.org.
ns-1561.awsdns-03.co.uk.
ns-177.awsdns-22.com.
ns-929.awsdns-52.net.
bharathkumarraju@R77-NB193 external % dig +short NS hooq.tv
dns1.p07.nsone.net.
dns2.p07.nsone.net.
dns3.p07.nsone.net.
dns4.p07.nsone.net.

bharathkumarraju@R77-NB193 external % dig +short NS singaporeair.com
eur4.akam.net.
usc2.akam.net.
ns1-115.akam.net.
usw1.akam.net.
eur5.akam.net.
eur6.akam.net.
use2.akam.net.
ns1-83.akam.net.
bharathkumarraju@R77-NB193 external %