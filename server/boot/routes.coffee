module.exports = (app) ->

  router = app.loopback.Router()
  router.get "/ui", (req, res) ->
    res.render "index"

  router.get "/ui/*", (req, res) ->
    res.render "index"

  app.use router
  return
