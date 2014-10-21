module.exports = mountRestApi = (server) ->
  console.log "mountRestApi"
  restApiRoot = server.get("restApiRoot")
  server.use restApiRoot, server.loopback.rest()
  return
