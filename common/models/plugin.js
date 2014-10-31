var sys = require('sys')
var exec = require('child_process').exec;
var Repo = require("git-tools");
var fse = require('fs-extra');
var $q = require("bluebird");



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

        console.log("error", error);
        console.log("repo", repo);

        var plugin = new Plugin({url: url, name: name})

        Plugin.create(plugin, function(err, newPlugin){
          Plugin.mount(name, function(err, result){
            result.plugin = newPlugin
            app.models.Route.createTestData(newPlugin, function(){
              cb(err, result);
            })
          })
        });


      });
    })



  };




  Plugin.mount = function(moduleName, cb) {

    var pluginPkgInfo = require('../../cms_modules/'+moduleName+'/package.json');

    console.log("pluginPkgInfo", pluginPkgInfo);


    var mountModels = function(moduleName) {

      var file = "../../cms_modules/"+pluginPkgInfo.name+"/config/models.coffee";

      fse.ensureFile(file, function(err) {
        if(err){
          console.log("error", err);
          return
        }
        var models = require("../../cms_modules/"+pluginPkgInfo.name+"/config/models.coffee");

        models.forEach(function(model){
          var ModuleModel = app.datasources.db.createModel(model.name, model.properties);
          app.model(ModuleModel);
          app.use(loopback.rest());

        });
      })

    }

    var mountViews = function(moduleName) {
      console.log("=== mountViews ====");
      var defer = $q.defer();

      // buildClientBundle(process.env.NODE_ENV || "development", function(result) {
      //   defer.resolve(result);
      // })

      var mainFiles = pluginPkgInfo.main


      var bundleFiles = mainFiles.map(function (file) {
        return "./cms_modules/" + moduleName + "/" + file
      })

      fse.ensureDir("../../cms_modules/" + moduleName, function(err) {
        if(err){
          console.log("error", err);
          return defer.resolve();
        }


        buildViewModules(bundleFiles,function(){
          return defer.resolve();
        });
      });


      return defer.promise;
    }



    fse.copy(module_home+"/"+moduleName+"/dist", "client/modules/"+moduleName, function(error){
      // Create a open model that doesn't require predefined properties
      app.models.Route.mountActions(moduleName);
      mountModels(moduleName);
      mountViews(moduleName)
      .then(function(){
        return cb(null, {success: true});
      })

      .error(function(error){
        return cb(error, {success: false});
      });


    });

  };

  Plugin.info = function(id, cb) {

    var info = {}

    Plugin.findOne({id: id}, function(error, plugin){
      info.plugin = plugin
      var models = require("../../cms_modules/"+plugin.name+"/config/models.coffee");
      var actions = require("../../cms_modules/"+plugin.name+"/config/actions.coffee");

      info.plugin = plugin

      info.models = models
      info.actions = actions

      return cb(error, info);
    })

  }

  Plugin.remoteMethod("install", {
    accepts: [
      {arg: "url", type: "string", required: true},
      {arg: "name", type: "string", required: true}
    ],
    returns: {arg: "result", type: "object"},
    http: {verb: "get"}
  });

  Plugin.remoteMethod("info", {
    accepts: [
      {arg: "id", type: "string", required: true}
    ],
    returns: {arg: "result", type: "object"},
    http: {verb: "get"}
  });




};
