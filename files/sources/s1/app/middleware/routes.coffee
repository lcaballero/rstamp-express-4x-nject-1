


module.exports = (express, server, HomeController) ->

  router = express.Router()

  router.get "/"          , HomeController.index
  router.get "/hello"     , HomeController.hello
  router.get "/data"      , HomeController.data

  server.use(router)