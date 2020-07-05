from wand.image import Image
from google.cloud import storage

spikey_client = storage.Client()
THUMBNAIL_BUCKET = 'spikey-developers'

def spikey_thumbnail(data, context):
    bucket = spikey_client.get_bucket(data['bucket'])
    blob = bucket.get_blob(data['name'])
    spikey_imagedata = blob.download_as_string()
    spikey_newimage = Image(blob=spikey_imagedata)
    spikey_newimage.sample(200,200)
    bucket = spikey_client.get_bucket(THUMBNAIL_BUCKET)
    newblob = bucket.blob('thumbnail-' + data['name'])
    newblob.upload_from_string(spikey_newimage.make_blob())
