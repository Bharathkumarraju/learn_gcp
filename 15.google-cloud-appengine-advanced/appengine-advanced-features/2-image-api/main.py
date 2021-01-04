
import os
import base64
import jinja2

from google.appengine.ext import webapp
from google.appengine.api import images

import sendgrid
from sendgrid.helpers.mail import Email, Content, Mail, Personalization, Attachment


JINJA_ENVIRONMENT = jinja2.Environment(
    loader=jinja2.FileSystemLoader(os.path.dirname(__file__)),
    extensions=['jinja2.ext.autoescape'],
    autoescape=True)



SENDGRID_API_KEY = ''
SENDGRID_SENDER = 'spikey.engineer@loonycorn.com'

recipient = 'contact@loonycorn.com'


class MainHandler(webapp.RequestHandler):
    def get(self):
		self.response.headers['Content-Type'] = 'text/html'
		
		template = JINJA_ENVIRONMENT.get_template('index.html')
		self.response.write(template.render())


class UploadHandler(webapp.RequestHandler):

    def post(self):

		text_content = self.request.get('text-content')

		image = self.request.get('file')
		image = images.resize(image, 100, 100)
		    	
		attachment = Attachment()
		attachment.filename="image.jpg"
		attachment.content=base64.b64encode(image)
		attachment.type="image/jpg"
		                        
		sg = sendgrid.SendGridAPIClient(apikey=SENDGRID_API_KEY)
		to_email = Email(recipient)
		from_email = Email(SENDGRID_SENDER)	
		subject = 'New Ticket.'
		content = Content('text/plain', "New ticket raised with the following issue: " + text_content)	
		
		message = Mail(from_email, subject, to_email, content)
		message.add_attachment(attachment)

		response = sg.client.mail.send.post(request_body=message.get())	
		self.response.write("Ticket Raised!")


app = webapp.WSGIApplication(
          [('/', MainHandler),
           ('/upload', UploadHandler),
          ], debug=True)
          
          
          
          
          
          