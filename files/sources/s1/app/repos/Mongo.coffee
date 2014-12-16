mongodb = require 'mongodb'
client  = mongodb.MongoClient


module.exports = (config, _done) ->

  mongo = config.mongo
  url   = "mongodb://localhost:#{mongo.port}/#{mongo.db}"

  client.connect(url, (err, db) ->
    if err?
      console.log("Error creating mongo connection.", err)
      _done(err, null)
    else
      _done(null, db)
  )
