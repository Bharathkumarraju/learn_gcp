
from google.appengine.api import taskqueue
from google.appengine.ext import ndb
from google.appengine.runtime import apiproxy_errors

import logging
import os
import time

import jinja2
import webapp2


JINJA_ENV = jinja2.Environment(
    loader=jinja2.FileSystemLoader(os.path.dirname(__file__)))

dog_breed = 'Labrador'

class DogCounter(ndb.Model):
    num_dogs = ndb.IntegerProperty(indexed=False)


class MainPageHandler(webapp2.RequestHandler):
    def get(self):
    
        dog_counter = DogCounter.get_by_id(dog_breed)
        num_dogs = dog_counter.num_dogs if dog_counter else 0
        
        template_values = {'num_dogs': num_dogs}
        template = JINJA_ENV.get_template('index.html')
        self.response.out.write(template.render(template_values))


class EnqueueTaskHandler(webapp2.RequestHandler):
    def post(self):
        num_dogs = int(self.request.get('num_dogs'))
        
        task = taskqueue.add(
            url='/update_dog_count',
            target='worker',
            params={'num_dogs': num_dogs},
            queue_name="dog-push-counter")
        
        self.redirect('/render')
        
class RenderHandler(webapp2.RequestHandler):
    def get(self):
        dog_counter = DogCounter.get_by_id(dog_breed)
        num_dogs = dog_counter.num_dogs if dog_counter else 0
        
        template_values = {'num_dogs': num_dogs,
                            'render':1}
                            
        template = JINJA_ENV.get_template('index.html')
        self.response.out.write(template.render(template_values))

app = webapp2.WSGIApplication([
    ('/', MainPageHandler),
    ('/enqueue', EnqueueTaskHandler),
    ('/render', RenderHandler),
], debug=True)

