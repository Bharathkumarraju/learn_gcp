def hello_pubsub(data, context):

    import base64
    from google.cloud import storage

    if 'data' in data:
        offer_text = base64.b64decode(data['data']).decode('utf-8')
    bucket = storage_client.get_bucket('spikey-developers')
    blob = bucket.blob('parsed_data/offers.json')
    if blob.exists():
        blob.download_to_filename('/tmp/offers.json')
    with open("/tmp/offers.json", 'a') as fp:
        json.dump(offer_text,fp,indent=2)
    blob.upload_from_filename('/tmp/offers.json')
    return 'Offer stored in file.'

curl -X POST https://us-central1-spikey-developers.cloudfunctions.net/writing_offers -H "Content-Type:application/json"  -d '{"offer_text":"Christmas special sale on Spikeysales!"}'
