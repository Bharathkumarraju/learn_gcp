
gcloud beta compute security-policies create block-malicious-ip-ranges \
--description "Block malicious traffic causing DDOS"


gcloud beta compute security-policies rules create 1000 \
   --security-policy block-malicious-ip-ranges \
   --description "Deny traffic from 192.0.0/24" \
   --src-ip-ranges "192.0.0.0/24" \
   --action "deny-404"


gcloud beta compute security-policies describe block-malicious-ip-ranges


gcloud beta compute security-policies list


gcloud beta compute security-policies rules delete 1000 \
 --security-policy block-malicious-ip-ranges

gcloud beta compute security-policies rules delete 2147483647 \
 --security-policy block-malicious-ip-ranges





configure firewall:
------------------->

firewall1: allow-http-traffic:

firewall2: allow-health-check

use google managed ips:  130.211.0.0/22 and 35.191.0.0/16






