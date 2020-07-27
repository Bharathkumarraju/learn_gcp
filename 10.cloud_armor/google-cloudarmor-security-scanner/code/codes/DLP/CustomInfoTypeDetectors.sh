curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/custom_infotype_template.json \
-o spikey-dlp-agent/custom_infotype_template_output \
https://dlp.googleapis.com/v2/projects/spikey-security/storedInfoTypes


###################
{  
   "config":{  
      "displayName":"sensitive information",
      "description":"Project code names",
      "largeCustomDictionary":{  
         "outputPath":{  
            "path":"gs://project_details"
         },
         "bigQueryField":{  
            "table":{  
               "datasetId":"project_codename_dataset",
               "projectId":"spikey-security",
               "tableId":"project_codename_table"
            },
            "field":{  
               "name":"Project_codename"
            }
         }
      }
   },
   "storedInfoTypeId":"sensitive-detail"
}


##############

>> to list the stored info types Detector

curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
-X GET https://dlp.googleapis.com/v2/projects/spikey-security/storedInfoTypes

##############


curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/project_codename_inspection.json \
-o spikey-dlp-agent/project_codename_inspection_output \
https://dlp.googleapis.com/v2/projects/spikey-security/content:inspect

#

{  
   "inspectConfig":{  
      "customInfoTypes":[  
         {  
            "infoType":{  
               "name":"inspect internal project code names"
            },
            "storedType":{  
               "name":"projects/spikey-security/storedInfoTypes/sensitive-detail"
            }
         }
      ]
   },
   "item":{  
      "value":"This is a great new addition for the SELLEASY and CATWORM features however I am not sure that LIKEALOT can use this"
   }
}

#


gcloud auth activate-service-account \
dlp-demo@spikey-gcp.iam.gserviceaccount.com \
 --key-file=pranjal_cs1/key.json --project=spikey-gcp


curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/custom_regex_detector.json \
-o spikey-dlp-agent/custom_regex_detector_output \
https://dlp.googleapis.com/v2/projects/spikey-security/content:inspect


#

{  
   "item":{  
      "value":"Jack's credit card number is 7894-5426-7845"
   },
   "inspectConfig":{  
      "customInfoTypes":[  
         {  
            "infoType":{  
               "name":"CARD_NUMBER"
            },
            "regex":{  
               "pattern":"[1-9]{4}-[1-9]{4}-[1-9]{4}"
            },
            "likelihood":"POSSIBLE"
         }
      ]
   }
}

#








 
