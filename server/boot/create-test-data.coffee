async = require "async"
module.exports = createTestData = (server) ->
  Plugin = server.models.Plugin
  Route = server.models.Route




  async.waterfall [
    (done) ->
      return done()
  ], (error, result) ->
    console.log "error", error
    return
