import requests
import logging

def health_check(request):
    logging.info("Health check started.")
    try:
        logging.warning("Health check will raise an exception if request times out in 10s.")
        response = requests.get("http://wwww.spikeysales.com", verify=False,timeout=10)
        if response.status_code != requests.codes.OK:
            logging.critical("website failed health check (got '{}', expected: '200')".format(response.status_code))
    except (requests.Timeout, requests.ConnectionError, KeyError) as e:
        logging.error("Request timed out.")
