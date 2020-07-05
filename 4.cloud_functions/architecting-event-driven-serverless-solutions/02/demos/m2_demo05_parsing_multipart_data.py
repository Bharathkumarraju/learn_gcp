import os
import json
import tempfile
from werkzeug.utils import secure_filename
from google.cloud import storage

def get_file_path(filename):
    file_name = secure_filename(filename)
    return os.path.join(tempfile.gettempdir(), file_name)


def parse_multipart(request):
    
    storage_client = storage.Client()
    bucket_name = os.environ.get('IMAGES_BUCKET')
    bucket = storage_client.get_bucket(bucket_name)
    
    fields = {}
    data = request.form.to_dict()
    blob = bucket.blob('parsed_uploads/prod_image_info.json')
    for field in data:
        fields[field] = data[field]
        with open("/tmp/prod_image_info.json", 'w') as fp:
            json.dump(fields,fp,indent=2)
        blob.upload_from_filename('/tmp/prod_image_info.json')
    
    files = request.files.to_dict()
    for file_name, file in files.items():
        file.save(get_file_path(file_name))
        blob = bucket.blob('parsed_uploads/'+file_name)
        blob.upload_from_filename(get_file_path(file_name))

    for file_name in files:
        file_path = get_file_path(file_name)
        os.remove(file_path)
    return "Done!"

werkzeug
google-cloud-storage

Use curl

curl -i -X POST -H "Content-Type: multipart/form-data" -F 'image_id=PD_IMG123' -F 'product_name=MensDenimShirt' -F 'PD_IMG123.jpg=@shirt.jpg' https://us-central1-spikey-developers.cloudfunctions.net/function-1
