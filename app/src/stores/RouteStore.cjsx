EventEmitter = require('events').EventEmitter;
merge = require('react/lib/merge');

TodoStore = merge(EventEmitter.prototype,
  getAll: () ->
    client.models.Route.find {include: "plugin"}, (error, routes)->
      console.log "routes", routes

      return routes
)

module.exports = TodoStore
