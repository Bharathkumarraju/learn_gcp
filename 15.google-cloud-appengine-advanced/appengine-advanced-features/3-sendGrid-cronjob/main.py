
import sendgrid
from sendgrid.helpers import mail

import webapp2

SENDGRID_API_KEY = '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'
SENDGRID_SENDER = 'spikey.engineer@loonycorn.com'

recipients = [
    'alice@loonycorn.com',
    'bob@loonycorn.com',
    'judy@loonycorn.com',
    'yase@loonycorn.com'
]

def send_simple_message(recipient):

    sg = sendgrid.SendGridAPIClient(apikey=SENDGRID_API_KEY)

    to_email = mail.Email(recipient)
    from_email = mail.Email(SENDGRID_SENDER)
    subject = 'SpikeySales weekly lightning deal!'
    text = """Hurry up and grab the weekly lightning deal on Pedigree and other top dog feed brands."""
    content = mail.Content('text/plain', text)

    message = mail.Mail(from_email, subject, to_email, content)
    response = sg.client.mail.send.post(request_body=message.get())

    return response

class MainPage(webapp2.RequestHandler):
    def get(self):
		for recipient in recipients:
			sg_response = send_simple_message(recipient)
			
		self.response.write("""Offer Sent""")


app = webapp2.WSGIApplication([
    ('/', MainPage)
], debug=True)

