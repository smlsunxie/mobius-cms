assert = require('chai').assert
should = require('chai').should()
lt = require("loopback-testing")
Plugin = app.models.plugin


describe "/plugins", ->


  describe 'install plugin', ->
    # lt.describe.whenCalledRemotely "POST", "/api/plugins/install",
    # { url:"git@github.com:smlsunxie/cms-plugin-sample.git", name:"plugin-react-dateGridTool"}, ->
    #
    #   lt.it.shouldBeAllowed()
    #   it "should have statusCode 200", ->
    #     assert.equal @res.statusCode, 200

    it "execute install", (done) ->

      app.models.plugin.install "git@github.com:smlsunxie/cms-plugin-sample.git", "cms-plugin-sample", (error, newPlugin) ->
        newPlugin.should.be.Object
        done();

    it "plugin has save", (done) ->

      Plugin.find {}, (err, plugins) ->
        (plugins.length > 0).should.be.true
        done()

  describe.only 'mount plugin', ->

    it "execute mount", (done) ->
      app.models.plugin.mount "cms-plugin-sample", (error, result) ->

        Plugin.should.have.property("module.testApi")
        done()


    lt.describe.whenCalledRemotely "POST", "/api/plugins/action", {name:"module.testApi"}, ->

      it "should have statusCode 200", ->
        assert.equal @res.statusCode, 200
        @res.body.should.have.property("result")
