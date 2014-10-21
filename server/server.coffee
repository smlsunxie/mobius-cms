require "coffee-script/register"
loopback = require("loopback")
boot = require("loopback-boot")
app = module.exports = loopback()

# Set up the /favicon.ico
app.use loopback.favicon()

# request pre-processing middleware
app.use loopback.compress()

# -- Add your pre-processing middleware here --

# boot scripts mount components like REST API
boot app, __dirname

# -- Mount static files here--
# All static middleware should be registered at the end, as all requests
# passing the static middleware are hitting the file system
# Example:
path = require("path")
app.use loopback.static(path.resolve(__dirname, "../client"))
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# app.engine('html', require('ejs').renderFile);
# app.engine('.html', require('jade').__express);
# app.set('json spaces', 2); //pretty print json responses

# Requests that get this far won't be handled
# by any middleware. Convert them into a 404 error
# that will be handled later down the chain.
app.use loopback.urlNotFound()

# The ultimate error handler.
app.use loopback.errorHandler()
app.start = ->

  # start the web server
  app.listen ->
    app.emit "started"
    console.log "Web server listening at: %s", app.get("url")
    return



# start the server if `$ node server.js`
app.start()  if require.main is module
