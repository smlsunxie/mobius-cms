var sys = require('sys')
var exec = require('child_process').exec;
var Repo = require("git-tools");

var puts = function(error, stdout, stderr) { sys.puts(stdout) }

var module_home = "client/modules"



module.exports = function(Plugin) {
  var mountAction = function(name) {
    console.log("=== do mountAction ===");
    Plugin[name] = function(params, cb) {
      console.log("plugin testApi is run");
      cb(null, "get msg:"+ params);
    }
  }


  Plugin.install = function(url, name, cb) {
    // console.log("app.models.plugin", app.models.plugin.install);
    console.log("install command:", "git clone "+url+" "+module_home+"/"+name);

    Repo.clone({
      repo: url ,
      dir: module_home+"/"+name,
      bare: true
    }, function( error, repo ){



      var plugin = new Plugin({url: url, name: name})

      Plugin.create(plugin, function(err, newPlugin){
          mountAction("module.testApi");
          cb(err, newPlugin);
      })

    });

  };


  Plugin.action = function(name, params, cb) {
    console.log("=== call Plugin.action ===");
    console.log("Plugin.action name:", name);

    Plugin[name](params, function(error, result){
      cb(error, result)
    })
  };



  Plugin.remoteMethod("install", {
    accepts: [
      {arg: "url", type: "string", required: true},
      {arg: "name", type: "string", required: true}
    ],
    returns: {arg: "result", type: "object"}
    // http: {verb: "get"}
  });

  Plugin.remoteMethod("action", {
    accepts: [
      {arg: "name", type: "string", required: true},
      {arg: "params", type: "object"}
    ],
    returns: {arg: "result", type: "object"}
  });


};
