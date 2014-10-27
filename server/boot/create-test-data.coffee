async = require "async"
module.exports = createTestData = (server) ->
  Plugin = server.models.Plugin
  Route = server.models.Route




  async.waterfall [
    (done) ->
      plugin = new Plugin({url: "git@github.com:smlsunxie/cms-plugin-sample.git", name: "cms-plugin-sample"})
      Plugin.create plugin, (err, newPlugin) ->
        Plugin.mount "cms-plugin-sample", () ->
          return done(err, newPlugin)


    (newPlugin, done) ->

      route = new Route(
        name: "todo"
        title: "todo"
        path: "todo"
        plugin: newPlugin
      )

      console.log "unsave route two :", route

      Route.create route, (err, newRoute) ->
        console.log "Route create!!"
        return done(err)




  ], (error, result) ->
    console.log "error", error
    return
