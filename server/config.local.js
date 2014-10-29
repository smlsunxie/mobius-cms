var GLOBAL_CONFIG = require('../global-config');

var isDevEnv = (process.env.NODE_ENV || 'development') === 'development';

var host = process.env.MOBIUS_1_PORT_3000_TCP_ADDR || "127.0.0.1"
var port = process.env.MOBIUS_1_PORT_3000_TCP_PORT || "3000"



module.exports = {
  host: host,
  port: port,
  restApiRoot: GLOBAL_CONFIG.restApiRoot,
  livereload: process.env.LIVE_RELOAD,
  isDevEnv: isDevEnv
};
