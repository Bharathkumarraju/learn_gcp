import base64
import json
import logging
import os

from flask import current_app, Flask, render_template, request
from google.cloud import pubsub_v1


app = Flask(__name__)

app.config['PUBSUB_VERIFICATION_TOKEN'] = \
    os.environ['PUBSUB_VERIFICATION_TOKEN']
app.config['PUBSUB_TOPIC'] = os.environ['PUBSUB_TOPIC']
app.config['PROJECT'] = os.environ['GOOGLE_CLOUD_PROJECT']

MESSAGES = []


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'GET':
        return render_template('index.html', messages=MESSAGES)

    data = request.form.get('payload', 'Example payload').encode('utf-8')

    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(
        current_app.config['PROJECT'],
        current_app.config['PUBSUB_TOPIC'])

    publisher.publish(topic_path, data=data)

    # Returning any 2xx status indicates successful receipt of the message.
    return 'OK', 200


@app.route('/pubsub/push', methods=['POST'])
def pubsub_push():
    if (request.args.get('token', '') !=
            current_app.config['PUBSUB_VERIFICATION_TOKEN']):
        return 'Invalid request', 400

    envelope = json.loads(request.data.decode('utf-8'))
    payload = base64.b64decode(envelope['message']['data'])

    MESSAGES.append(payload.decode('utf-8'))

    return 'OK', 200


@app.errorhandler(500)
def server_error(e):
    logging.exception('An error occurred during a request.')
    return """
    An internal error occurred: <pre>{}</pre>
    See logs for full stacktrace.
    """.format(e), 500


if __name__ == '__main__':

    app.run(host='127.0.0.1', port=8080, debug=True)




