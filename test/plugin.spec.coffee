assert = require('chai').assert
should = require('chai').should()
lt = require("loopback-testing")
Plugin = app.models.plugin

# assert = chai.assert

describe "/plugins", ->


  describe.only 'install plugin', ->
    it "execute install", (done) ->

      app.models.plugin.install "webUrl", "testInstallPlugin", (error, newPlugin) ->
        newPlugin.should.be.Object
        done();

    it "plugin has save", (done) ->

      Plugin.find {}, (err, plugins) ->
        (plugins.length > 0).should.be.true
        done()

    it "plugin has mount customize function", (done) ->

      Plugin.should.have.property("module.testApi")
      done()


    lt.describe.whenCalledRemotely "POST", "/api/plugins/action", {name:"module.testApi"}, ->

      it "should have statusCode 200", ->
        assert.equal @res.statusCode, 200
        @res.body.should.have.property("result")

    lt.describe.whenCalledRemotely "POST", "/api/plugins/install",
    { url:"git@github.com:smlsunxie/plugin-react-dateGridTool.git", name:"plugin-react-dateGridTool"}, ->

      lt.it.shouldBeAllowed()
      it "should have statusCode 200", ->
        assert.equal @res.statusCode, 200

    # it "wait", (done) ->
