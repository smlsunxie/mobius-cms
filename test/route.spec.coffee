describe "route", ->
  Plugin = app.models.plugin
  Route = app.models.route

  describe 'boot has route with plugin', ->

    it "find route with plugin", (done) ->
      Route.find {include: "plugin"}, (error, routes) ->

        (routes.length > 0).should.be.true
        routes[0].should.be.have.property "plugin"
        routes[0].plugin.should.be.Object
        done()

  describe  'boot has route with plugin by rest', ->

  lt.describe.whenCalledRemotely "get", "/api/routes?filter[include]=plugin", ->

    it "should have statusCode 200", ->
      assert.equal @res.statusCode, 200
      @res.body[0].should.be.have.property "plugin"
      @res.body[0].plugin.should.be.Object
