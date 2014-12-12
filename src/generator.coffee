Gen = require('rubber-stamp')


module.exports = (opts, isTesting) ->
  { source, target } = opts
  gen = Gen.using(source, target, opts, 'Generate express-4.x and express-train, nject app')
    .mkdir()
    .mkdirs(
      'app',
      'app/controllers',
      'app/models',
      'app/libs',
      'app/middleware',
      'app/repos',
      'app/utilities')
    .copy('app/app.coffee')
    .copy('app/controllers/HomeController.coffee')
    .copy('app/middleware/routes.coffee')
    .copy('app/middleware/server.coffee')
    .copy('app/public/js/angular-1.2.js')
    .copy('app/public/css/contains.css')
    .copy('app/public/css/reset.css')
    .copy('config/default.json')

    # Public CSS
    .copy('app/public/css/contains.css')
    .copy('app/public/css/global.css')
    .copy('app/public/css/reset.css')

    # Public JS
    .copy('app/public/js/angular-1.2.js')
    .copy('app/public/js/WritingController.js')

    # Views
    .copy('app/views/layouts/default.hbs')
    .copy('app/views/partials/css.hbs')
    .copy('app/views/partials/scripts.hbs')
    .copy('app/views/index.hbs')

    # Tests
    .copy('tests/first-test.coffee')
    .copy('tests/globals.coffee')


    # Basics
    .mkdirs('files')
    .copy('index.js')
    .copy('license')
    .translate('package.json.ftl', 'package.json')
    .translate('readme.md.ftl', 'readme.md')
    .translate('gitignore', '.gitignore')
    .translate('travis.yml', '.travis.yml')

    .run(
      commands:
        if isTesting then []
        else [
            name : 'npm'
            args : [
              "install", "body-parser", "compression", "connect-timeout", "cookie-parser", "cookie-session"
              "coffee-script", "error-handler", "express@4.x", "express-handlebars", "method-override"
              "morgan", "nject", "response-time", "serve-favicon", "serve-index", "serve-static"
              "session", "type-is", "vhost", "lodash", "--save"
            ]
          ,
            name : 'npm'
            args : [ 'install', 'mocha', 'chai', 'sinon', 'sinon-chai', '--save-dev' ]
          ,
            name : 'chmod'
            args : [ '+x', 'index.js' ]
          ,
            name : 'git'
            args : [ 'init' ]
          ,
            name : 'npm'
            args : [ 'test' ]
          ]
    )

  ->
    gen.apply()