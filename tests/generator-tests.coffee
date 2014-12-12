Gen     = require("../src/generator")
path    = require('path')
fs      = require('fs')
{ run } = require('./ProcessHelpers')

describe 'generator =>', ->

  exists = (root, dirs...) ->
    for dir in dirs
      file = path.resolve(root, dir)
      expect(fs.existsSync(file), 'should have created: ' + file).to.be.true

  within = (dirs...) ->
    exists: (d...) ->
      p = [ path.resolve.apply(path, dirs) ]
      exists.apply(null, p.concat(d))

  rm = (cwd, t, cb) ->
    cmds =
      target : cwd
      commands: [ { name: 'rm', args: ['-rf', t] } ]
    run(cmds, cb)

  describe 'project generation =>', ->

    source          = 'files/sources/s1'
    target          = 'files/targets/t1'
    inputs          = null
    travisUsername  = 'Chester Testerson'
    name            = 'AwesomeTestingExpressApp'

    createInputs = ->
      source          : source
      target          : target
      travisUsername  : travisUsername
      name            : name

    beforeEach ->
      inputs = createInputs()
      Gen(inputs, true)()

    afterEach (done) ->
#      done()
      rm('files/targets/', 't1', done)

    it 'check setup', ->
      expect(inputs).to.exist

    it 'should have created root dirs', ->
      exists(target, 'app', 'config', 'files', 'tests')

    it 'should have created app dirs', ->
      exists(target, 'app/models', 'app/libs', 'app/middleware', 'app/repos')

    it 'should have .gitignore file', ->
      exists(target, '.gitignore')

    it 'should have license file', ->
      exists(target, 'license')

    it 'should have .travis.yml file', ->
      exists(target, '.travis.yml')

    it 'should have readme.md file', ->
      exists(target, 'readme.md')

    it 'should have config/default.json file', ->
      exists(target, 'config/default.json')

    it 'should have index.js file', ->
      exists(target, 'index.js')

    it 'should have contains.css and reset.css file', ->
      within(target, 'app/public/css/').exists('contains.css', 'reset.css')

    it 'should have angular-1.2.js file', ->
      within(target, 'app/public/js').exists('angular-1.2.js')

    it 'should have HomeController file', ->
      exists(target, 'app/controllers/HomeController.coffee')

    it 'should have routes and server file', ->
      within(target, 'app/middleware').exists('routes.coffee', 'server.coffee')

    it 'should have app.coffee file', ->
      within(target, 'app').exists('app.coffee')