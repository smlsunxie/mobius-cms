describe "boot", ->
  Plugin = app.models.plugin
  Route = app.models.route

  describe 'has route with plugin', ->

    it "find route with plugin", (done) ->
      Route.find {include: "plugin"}, (error, routes) ->

        (routes.length > 0).should.be.true
        routes[0].should.be.have.property "plugin"
        routes[0].plugin.should.be.Object
        done()
