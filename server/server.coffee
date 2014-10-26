require "coffee-script/register"
global.loopback = require("loopback")
boot = require("loopback-boot")
global.app = module.exports = loopback()

# middleware
app.use loopback.compress()

# it's important to register the livereload middleware
# after any response-processing middleware like compress,
# but before any middleware serving actual content
livereload = app.get("livereload")
app.use require("connect-livereload")(port: livereload)  if livereload

# boot scripts mount components like REST API
boot app, __dirname

# Mount static files like ngapp
# All static middleware should be registered at the end, as all requests
# passing the static middleware are hitting the file system
# app.use loopback.static(path.dirname(app.get("indexFile")))
path = require("path")
app.use loopback.static(path.resolve(__dirname, "../client"))
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# Requests that get this far won't be handled
# by any middleware. Convert them into a 404 error
# that will be handled later down the chain.
app.use loopback.urlNotFound()

# The ultimate error handler.
app.use loopback.errorHandler()

# optionally start the app
app.start = ->

  # start the web server
  app.listen ->
    app.emit "started"
    console.log "Web server listening at: %s", app.get("url")
    return


app.start()  if require.main is module
