import json
import io
import random
from google.cloud import storage
from google.cloud import vision

storage_client = storage.Client()

def generate_tags(data, context):
    client = vision.ImageAnnotatorClient()
    bucket = storage_client.get_bucket(data['bucket'])
    blobs = bucket.list_blobs()
    for blob in blobs:
        if ".jpg" in blob.name:
            blob.download_to_filename('/tmp/image.jpg')
            with io.open('/tmp/image.jpg', 'rb') as image_file:
                content = image_file.read()
            image = vision.types.Image(content=content)
            response = client.label_detection(image=image)
            with open("/tmp/tags.txt", 'a') as fp:
                for label in response.label_annotations:
                    json.dump(label.description,fp,indent=2)
            blob = bucket.blob('image_tags/tags.txt')
            blob.upload_from_filename('/tmp/tags.txt')

google-cloud-storage
google-cloud-vision==0.34.0
grpcio
grpcio-tools

