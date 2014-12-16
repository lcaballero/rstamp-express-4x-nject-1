spawn = require('child_process').spawn

spawn('./node_modules/.bin/node-dev', ['--no-deps', './app/app.coffee'], { stdio: 'inherit' })

