# http = require('http')
# browserify = require('browserify')
# literalify = require('literalify')
# React = require('react')
# MyApp = React.createFactory(require('./app/scripts/app'))
#
#

module.exports = (app) ->

  router = app.loopback.Router()
  router.get "/ui", (req, res) ->
    res.render "index"

  router.get "/ui/*", (req, res) ->
    res.render "index"

  app.use router
  return
