module.exports = do ->
  require('./deps').resolve((err, resolved) ->
    if err?
      console.log('Failed to resolve DI tree.', err)
    else
      { server, config } = resolved
      { port } = config
      app = server.listen(port, ->
        console.log('Listening on port %d', app.address().port)
      )
  )
