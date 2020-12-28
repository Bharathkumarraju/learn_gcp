import os
import cgi
import cStringIO
import logging
import urllib

from google.appengine.api import memcache
from google.appengine.api import users
from google.appengine.ext import ndb

import jinja2
import webapp2

JINJA_ENVIRONMENT = jinja2.Environment(
    loader=jinja2.FileSystemLoader(os.path.dirname(__file__)),
    extensions=['jinja2.ext.autoescape'],
    autoescape=True)


class Guestbook_entries(ndb.Model):
    """Models an individual Guestbook entry with author, content, and date."""
    author = ndb.StringProperty()
    content = ndb.StringProperty()
    date = ndb.DateTimeProperty(auto_now_add=True)


def guestbook_key(guestbook_name=None):
    """Constructs a Datastore key for a Guestbook entity with guestbook_name"""
    return ndb.Key('Guestbook', guestbook_name or 'default_guestbook')


class MainPage(webapp2.RequestHandler):

    def get(self):

		guestbook_name = self.request.get('guestbook_name')
		
		guestbook_entries = self.get_guestbook_entries(guestbook_name)
		stats = memcache.get_stats()
		
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
		    'cache_hits' : stats['hits'],
		    'cache_miss' : stats['misses'],
		}
		
		template = JINJA_ENVIRONMENT.get_template('index.html')
		self.response.write(template.render(template_values))



    # [START check_memcache]
    def get_guestbook_entries(self, guestbook_name):
        """
        get_guestbook_entries()
        Checks the cache to see if there are cached guestbook_entries.
        If not, call render_guestbook_entries and set the cache
        Args:
          guestbook_name: Guestbook entity group key (string).
        Returns:
          A string of HTML containing guestbook_entries.
        """
        guestbook_entries = memcache.get('{}:guestbook_entries'.format(guestbook_name))
        if guestbook_entries is None:
            guestbook_entries = self.render_guestbook_entries(guestbook_name)
            try:
                added = memcache.add(
                    '{}:guestbook_entries'.format(guestbook_name), guestbook_entries, 10)
                if not added:
                    logging.error('Memcache set failed.')
            except ValueError:
                logging.error('Memcache set failed - data larger than 1MB')
        return guestbook_entries
    # [END check_memcache]

    # [START query_datastore]
    def render_guestbook_entries(self, guestbook_name):
        
		guestbook_entries_query = Guestbook_entries.query(
		    ancestor=guestbook_key(guestbook_name)).order(-Guestbook_entries.date)
		guestbook_entries = guestbook_entries_query.fetch(10)
		
		return guestbook_entries #output.getvalue()
    # [END query_datastore]


class Guestbook(webapp2.RequestHandler):
    def post(self):
        # We set the same parent key on the 'guestbook_entries' to ensure each guestbook_entries
        # is in the same entity group. Queries across the single entity group
        # are strongly consistent. However, the write rate to a single entity
        # group is limited to ~1/second.
        guestbook_name = self.request.get('guestbook_name')
        guestbook_entries = Guestbook_entries(parent=guestbook_key(guestbook_name))

        if users.get_current_user():
            guestbook_entries.author = users.get_current_user().nickname()

        guestbook_entries.content = self.request.get('content')
        guestbook_entries.put()
        memcache.delete('{}:guestbook_entries'.format(guestbook_name))
        self.redirect('/?' +
                      urllib.urlencode({'guestbook_name': guestbook_name}))


app = webapp2.WSGIApplication([('/', MainPage),
                               ('/sign', Guestbook)],
                              debug=True)

# [END all]
