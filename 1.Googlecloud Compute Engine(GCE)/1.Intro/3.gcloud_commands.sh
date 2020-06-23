gcloud config set account `ACCOUNT`

gcloud config set project PROJECT_ID

preemptible instances or sopt instances of AWS.



gcloud beta compute --project=srianjaneyam instances create bkr-preemptible-instance --zone=us-central1-f --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM --no-restart-on-failure --maintenance-policy=TERMINATE --preemptible --service-account=202016682554-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server,https-server --image=debian-10-buster-v20200618 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=bkr-preemptible-instance --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any