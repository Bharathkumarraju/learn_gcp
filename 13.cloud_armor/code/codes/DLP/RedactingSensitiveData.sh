
gcloud auth activate-service-account \
spikey-dlp@spikey-security.iam.gserviceaccount.com \
 --key-file=spikey-dlp-agent/key.json --project=spikey-security


##

{  
  "item":{  
    "value":"My contact number is 555-869-512."
  }, 
  "deidentifyConfig":{ 

    "infoTypeTransformations":{ 

      "transformations":[

        {  
          "infoTypes":[  
            {  
              "name":"PHONE_NUMBER"
            }
          ],
          
          "primitiveTransformation":{  
            "characterMaskConfig":{  
              "maskingCharacter":"#",
              "reverseOrder":false,
              "charactersToIgnore":[  
                {  
                  "charactersToSkip":".@"
                }
              ]
            }
          }
        }
      ]
    }
  },
  "inspectConfig":{ 

    "infoTypes":[  
      {  
        "name":"PHONE_NUMBER"
      }
    ]
  }
}

##

 curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/phone_number_deidentification.json -o spikey-dlp-agent/phone_number_deidentification_output \
https://dlp.googleapis.com/v2/projects/spikey-security/content:deidentify

##

cat ~/spikey-dlp-agent/ssn.jpg | base64 > ~/spikey-dlp-agent/ssn.base64


##


{
  "byteItem":{
    "data": " ",
    "type": "IMAGE_JPEG"
 },
 "imageRedactionConfigs":[
    {
      "infoType":{
       "name": "US_SOCIAL_SECURITY_NUMBER"
     },
       "redactionColor":{
        "red": 0.8
      }
   }
 ]
 "inspectConfig":{
    "infoTypes":[
      {
        "name": "US_SOCIAL_SECURITY_NUMBER"
      },
    ]
}
}

##

curl -s \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H 'Content-Type: application/json' \
-X POST \
-d @spikey-dlp-agent/ssn_redact.json -o spikey-dlp-agent/ssn_redact_output \
https://dlp.googleapis.com/v2/projects/spikey-security/image:redact

##

base64 -d < ~spikey-dlp-agent/encoded_image > ~/spikey-dlp-agent/redacted_ssn.jpg





