describe "route", ->
  Plugin = app.models.Plugin
  Route = app.models.Route

  describe 'boot has route with plugin', ->

    it "find route with plugin", (done) ->
      Route.find {include: "plugin"}, (error, routes) ->

        (routes.length > 0).should.be.true
        routes[0].should.be.have.property "plugin"
        routes[0].plugin.should.be.Object
        done()

  describe  'boot has route with plugin by rest', ->

    lt.describe.whenCalledRemotely "get", "/api/Routes?filter[include]=plugin", ->

      it "should have statusCode 200", ->
        assert.equal @res.statusCode, 200
        @res.body[0].should.be.have.property "plugin"
        @res.body[0].plugin.should.be.Object

  describe.only "create route by plugin", ->


    it "should have route",(done) ->
      Plugin.find {}, (error, plugins) ->

        console.log "Plugins[0]", plugins[0]

        Route.createTestData plugins[0], (err, newRoute)->
          newRoute.should.be.a.Object
          done()
