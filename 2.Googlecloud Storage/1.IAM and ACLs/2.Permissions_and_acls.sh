bharathkumarraju@R77-NB193 storage % gsutil versioning get  gs://bharath-personal-data
gs://bharath-personal-data: Enabled
bharathkumarraju@R77-NB193 storage % gsutil list
gs://bharath-internal-analytics/
gs://bharath-internal-backup/
gs://bharath-internal-hr/
gs://bharath-personal-data/
gs://bharathraju-temp-data/
bharathkumarraju@R77-NB193 storage % gsutil acl -r ch -u AllUsers:R gs://bharath-personal-data/
Updated ACL on gs://bharath-personal-data/docs/
Updated ACL on gs://bharath-personal-data/docs/employee.txt
Updated ACL on gs://bharath-personal-data/photos/
Updated ACL on gs://bharath-personal-data/photos/Bharathkumar.jpg

==> NOTE: You are performing a sequence of gsutil operations that may
run significantly faster if you instead use gsutil -m acl ... Please
see the -m section under "gsutil help options" for further information
about when gsutil -m can be advantageous.

No changes to gs://bharath-personal-data/photos/anji.png
Updated ACL on gs://bharath-personal-data/photos/bharaths_elon.jpeg
bharathkumarraju@R77-NB193 storage %



bharathkumarraju@R77-NB193 storage % gsutil cp * gs://bharathraju-temp-data/
Copying file://Bharathkumar.jpg [Content-Type=image/jpeg]...
Copying file://employee.txt [Content-Type=text/plain]...
Copying file://ntuc_creds.jpg [Content-Type=image/jpeg]...
- [3 files][365.5 KiB/365.5 KiB]
Operation completed over 3 objects/365.5 KiB.
bharathkumarraju@R77-NB193 storage % gsutil iam ch AllUsers:objectViewer gs://bharathraju-temp-data/
CommandException: Incorrect public member type for binding AllUsers:objectViewer

bharathkumarraju@R77-NB193 storage % gsutil iam ch allUsers:objectViewer gs://bharathraju-temp-data/
bharathkumarraju@R77-NB193 storage %





