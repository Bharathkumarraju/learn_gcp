import os
import urllib

from google.appengine.api import users
from google.appengine.ext import ndb

import jinja2
import webapp2

JINJA_ENVIRONMENT = jinja2.Environment(
    loader=jinja2.FileSystemLoader(os.path.dirname(__file__)),
    extensions=['jinja2.ext.autoescape'],
    autoescape=True)


DEFAULT_GUESTBOOK_NAME = 'spikey_guestbook'


def guestbook_key(guestbook_name=DEFAULT_GUESTBOOK_NAME):

    return ndb.Key('Guestbook', guestbook_name)



class Author(ndb.Model):

    identity = ndb.StringProperty(indexed=False)
    email = ndb.StringProperty(indexed=False)


class Guestbook_entries(ndb.Model):

    author = ndb.StructuredProperty(Author)
    content = ndb.StringProperty(indexed=False)
    date = ndb.DateTimeProperty(auto_now_add=True)



class MainPage(webapp2.RequestHandler):

    def get(self):
		guestbook_name = self.request.get('guestbook_name',
		                                  DEFAULT_GUESTBOOK_NAME)
		guestbook_entries_query = Guestbook_entries.query(
		    ancestor=guestbook_key(guestbook_name)).order(-Guestbook_entries.date)
		guestbook_entries = guestbook_entries_query.fetch(10)
		
		user = users.get_current_user()
		if user:
		    url = users.create_logout_url(self.request.uri)
		    url_linktext = 'Logout'
		else:
		    url = users.create_login_url(self.request.uri)
		    url_linktext = 'Login'
		
		template_values = {
		    'user': user,
		    'guestbook_entries': guestbook_entries,
		    'guestbook_name': urllib.quote_plus(guestbook_name),
		    'url': url,
		    'url_linktext': url_linktext,
		}
		
		template = JINJA_ENVIRONMENT.get_template('index.html')
		self.response.write(template.render(template_values))


class Guestbook(webapp2.RequestHandler):

    def post(self):

        guestbook_name = self.request.get('guestbook_name',
                                          DEFAULT_GUESTBOOK_NAME)
        guestbook_entries = Guestbook_entries(parent=guestbook_key(guestbook_name))

        if users.get_current_user():
            guestbook_entries.author = Author(
                    identity=users.get_current_user().user_id(),
                    email=users.get_current_user().email())

        guestbook_entries.content = self.request.get('content')
        guestbook_entries.put()

        query_params = {'guestbook_name': guestbook_name}



app = webapp2.WSGIApplication([
    ('/', MainPage),
    ('/sign', Guestbook),
], debug=True)

