nject = require('nject')
Tree  = nject.Tree

module.exports = do ->

  tree = new Tree()

  tree.register('express'           , -> require("express"))
  tree.register('HomeController'    , require("./controllers/HomeController"))
  tree.register('routes'            , require('./middleware/routes'))
  tree.register('server'            , require('./middleware/server'))
  tree.register('mongo'             , require('./repos/Mongo'))

  tree.constant('config'            , require('../config/default.json'))
