var GLOBAL_CONFIG = require('../../global-config');

var host = process.env.REMOTE_HOST || "127.0.0.1"
var port = process.env.REMOTE_PORT || "3000"

console.log("remote url:", "http://"+host+":"+port+GLOBAL_CONFIG.restApiUrl);

var clientConfig = {
  remote: {
    url: "http://"+host+":"+port+GLOBAL_CONFIG.restApiUrl
  }
}

module.exports = clientConfig;
