module.exports = function(Plugins) {

  Plugins.install = function(msg, cb) {
    cb(null, "test Plugins.install")
  }

  Plugins.remoteMethod(
        'install',
        {
          accepts: {arg: 'msg', type: 'string'},
          returns: {arg: 'greeting', type: 'string'}
        }
    );


};
