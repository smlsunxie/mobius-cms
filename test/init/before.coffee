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

        return done(err, newPlugin) if process.env.NODE_ENV is "test"

        try
          Plugin.mount "cms-plugin-sample", () ->
            return done(err, newPlugin)
        catch
          return done(err, newPlugin)

    (newPlugin, done) ->

      route = new Route(
        name: "todo"
        title: "todo"
        path: "todo"
        plugin: newPlugin
      )

      Route.create route, (err, newRoute) ->

        return done(err)




  ], (error, result) ->
    done()
    return
