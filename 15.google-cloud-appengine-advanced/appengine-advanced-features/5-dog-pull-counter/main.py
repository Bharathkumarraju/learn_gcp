
import logging
import os
import time

from google.appengine.api import taskqueue
from google.appengine.ext import ndb
from google.appengine.runtime import apiproxy_errors
import jinja2
import webapp2


JINJA_ENV = jinja2.Environment(
    loader=jinja2.FileSystemLoader(os.path.dirname(__file__)))


class DogCounter(ndb.Model):
    num_dogs = ndb.IntegerProperty(indexed=False)


class CounterHandler(webapp2.RequestHandler):
    def get(self):
        template_values = {'dog_counter': DogCounter.query()}
        template = JINJA_ENV.get_template('index.html')
        self.response.out.write(template.render(template_values))

    # Adding 
    def post(self):
        dog_breed = self.request.get('dog_breed')
        if dog_breed:
            queue = taskqueue.Queue('dog-pull-counter')
            queue.add(taskqueue.Task(payload='', method='PULL', tag=dog_breed))
        self.redirect('/')



@ndb.transactional
def update_dog_counter(key, tasks):
    dog_counter = DogCounter.get_or_insert(key, num_dogs=0)
    dog_counter.num_dogs += len(tasks)
    dog_counter.put()

class CounterWorker(webapp2.RequestHandler):
    def get(self):

        queue = taskqueue.Queue('dog-pull-counter')
        while True:
            try:
                tasks = queue.lease_tasks_by_tag(3600, 1000, deadline=60)
            except (taskqueue.TransientError,
                    apiproxy_errors.DeadlineExceededError) as e:
                logging.exception(e)
                time.sleep(1)
                continue

            if tasks:
                print("tasks",tasks)
                dog_breed = tasks[0].tag

                try:
                    update_dog_counter(dog_breed, tasks)
                except Exception as e:
                    logging.exception(e)
                    raise
                finally:
                    queue.delete_tasks(tasks)

            time.sleep(1)


app = webapp2.WSGIApplication([
    ('/', CounterHandler),
    ('/_ah/start', CounterWorker)
], debug=True)




