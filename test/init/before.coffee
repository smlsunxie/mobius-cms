require("../../server/server.coffee")
global.lt = require("loopback-testing")
global.assert = require('chai').assert
global.should = require('chai').should()


before (done) ->
  lt.beforeEach.withApp app
  done()
