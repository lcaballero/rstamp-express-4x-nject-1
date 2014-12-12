module.exports = ->

  index: (req, res, next) ->
    res.render "index"

  hello: (req, res, next) ->
    res.send "Hello, World!"

  data: (req, res, next) ->
    res.send JSON.stringify({hello:'world!'})
