require("../../server/server.coffee")
lt = require("loopback-testing")

before (done) ->
  lt.beforeEach.withApp app
  done()
