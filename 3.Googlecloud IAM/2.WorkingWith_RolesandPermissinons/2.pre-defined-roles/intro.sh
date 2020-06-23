bharath@cloudshell:~ (srianjaneyam)$ gcloud projects  get-iam-policy srianjaneyam --format json
{
  "bindings": [
    {
      "members": [
        "user:roopa@bharathkumaraju.com"
      ],
      "role": "roles/compute.admin"
    },
    {
      "members": [
        "serviceAccount:service-202016682554@compute-system.iam.gserviceaccount.com"
      ],
      "role": "roles/compute.serviceAgent"
    },
    {
      "members": [
        "serviceAccount:202016682554-compute@developer.gserviceaccount.com",
        "serviceAccount:202016682554@cloudservices.gserviceaccount.com",
        "user:roopa@bharathkumaraju.com"
      ],
      "role": "roles/editor"
    },
    {
      "members": [
        "user:bharath@bharathkumaraju.com"
      ],
      "role": "roles/owner"
    },
    {
      "members": [
        "user:roopa@bharathkumaraju.com"
      ],
      "role": "roles/storage.objectViewer"
    }
  ],
  "etag": "BwWoupFcKpc=",
  "version": 1
}
bharath@cloudshell:~ (srianjaneyam)$

bharath@cloudshell:~ (srianjaneyam)$ gcloud projects  get-iam-policy srianjaneyam --format yaml
bindings:
- members:
  - user:roopa@bharathkumaraju.com
  role: roles/compute.admin
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
  - user:roopa@bharathkumaraju.com
  role: roles/storage.objectViewer
etag: BwWoupFcKpc=
version: 1
bharath@cloudshell:~ (srianjaneyam)$


bharath@cloudshell:~ (srianjaneyam)$ gcloud projects  set-iam-policy srianjaneyam ~/policies.yml
Updated IAM policy for project [srianjaneyam].
bindings:
- members:
  - user:roopa@bharathkumaraju.com
  role: roles/compute.admin
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
  role: roles/storage.objectCreator
- members:
  - user:hyma@bharathkumaraju.com
  - user:roopa@bharathkumaraju.com
  role: roles/storage.objectViewer
etag: BwWourrtvL0=
version: 1
bharath@cloudshell:~ (srianjaneyam)$