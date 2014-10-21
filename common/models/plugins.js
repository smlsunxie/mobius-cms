module.exports = function(Plugins) {
  Plugins.install = function(url, name, cb) {
    console.log("url", url);
    console.log("name", name);
    cb(null, "install success!");
  };

  Plugins.remoteMethod("install", {
    accepts: [
      {arg: "url", type: "string", required: true},
      {arg: "name", type: "string", required: true}
    ],
    returns: {arg: "result", type: "string"},
    http: {verb: "get"}
  });

};
