from flask import Flask
app = Flask(__name__)
 
@app.route("/")
def index():
    return "Welcome to Spikeysales!"
 
@app.route("/mail")
def hello():
    return "Email us at: spikeysales@loonycorn.com"
 
@app.route("/location")
def members():
    return "Our offices are at: Farmington, Utah, United States"
 

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
