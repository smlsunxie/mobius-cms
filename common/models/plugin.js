var sys = require('sys')
var exec = require('child_process').exec;
var puts = function(error, stdout, stderr) { sys.puts(stdout) }

var module_home = "client/modules"



module.exports = function(Plugin) {
  Plugin.install = function(url, name, cb) {

    console.log("app.models.plugin", app.models.plugin.install);
    console.log("install command:", "git clone "+url+" "+module_home+"/"+name);

    // exec("git clone "+url+" "+module_home+"/"+name, puts);



    console.log("url", url);
    console.log("name", name);
    cb(null, "install success!");
  };

  Plugin.remoteMethod("install", {
    accepts: [
      {arg: "url", type: "string", required: true},
      {arg: "name", type: "string", required: true}
    ],
    returns: {arg: "result", type: "string"},
    http: {verb: "get"}
  });

};
