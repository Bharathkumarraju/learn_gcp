Primitive roles:
OWNER
EDITOR
VIEWER


How to add viewer role to the project

bharath@cloudshell:~ (srianjaneyam)$ gcloud projects add-iam-policy-binding srianjaneyam --member user:hyma@bharathkumaraju.com --role roles/viewer
Updated IAM policy for project [srianjaneyam].
bindings:
- members:
  - serviceAccount:service-202016682554@compute-system.iam.gserviceaccount.com
  role: roles/compute.serviceAgent
- members:
  - serviceAccount:202016682554-compute@developer.gserviceaccount.com
  - serviceAccount:202016682554@cloudservices.gserviceaccount.com
  - user:roopa@bharathkumaraju.com
  role: roles/editor
- members:
  - user:bharath@bharathkumaraju.com
  role: roles/owner
- members:
  - user:hyma@bharathkumaraju.com
  role: roles/viewer
etag: BwWouljX0C4=
version: 1
bharath@cloudshell:~ (srianjaneyam)$

How to remove a role to the member.

gcloud projects remove-iam-policy-binding srianjaneyam --member user:hyma@bharathkumaraju.com --role roles/viewer



bharath@cloudshell:~ (srianjaneyam)$ gcloud projects remove-iam-policy-binding srianjaneyam --member user:hyma@bharathkumaraju.com --role roles/viewer
Updated IAM policy for project [srianjaneyam].
bindings:
- members:
  - serviceAccount:service-202016682554@compute-system.iam.gserviceaccount.com
  role: roles/compute.serviceAgent
- members:
  - serviceAccount:202016682554-compute@developer.gserviceaccount.com
  - serviceAccount:202016682554@cloudservices.gserviceaccount.com
  - user:roopa@bharathkumaraju.com
  role: roles/editor
- members:
  - user:bharath@bharathkumaraju.com
  role: roles/owner
etag: BwWoumPhs8w=
version: 1
bharath@cloudshell:~ (srianjaneyam)$


