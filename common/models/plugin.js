var sys = require('sys')
var exec = require('child_process').exec;
var puts = function(error, stdout, stderr) { sys.puts(stdout) }

var module_home = "client/modules"



module.exports = function(Plugin) {
  var mountAction = function() {
    console.log("=== do mountAction ===");
    Plugin.testApi = function(msg, cb) {
      console.log("testApi is run");
      cb(null, "get msg:"+ msg);
    }


    Plugin.remoteMethod("testApi", {
      accepts: [
        {arg: "msg", type: "string", required: true}
      ],
      returns: {arg: "result", type: "string"},
      http: {verb: "get"}
    });

  }


  Plugin.install = function(url, name, cb) {
    // console.log("app.models.plugin", app.models.plugin.install);
    console.log("install command:", "git clone "+url+" "+module_home+"/"+name);

    // exec("git clone "+url+" "+module_home+"/"+name, puts);

    var plugin = new Plugin({url: url, name: name})


    Plugin.create(plugin, function(err, newPlugin){
        mountAction();
        cb(err, newPlugin);
    })
  };



  Plugin.remoteMethod("install", {
    accepts: [
      {arg: "url", type: "string", required: true},
      {arg: "name", type: "string", required: true}
    ],
    returns: {arg: "result", type: "object"},
    http: {verb: "get"}
  });

};
