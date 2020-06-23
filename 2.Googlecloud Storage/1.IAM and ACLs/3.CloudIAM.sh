RBAC:
users are assigned to roles...
and roles have explicit permissions enabled.
permissions are not directly given to users.

ACL:
when you directly assign permisions to users i.e. ACL-based access control.


when you have multiple users and multiple applications RBAC much easier to manage.

ACL is only the gcs buckets and objects.

ACL --> permision and scope

Cloud IAM:
1. Project level
2. Bucket level

Access Control Lists:
1. for individual objects


bharathkumarraju@R77-NB193 storage % gsutil iam ch allUsers:objectViewer gs://bharathraju-temp-data/
bharathkumarraju@R77-NB193 storage %


bharathkumarraju@R77-NB193 storage % gsutil iam ch user:bharath@gmail.com:objectCreator gs://bharathraju-temp-data/
bharathkumarraju@R77-NB193 storage %

acl is for object level permissions

bharathkumarraju@R77-NB193 storage % gsutil iam ch -u roopa@gmail.com:R gs://bharathraju-temp-data/anji.jpg
bharathkumarraju@R77-NB193 storage %


bharathkumarraju@R77-NB193 storage % gsutil iam ch -g all@gmail.com:R gs://bharathraju-temp-data/rama.jpg
bharathkumarraju@R77-NB193 storage %

