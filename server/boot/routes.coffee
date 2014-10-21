module.exports = (app) ->
  console.log "set router"
  router = app.loopback.Router()
  router.get "/module_a", (req, res) ->
    console.log "/module_a touch ~~~~~~~~~~"
    res.render "index"
    return



  app.use router
  return
