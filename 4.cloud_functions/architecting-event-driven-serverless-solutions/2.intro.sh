werkzeug
google-cloud-storage

Use curl

curl -i -X POST -H "Content-Type: multipart/form-data" -F 'image_id=Bharath' -F 'product_name=MensDenimShirt' -F 'Bharath.jpg=@shirt.jpg' <<cloud_function_trigger_url>>


bharathkumarraju@R77-NB193 Downloads % curl -i -X POST -H "Content-Type: multipart/form-data" -F 'image_id=hello' -F 'product_name=hellobharath' -F 'hello.jpg=@Bharath.jpg' <<cloud_function_trigger_url>>
HTTP/2 200
content-type: text/html; charset=utf-8
function-execution-id: rh37byuf0j0c
x-cloud-trace-context: c56fb8d3e6a6881d728fee20ea6e4970;o=1
date: Sun, 05 Jul 2020 23:07:53 GMT
server: Google Frontend
content-length: 5
alt-svc: h3-29=":443"; ma=2592000,h3-27=":443"; ma=2592000,h3-25=":443"; ma=2592000,h3-T050=":443"; ma=2592000,h3-Q050=":443"; ma=2592000,h3-Q046=":443"; ma=2592000,h3-Q043=":443"; ma=2592000,quic=":443"; ma=2592000; v="46,43"

Done!%
bharathkumarraju@R77-NB193 Downloads %
