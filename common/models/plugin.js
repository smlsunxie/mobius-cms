var sys = require('sys')
var exec = require('child_process').exec;
var Repo = require("git-tools");
var fse = require('fs-extra');
var $q = require("bluebird");

var puts = function(error, stdout, stderr) { sys.puts(stdout) }

var module_home = "cms_modules"
var buildClientBundle = require("../../client/lbclient/build");
var buildViewModules = require('../../server/buildViewModules');




module.exports = function(Plugin) {
  

  Plugin.install = function(url, name, cb) {
    // console.log("app.models.Plugin", app.models.Plugin.install);
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




  Plugin.mount = function(moduleName, cb) {


    var mountModels = function(moduleName) {
      console.log("=== mountModels ====");
      var models = require("../../cms_modules/"+moduleName+"/config/models.coffee");

      models.forEach(function(model){
        app.models[model.name] = app.datasources.db.createModel(model.name, model.properties);
      });
    }

    var mountViews = function(moduleName) {
      console.log("=== mountViews ====");
      var defer = $q.defer();

      buildClientBundle(process.env.NODE_ENV || "development", function(result) {
        defer.resolve(result);
      })
      return defer.promise;
    }



    fse.copy(module_home+"/"+moduleName+"/dist", "client/modules/"+moduleName, function(error){
      // Create a open model that doesn't require predefined properties
      app.models.Route.mountActions(moduleName);
      mountModels(moduleName);
      mountViews(moduleName)
      .then(function(){

        buildViewModules(function(){
          return cb(null, {result: "ok"});
        })

      })

      .error(function(error){
        console.log("error", error);
        return cb(error, {result: "notok"});
      });


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



};
