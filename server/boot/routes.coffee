module.exports = (app) ->

  router = app.loopback.Router()
  router.get "/index", (req, res) ->
    res.render "index"

  app.use router
  return
