var sys = require('sys')
var exec = require('child_process').exec;
var Repo = require("git-tools");
var fse = require('fs-extra')

var puts = function(error, stdout, stderr) { sys.puts(stdout) }

var module_home = "cms_modules"





module.exports = function(Plugin) {
  Plugin.modules = {};

  Plugin.install = function(url, name, cb) {
    // console.log("app.models.plugin", app.models.plugin.install);
    console.log("install command:", "git clone "+url+" "+module_home+"/"+name);


    fse.remove(module_home+"/"+name, function(){
      Repo.clone({
        repo: url ,
        dir: module_home+"/"+name,
      }, function( error, repo ){


          var plugin = new Plugin({url: url, name: name})

          Plugin.create(plugin, function(err, newPlugin){
            cb(err, newPlugin);
          });


      });
    })



  };


  Plugin.action = function(moduleName, actioName, params, cb) {
    console.log("=== call Plugin.action ===");
    console.log("action info :", moduleName, actioName);

    Plugin.modules[moduleName][actioName](params, function(error, result){
      cb(error, result)
    })
  };


  Plugin.mount = function(moduleName, cb) {

    var mountActions = function(moduleName) {
      var actions = require("../../cms_modules/"+moduleName+"/config/actions.coffee");

      Plugin.modules[moduleName] = {}
      Plugin.modules[moduleName].app = app

      actions.forEach(function(action){
        Plugin.modules[moduleName][action.name] = action.execution
      });

    }

    var mountModels = function(moduleName) {
      var models = require("../../cms_modules/"+moduleName+"/config/models.coffee");

      models.forEach(function(model){
        app.models[model.name] = app.datasources.db.createModel(model.name, model.properties);
      });
    }


    fse.copy(module_home+"/"+moduleName+"/dist", "client/modules/"+moduleName, function(error){
      // Create a open model that doesn't require predefined properties
      mountActions(moduleName);
      mountModels(moduleName);

      cb(null, {result: "ok"});
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
      {arg: "moduleName", type: "string", required: true},
      {arg: "actionName", type: "string", required: true},
      {arg: "params", type: "object"}
    ],
    returns: {arg: "result", type: "object"}
  });


};
