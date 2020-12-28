gcloud iam service-accounts keys create ~/spikey-dlp-agent/key.json \
--iam-account spikey-dlp@spikey-security.iam.gserviceaccount.com


gcloud auth activate-service-account \
 spikey-dlp@spikey-security.iam.gserviceaccount.com \
 --key-file=spikey-dlp-agent/key.json --project=spikey-security

#

{  
   "item":{  
      "value":"SpikeySales' headquarters is located at  8775 Sugar Street Lancaster, NY 14086, United States"
   },
   "inspectConfig":{  
      "includeQuote":true,
      "minLikelihood":"POSSIBLE",
      "infoTypes":{  
         "name":"LOCATION"
      }
   }
}

#

 curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/location_inspect.json \
-o spikey-dlp-agent/location_inspect_output \
https://dlp.googleapis.com/v2/projects/spikey-security/content:inspect

#


{  
   "inspectJob":{  
      "storageConfig":{  
         "cloudStorageOptions":{  
            "fileSet":{  }
         }
      },
      "inspectConfig":{  
         "infoTypes":[  
            {  
               "name":"PHONE_NUMBER"
            },
            {  
               "name":"US_SOCIAL_SECURITY_NUMBER"
            },
            {  
               "name":"INDIA_PAN_INDIVIDUAL"
            },
            {  
               "name":"CHINA_PASSPORT"
            },
            {  
               "name":"CANADA_PASSPORT"
            },
            {  
               "name":"BRAZIL_CPF_NUMBER"
            },
            {  
               "name":"EMAIL_ADDRESS"
            }

         ]
         "excludeInfoTypes":false,
         "includeQuote":true,
         "minLikelihood":"LIKELY"
      },
      "actions":[  
         {  
            "saveFindings":{  
               "outputConfig":{  
                  "table":{  
                     "projectId":"spikey-security",
                     "datasetId":"seller_dataset",
                     "tableId":"seller_data_table"
                  }
               }
            }
         }
      ]
   }
}

###

 curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/seller_data_inspect.json -o spikey-dlp-agent/seller_data_inspect_output \
https://dlp.googleapis.com/v2/projects/spikey-security/dlpJobs

###


SELECT * FROM `spikey-security.seller_dataset.seller_data_table` LIMIT 20


####

SELECT
  info_type.name,
  COUNT( likelihood ) AS icount
FROM
  `spikey-security.seller_dataset.seller_data_table`
GROUP BY
  info_type.name

###


{  
   "inspectTemplate":{  
      "displayName":"sellers_information",
      "description":"scan for seller's data",
      "inspectConfig":{  
         "infoTypes":[  
            {  
               "name":"PHONE_NUMBER"
            },
            {  
               "name":"US_SOCIAL_SECURITY_NUMBER"
            },
            {  
               "name":"EMAIL_ADDRESS"
            }

         ]
         "minLikelihood":"POSSIBLE",
         "limits":{  
            "maxFindingsPerRequest":100
         },
         "includeQuote":true
      }
   }
}

#

 curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
https://dlp.googleapis.com/v2/projects/spikey-security/inspectTemplates \
-d @spikey-dlp-agent/contactinfo_custom_template.json -o spikey-dlp-agent/contactinfo_custom_template

#


 curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -X GET https://dlp.googleapis.com/v2/projects/spikey-security/inspectTemplates 

##


{  
   "inspectConfig":{  

   },
   "item":{  
      "value":"My phone number is 789-541-523, Social Security Number 785-86-285 and mail id is spikey@gmail.com"
   },
   "inspectTemplateName":" s"
}



 curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d spikey-dlp-agent/contactinfo_custom_inspect.json -o spikey-dlp-agent/contactinfo_custom_inspect_output \
https://dlp.googleapis.com/v2/projects/spikey-security/content:inspect
##