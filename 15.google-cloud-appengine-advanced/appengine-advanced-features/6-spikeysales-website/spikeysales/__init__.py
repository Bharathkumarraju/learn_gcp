
import json
import logging

from flask import current_app, Flask, redirect, request, session, url_for
import httplib2

from oauth2client.contrib.flask_util import UserOAuth2
oauth2 = UserOAuth2()

def create_app(config, debug=False, testing=False, config_overrides=None):
    app = Flask(__name__)
    app.config.from_object(config)

    app.debug = debug
    app.testing = testing

    if config_overrides:
        app.config.update(config_overrides)

    if not app.testing:
        logging.basicConfig(level=logging.INFO)

    with app.app_context():
        model = get_model()
        model.init_app(app)

    oauth2.init_app(
        app,
        scopes=['email', 'profile'],
        authorize_callback=_request_user_info)

    @app.route('/logout')
    def logout():

        del session['profile']
        session.modified = True
        oauth2.storage.delete()
        return redirect(request.referrer or '/')

    from .crud import crud
    app.register_blueprint(crud, url_prefix='/dogs')

    @app.route("/")
    def index():
        return redirect(url_for('crud.list'))

    @app.errorhandler(500)
    def server_error(e):
        return """
        An internal error occurred: <pre>{}</pre>
        See logs for full stacktrace.
        """.format(e), 500

    return app


def get_model():

    from . import datastore
    return datastore

def _request_user_info(credentials):

    http = httplib2.Http()
    credentials.authorize(http)
    resp, content = http.request(
        'https://www.googleapis.com/plus/v1/people/me')

    if resp.status != 200:
        current_app.logger.error(
            "Error while obtaining user profile: \n%s: %s", resp, content)
        return None
    session['profile'] = json.loads(content.decode('utf-8'))

