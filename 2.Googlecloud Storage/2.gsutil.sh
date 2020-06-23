bharathkumarraju@R77-NB193 external % gsutil list
gs://bharath-internal-analytics/
gs://bharath-internal-backup/
gs://bharath-internal-hr/
bharathkumarraju@R77-NB193 external % gsutil mb gs://bharath-personal-data/
Creating gs://bharath-personal-data/...
bharathkumarraju@R77-NB193 external %

bharathkumarraju@R77-NB193 external % gsutil mb -p srianjaneyam -c regional -l asia-southeast1 gs://bharathraju-temp-data/
Creating gs://bharathraju-temp-data/...
bharathkumarraju@R77-NB193 external %


bharathkumarraju@R77-NB193 external % gsutil ls -L -b gs://bharathraju-temp-data/
gs://bharathraju-temp-data/ :
	Storage class:			REGIONAL
	Location type:			region
	Location constraint:		ASIA-SOUTHEAST1
	Versioning enabled:		None
	Logging configuration:		None
	Website configuration:		None
	CORS configuration: 		None
	Lifecycle configuration:	None
	Requester Pays enabled:		None
	Labels:				None
	Default KMS key:		None
	Time created:			Tue, 23 Jun 2020 01:34:39 GMT
	Time updated:			Tue, 23 Jun 2020 01:34:39 GMT
	Metageneration:			1
	Bucket Policy Only enabled:	False
	ACL:
	  [
	    {
	      "entity": "project-owners-202016682554",
	      "projectTeam": {
	        "projectNumber": "202016682554",
	        "team": "owners"
	      },
	      "role": "OWNER"
	    },
	    {
	      "entity": "project-editors-202016682554",
	      "projectTeam": {
	        "projectNumber": "202016682554",
	        "team": "editors"
	      },
	      "role": "OWNER"
	    },
	    {
	      "entity": "project-viewers-202016682554",
	      "projectTeam": {
	        "projectNumber": "202016682554",
	        "team": "viewers"
	      },
	      "role": "READER"
	    }
	  ]
	Default ACL:
	  [
	    {
	      "entity": "project-owners-202016682554",
	      "projectTeam": {
	        "projectNumber": "202016682554",
	        "team": "owners"
	      },
	      "role": "OWNER"
	    },
	    {
	      "entity": "project-editors-202016682554",
	      "projectTeam": {
	        "projectNumber": "202016682554",
	        "team": "editors"
	      },
	      "role": "OWNER"
	    },
	    {
	      "entity": "project-viewers-202016682554",
	      "projectTeam": {
	        "projectNumber": "202016682554",
	        "team": "viewers"
	      },
	      "role": "READER"
	    }
	  ]
bharathkumarraju@R77-NB193 external %

