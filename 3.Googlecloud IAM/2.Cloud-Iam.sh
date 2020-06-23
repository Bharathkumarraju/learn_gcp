bharathkumarraju@R77-NB193 storage % gcloud organizations  list
DISPLAY_NAME                   ID  DIRECTORY_CUSTOMER_ID
bharathkumaraju.com  429874978957
bharathkumarraju@R77-NB193 storage %


bharath@cloudshell:~ (srianjaneyam)$ gcloud beta iam list-testable-permissions //cloudresourcemanager.googleapis.com/organizations/429874978957 | head
---
name: accessapproval.requests.approve
stage: BETA
---
name: accessapproval.requests.dismiss
stage: BETA
---
name: accessapproval.requests.get
stage: BETA
---
bharath@cloudshell:~ (srianjaneyam)$



bharath@cloudshell:~ (srianjaneyam)$ gcloud beta iam list-testable-permissions //cloudresourcemanager.googleapis.com/projects/srianjaneyam | head
---
apiDisabled: true
name: accessapproval.requests.approve
stage: BETA
---
apiDisabled: true
name: accessapproval.requests.dismiss
stage: BETA
---
apiDisabled: true
