module.exports = (config, express, server, HomeController) ->

  router = express.Router()

  router.use((req, res, next) ->
    res.locals.config = config
    next()
  )

  router.get "/"          , HomeController.index
  router.get "/hello"     , HomeController.hello
  router.get "/data"      , HomeController.data
  router.get "/user"      , HomeController.user
  router.get "/add"       , HomeController.add
  router.get "/see"       , HomeController.see

  server.use(router)