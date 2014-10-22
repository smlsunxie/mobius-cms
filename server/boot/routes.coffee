module.exports = (app) ->
  console.log "set router"
  router = app.loopback.Router()
  router.get "/modules", (req, res) ->
    console.log "/modules touch ~~~~~~~~~~"
    res.render "index"
    return



  app.use router
  return
