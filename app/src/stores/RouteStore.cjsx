EventEmitter = require('events').EventEmitter;
merge = require('react/lib/merge');

TodoStore = merge(EventEmitter.prototype,
  getAll: () ->
    return []
)

module.exports = TodoStore
