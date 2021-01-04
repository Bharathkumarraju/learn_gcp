
from google.appengine.ext import ndb
import webapp2

dog_breed = 'Labrador'

class DogCounter(ndb.Model):
    num_dogs = ndb.IntegerProperty(indexed=False)


class UpdateIncrementHandler(webapp2.RequestHandler):
    def post(self):
    
        num_dogs = int(self.request.get('num_dogs'))
        
        @ndb.transactional
        def update_dog_count():
            dog_counter = DogCounter.get_or_insert(dog_breed, num_dogs=0)
            dog_counter.num_dogs += num_dogs
            dog_counter.put()
        
        update_dog_count()


app = webapp2.WSGIApplication([
    ('/update_dog_count', UpdateIncrementHandler)
], debug=True)
