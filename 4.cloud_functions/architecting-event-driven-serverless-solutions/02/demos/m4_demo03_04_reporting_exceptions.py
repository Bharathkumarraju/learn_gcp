import os
import smtplib
from google.cloud import error_reporting

def tag_reader(data,context):
    email = os.environ.get('EMAIL')
    password = os.environ.get('Password')
    
    client = error_reporting.Client()
    message ='New ticket raised'
    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(email,password)
        server.sendmail(email, 'customercare@spikeysales.com', message)
    except(smtplib.SMTPAuthenticationError):
        client.report_exception()


google-cloud-error-reporting
