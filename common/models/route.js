

module.exports = function(Route) {
  Route.modules = {}
  Route.mountActions = function(moduleName) {

    console.log("=== mountActions ====");
    var actions = require("../../cms_modules/"+moduleName+"/config/actions.coffee");

    Route.modules[moduleName] = {}
    Route.modules[moduleName].app = app

    actions.forEach(function(action){
      console.log("mount Route.actio:", moduleName, action.name);
      Route.modules[moduleName][action.name] = action.execution
    });

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


};
