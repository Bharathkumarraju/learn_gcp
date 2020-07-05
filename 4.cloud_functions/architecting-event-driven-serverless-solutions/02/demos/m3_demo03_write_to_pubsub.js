
exports.getOfferContent = (req, res) => {
    
    let offer_text;
    
    offer_text = req.body.offer_text;
    
    const PubSub = require(`@google-cloud/pubsub`);
    const pubsub = new PubSub();
    
    
    const dataBuffer = Buffer.from(offer_text);
    
    pubsub
    .topic('spikey-offer-topic')
    .publisher()
    .publish(dataBuffer)
    .then(messageId => {
          console.log(`Message ${messageId} published.`);
          })
    .catch(err => {
           console.error('ERROR:', err);
           });
    
    setTimeout(() => {
               
               console.log('Function running...');
               res.status(200).send(`Message published.`);
               res.end();
               }, 12000);
};


package.json
{
    "name": "nodejs-samples-pubsub",
    "version": "0.0.1",
    "engines": {
        "node": ">=4.3.2"
    },
    "dependencies": {
        "@google-cloud/pubsub": "0.19.0"
    },
    "devDependencies": {
        "@google-cloud/pubsub": "0.19.0"
    }
}
