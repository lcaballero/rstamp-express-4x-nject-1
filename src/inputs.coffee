require('./globals')
qu    = require 'inquirer'
path  = require 'path'
gen   = require './generator'
cls   = require 'cli-color'


questions = (conf) ->
  dirName = path.basename(process.cwd())
  required   = (name) -> (input) ->
    if input? and input.trim().length then true
    else "A #{name} is required."


  [
    {
      name    : "target"
      type    : "input"
      message : "Where would you like to write the project?"
      default : '.'
    }
    {
      name    : "name"
      type    : "input"
      message : "What would you like to name the express app?"
      default : dirName
    }
    {
      name    : "version"
      type    : "input"
      message : "What version would you like to start the express app at?"
      default : "0.0.1"
    }
    {
      name      : "description"
      type      : "input"
      message   : "What description would you like to give the package?"
      validate  : required('description')
    }
    {
      name    : "entryPoint"
      type    : "input"
      message : "What entry point you like to provide?"
      default : "index.js"
    }
  ]

module.exports = (rstampConf) ->
  qu.prompt(questions(rstampConf or {}), (answers) ->
    answers.source = path.resolve(__dirname, "../files/sources/s1")
    opts = _.defaults({}, answers, rstampConf)
    gen(opts)()
  )
