nject = require('nject')
Tree  = nject.Tree

module.exports = do ->

  tree = new Tree()

  tree.register('express'           , -> require("express"))
  tree.register('HomeController'    , require("./controllers/HomeController"))
  tree.register('routes'            , require('./middleware/routes'))
  tree.register('server'            , require('./middleware/server'))
  tree.constant('config'            , require('../config/default.json'))

  ->
    tree.resolve((err, resolved) ->
      if err?
        console.log(JSON.stringify(err, null, '  '))
      else
        { server, config } = resolved
        { port } = config
        app = server.listen(port, ->
          console.log('Listening on port %d', app.address().port)
        )
    )
