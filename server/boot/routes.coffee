module.exports = (app) ->
  console.log "set router"
  router = app.loopback.Router()
  router.get "/modules", (req, res) ->
    params = {
      module: {
        name: "cms-plugin-sample"
      }
    }

    res.render "index", {params: params}



  app.use router
  return
