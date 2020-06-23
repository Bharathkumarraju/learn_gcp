bharathkumarraju@R77-NB193 external % mkdir storage
bharathkumarraju@R77-NB193 external % cd storage
bharathkumarraju@R77-NB193 storage % vim employee.txt
bharathkumarraju@R77-NB193 storage % gsutil cp employee.txt  gs://bharath-personal-data/docs/
Copying file://employee.txt [Content-Type=text/plain]...
- [1 files][   15.0 B/   15.0 B]
Operation completed over 1 objects/15.0 B.
bharathkumarraju@R77-NB193 storage %


bharathkumarraju@R77-NB193 storage % gsutil versioning set on gs://bharath-personal-data
Enabling versioning for gs://bharath-personal-data/...
bharathkumarraju@R77-NB193 storage %


bharathkumarraju@R77-NB193 storage % gsutil versioning get  gs://bharath-personal-data
gs://bharath-personal-data: Enabled
bharathkumarraju@R77-NB193 storage %

