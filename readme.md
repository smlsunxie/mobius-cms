# MOBIUS CMS

## framework and library used

* [loopback](http://loopback.io/)
	* [Model Driven Development](http://strongloop.com/strongblog/node-js-api-tip-model-driven-development/)
	* [isomorphic](http://strongloop.com/strongblog/node-js-loopback-2-0-whats-new/#Isomorphic%20LoopBack)
	* front end and server side share same Model and function
	* authentication and authorization setup

* [browserify](http://browserify.org/)
	* dynamic bundle  library and front end component

## plugin base

* support plugin install without restart server
* front end use react and  browserify bondle to front page
* dynamic setup orm model
* dynamic setup plugin backend rest action
* dynamic front end and backend  routing


# Install and Run

* ``npm install``
* ``bower install``
* ``gulp``
* ``coffee server/server.coffee``

after install, we can access web site by:

[http://localhost:3000/ui](http://localhost:3000/ui)

the initial page like above picture:

![enter image description here](https://lh6.googleusercontent.com/-4Vy9caO8M9k/VE8P5Ff29DI/AAAAAAAAPyY/irA1XRuDCmM/s0/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7+2014-10-28+%E4%B8%8A%E5%8D%8811.32.13.png "螢幕快照 2014-10-28 上午11.32.13.png")

# Install plugin in runtime

install plugin [cms-plugin-sample](https://github.com/smlsunxie/cms-plugin-sample), that is a todo list.

we can install by below rest api:

[http://localhost:3000/api/Plugins/install?url=git@github.com:smlsunxie/cms-plugin-sample.git&name=cms-plugin-sample](http://localhost:3000/api/Plugins/install?url=git@github.com:smlsunxie/cms-plugin-sample.git&name=cms-plugin-sample)

sample result like:

```
{
  result: {
    success: true,
    plugin: {
      name: "cms-plugin-sample",
      url: "git@github.com:smlsunxie/cms-plugin-sample.git",
      id: 1
    }
  }
}
```

then reload again [http://localhost:3000/ui](http://localhost:3000/ui)

the preview page above :

![enter image description here](https://lh6.googleusercontent.com/-iDpagqQMB0s/VE8P-8IrMvI/AAAAAAAAPyk/C9cJozsGTgE/s0/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7+2014-10-28+%E4%B8%8A%E5%8D%8811.38.06.png "螢幕快照 2014-10-28 上午11.38.06.png")


you can check plugin info by visit: http://localhost:3000/api/Plugins/info?id=1

sample result:

```
{
  "result": {
    "plugin": {
      "name": "cms-plugin-sample",
      "url": "git@github.com:smlsunxie\/cms-plugin-sample.git",
      "id": 1
    },
    "models": [
      {
        "name": "ModuleTodo",
        "properties": {
          "name": {
            "type": "string"
          },
          "id": {
            "id": 1,
            "generated": true
          }
        }
      }
    ],
    "actions": [
      {
        "name": "testAction"
      },
      {
        "name": "get"
      },
      {
        "name": "post"
      }
    ]
  }
}
```
