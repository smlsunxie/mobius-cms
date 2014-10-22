assert = require('chai').assert
lt = require("loopback-testing")

# assert = chai.assert

describe "/plugins", ->

  lt.describe.whenCalledRemotely "GET", "/api/plugins/install?url=webUrl&name=testInstallPlugin", ->

    lt.it.shouldBeAllowed()
    it "should have statusCode 200", ->
      assert.equal @res.statusCode, 200

  it "call plugins.install directly", (done) ->
    app.models.plugin.install "webUrl", "testInstallPlugin", () ->
      done();
