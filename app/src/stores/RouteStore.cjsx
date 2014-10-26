EventEmitter = require('events').EventEmitter;
merge = require('react/lib/merge');

TodoStore = merge(EventEmitter.prototype,
  getAll: () ->
    client.models.Todo.find {}, (error, todos)->
      console.log "todos", todos

      return todos
)

module.exports = TodoStore
