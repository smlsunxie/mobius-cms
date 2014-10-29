var GLOBAL_CONFIG = require('../../global-config');

var host = process.env.MOBIUS_1_PORT_3000_TCP_ADDR || "127.0.0.1"
var port = process.env.MOBIUS_1_PORT_3000_TCP_PORT || "3000"

var clientConfig = {
  remote: {
    url: "http://"+host+":"+port+GLOBAL_CONFIG.restApiUrl
  }
}

module.exports = clientConfig;
