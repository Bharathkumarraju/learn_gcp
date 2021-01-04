
from google.appengine.api import app_identity
from google.appengine.api import mail
import webapp2


recipients={
  'r1':'Alice <alice@loonycorn.com>',
  'r2':'Bob <bob@loonycorn.com>',
  'r3':'Judy <judy@loonycorn.com>',
  'r4':'Yase <yase@loonycorn.com>',
}

def send_approved_mail(sender_address,recipients):

    for key in recipients:
    	mail.send_mail(sender=sender_address,
                   to=recipients[key],
                   subject="Exclusive winter sale at SpikeySales",
                   body="""Hello Dog Parent, 
This winter buy dog feed from spikeysales and get a free chew toy for your canine kid.
NO COUPON CODE NEEDED.

Regard 
Team Spikey
""")


class SendMailHandler(webapp2.RequestHandler):
    def get(self):
    	recipients = dict([(key,value) for (key,value) in app.config.iteritems()])
        send_approved_mail("spikey.engineer@loonycorn.com",recipients)
        self.response.content_type = 'text/plain'
        self.response.write('Email Sent')


app = webapp2.WSGIApplication(routes=[
	   ('/mail_alert', SendMailHandler),
	], config=recipients, debug=True)