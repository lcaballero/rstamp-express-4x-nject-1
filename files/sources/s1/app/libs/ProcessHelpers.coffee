async = require('async')
path  = require('path')
proc  = require('child_process')
spawn = proc.spawn
_     = require('lodash')


module.exports =

  run : (opts, _done) ->

    { options, commands, target } = opts or {}

    target        ?= '.'
    options       ?= {}
    options.cwd   ?= path.resolve(process.cwd(), target)
    options.stdio ?= [ process.stdin, process.stdout, process.stderr ]

    handleClose = (next) -> (code, signal) ->
      if code isnt 0
        next(new Error("code: #{code}, signal: #{signal}"))
      else if next? and code is 0
        next(null, code)

    handleProc = (e, cb) ->
      cmd   = _.head(e.args)
      args  = _.rest(e.args)
      proc  = spawn(cmd, args, options)

      proc.on('exit', handleClose(cb))

    async.mapSeries(commands, handleProc, (err, res) ->
      if err? then _done(err, null)
      else _done(null, res)
    )
