
describe "/plugins", ->
  Plugin = app.models.Plugin
  Route = app.models.Route

  describe 'install plugin', ->

    it "execute install", (done) ->

      app.models.Plugin.install "git@github.com:smlsunxie/cms-plugin-sample.git", "cms-plugin-sample", (error, newPlugin) ->
        newPlugin.should.be.Object
        done();

    it "plugin has save", (done) ->

      Plugin.find {}, (err, plugins) ->
        (plugins.length > 0).should.be.true
        done()

  describe.only 'mount plugin', ->

    it "execute mount", (done) ->
      app.models.Plugin.mount "cms-plugin-sample", (error, result) ->
        console.log "Route", Route


        Route.modules.should.have.property("cms-plugin-sample")
        Route.modules["cms-plugin-sample"].should.have.property("testAction")
        done()

    it "can access dynamic model", (done) ->
      Form = app.models.Form
      Form.should.be.Object
      done()

    it "can create dynamic model", (done) ->
      Form = app.models.Form
      Form.create {name: "testForm"}, (error, newForm) ->
        newForm.should.be.Object

        Form.find {}, (error, forms) ->
          (forms.length > 0).should.be.true
          done()


    lt.describe.whenCalledRemotely "POST", "/api/routes/action", {
      moduleName:"cms-plugin-sample"
      actionName:"testAction"
    }, ->

      it "should have statusCode 200", ->
        assert.equal @res.statusCode, 200
        @res.body.should.have.property("result")
