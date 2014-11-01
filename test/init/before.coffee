process.env.NODE_ENV = "test"
require("../../server/server.coffee")
global.lt = require("loopback-testing")
global.chai = require('chai')
global.assert = chai.assert
global.should = chai.should()
global.async = require('async')


before (done) ->
  lt.beforeEach.withApp app
  Plugin = app.models.Plugin
  Route = app.models.Route

  async.waterfall [

    (done) ->
      plugin = new Plugin({url: "git@github.com:smlsunxie/cms-plugin-sample.git", name: "cms-plugin-sample"})
      Plugin.create plugin, (err, newPlugin) ->

        return done(err)

    (done) ->

      plugin = new Plugin({url: "https://github.com/smlsunxie/cms-plugin-routeList.git", name: "cms-plugin-routeList"})
      Plugin.create plugin, (err, newPlugin) ->

        return done(err)

  ], (error, result) ->
    done()
    return
