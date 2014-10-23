var sys = require('sys')
var exec = require('child_process').exec;
var Repo = require("git-tools");
var fse = require('fs-extra')

var puts = function(error, stdout, stderr) { sys.puts(stdout) }

var module_home = "cms_modules"





module.exports = function(Plugin) {


  Plugin.install = function(url, name, cb) {
    // console.log("app.models.plugin", app.models.plugin.install);
    console.log("install command:", "git clone "+url+" "+module_home+"/"+name);


    fse.remove(module_home+"/"+name, function(){
      Repo.clone({
        repo: url ,
        dir: module_home+"/"+name,
      }, function( error, repo ){

        exec("cd "+module_home+"/"+name+" && npm i && bower i && gulp build", function(error, stdout, stderr){
          console.log(error);
          console.log(stdout);
          console.log(stderr);

          // fse.copy(module_home+"/"+name+"/dist")

          var plugin = new Plugin({url: url, name: name})

          Plugin.create(plugin, function(err, newPlugin){
            cb(err, newPlugin);
          });


        });
      });
    })



  };


  Plugin.action = function(name, params, cb) {
    console.log("=== call Plugin.action ===");
    console.log("Plugin.action name:", name);

    Plugin[name](params, function(error, result){
      cb(error, result)
    })
  };


  Plugin.mount = function(name, cb) {

    var mountAction = function(name) {
      console.log("=== do mountAction ===");
      Plugin[name] = function(params, cb) {
        console.log("plugin testApi is run");
        cb(null, "get msg:"+ params);
      }
    }

    mountAction("module.testApi");


    fse.copy(module_home+"/"+name+"/dist", "client/modules/"+name, function(error){
      // Create a open model that doesn't require predefined properties
      var models = require("../../client/modules/"+name+"/config/model.coffee");

      models.forEach(function(model){
        app.models[model.name] = app.datasources.db.createModel(model.name, model.properties);
      });


      cb();
    });






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
