EventEmitter = require('events').EventEmitter;
merge = require('react/lib/merge');

RouteStore = merge(EventEmitter.prototype,
  routes: []
  init: (cb) ->
    that = this

    client.models.Route.find {include: "plugin"}, (error, routes)->
      that.routes = routes
      return cb()


  getAll: () ->
    return @routes
)

module.exports = RouteStore
