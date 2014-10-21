module.exports = enableAuthentication = (server) ->
  console.log "enableAuthentication"
  # enable authentication
  server.enableAuth()
  return
