

module.exports = function(Route) {
  Route.modules = {}
  Route.mountActions = function(moduleName) {

    try{
      console.log("=== mountActions ====");
      var actions = require("../../cms_modules/"+moduleName+"/config/actions.coffee");

      Route.modules[moduleName] = {}
      Route.modules[moduleName].app = app

      actions.forEach(function(action){
        console.log("mount Route.actio:", moduleName, action.name);
        Route.modules[moduleName][action.name] = action.execution
      });

    }catch(error){
      console.log("mountActions error", error);
    }

  }

  Route.action = function(moduleName, actioName, params, cb) {

    console.log("action info :", moduleName, actioName);

    Route.modules[moduleName][actioName](params, function(error, result){
      cb(error, result)
    })
  };


  Route.remoteMethod("action", {
    accepts: [
      {arg: "moduleName", type: "string", required: true},
      {arg: "actionName", type: "string", required: true},
      {arg: "params", type: "object"}
    ],
    returns: {arg: "result", type: "object"}
  });


  Route.createTestData = function(newPlugin, cb){

    var pluginPkgInfo = require('../../cms_modules/'+newPlugin.name+'/package.json');
    console.log('pluginPkgInfo["route"]', pluginPkgInfo["route"]);
    if(pluginPkgInfo["route"] === undefined)
      return cb();

    var route = new Route({
      name: pluginPkgInfo.route.name,
      title: pluginPkgInfo.route.title,
      path: pluginPkgInfo.route.path,
      plugin: newPlugin
    });



    Route.create(route, function(err, newRoute) {

      return cb(err, newRoute);
    });


  }



};
