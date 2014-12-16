helpers = require './app/libs/ProcessHelpers'
{ run } = helpers


conf = require './config/default.json'
console.log(conf)

parts = "mongod --port #{conf.mongo.port} --dbpath #{conf.mongo.dbpath}".split(' ')

run({ commands:[{ args:  parts }] }, (err, res) ->
  if err?
    console.log(err)
  else
    console.log(res)
)

