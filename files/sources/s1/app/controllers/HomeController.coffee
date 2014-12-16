module.exports = (mongo) ->

  coll = mongo.collection("Users")

  index: (req, res, next) ->
    res.render "index", { action: 'index' }

  hello: (req, res, next) ->
    res.send "Hello, World!"

  data: (req, res, next) ->
    res.send JSON.stringify({hello:'world!'})

  user: (req, res, next) ->
    name = req.param('username')
    coll.find({username: name}).toArray((err, docs) ->
      if err?
        console.log(err)
      else
        if docs.length is 0
          res.send("#{name} isn't in the system ")
        else
          res.send("#{name} is in the system")
    )

  add: (req, res, next) ->
    name = req.param('username')
    coll.find({username:name}).toArray((err, docs) ->
      if err?
        console.log(err)
      else
        if docs.length > 0
          res.send("#{name} is already in the system")
        else
          coll.insert({username: name}, (e2, r2) ->
            if e2?
              console.log(e2)
            else
              res.send("Added #{name}")
          )
    )

  see: (req, res, next) ->
    s = ["Properties of req.params"]

    for p in req.params
      s.push(p)

    s.push("req.query")
    s.push(req.query.name)
    for p in req.query
      s.push(p)

    r = s.join("<br/>") + JSON.stringify(req.config, null, '  ')
    res.send(r)