hbs     = require('express-handlebars')
path    = require('path')

module.exports = (express) ->

  app = express()

  app.set('views', path.join(__dirname, '../views'))

  app.engine('.hbs', hbs({
    extname         : '.hbs'
    defaultLayout   : 'default'
    layoutsDir      : path.join(__dirname, '../views/layouts')
    partialsDir     : path.join(__dirname, '../views/partials')
  }))

  app.set 'view engine', '.hbs'
  app.use express.static(path.join(__dirname, '../public'))

  app
