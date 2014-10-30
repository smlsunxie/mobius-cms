var GLOBAL_CONFIG = require('../../global-config');

var host = process.env.REMOTE_HOST || "localhost"
var port = process.env.REMOTE_PORT || "3000"
var url = "http://"+host+":"+port+GLOBAL_CONFIG.restApiUrl


if(host === "localhost")
  url = GLOBAL_CONFIG.restApiUrl


console.log("remote url:", url);

var clientConfig = {
  remote: {
    url: url
  }
}

module.exports = clientConfig;
