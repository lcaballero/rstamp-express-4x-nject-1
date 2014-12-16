hbs           = require('express-handlebars')
bodyParser    = require('body-parser')
cookieParser  = require('cookie-parser')
path          = require('path')


module.exports = (express) ->

  app = express()

  app.set('views', path.join(__dirname, '../views'))

  app.engine('.hbs', hbs({
    extname         : '.hbs'
    defaultLayout   : 'default'
    layoutsDir      : path.join(__dirname, '../views/layouts')
    partialsDir     : path.join(__dirname, '../views/partials')
    helpers         : {
      json : JSON.stringify
    }
  }))

  app.set 'view engine', '.hbs'

  app.use(bodyParser.urlencoded({ extended: false }))         # https://www.npmjs.com/package/body-parser
  app.use(cookieParser())                                     # https://github.com/expressjs/cookie-parser

  # This can/should be handled by something like Nginx
  app.use express.static(path.join(__dirname, '../public'))

  app
