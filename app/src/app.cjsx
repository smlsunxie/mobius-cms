React = window.React = require("react")
Todo = require("./components/Todo")
Home = require("./components/Home")
Main = require("./components/Main")
mountNode = document.getElementById("app")


# client = (->
#
#   require('lbclient');
# )();

console.log "client", client


React.renderComponent Main.routes, mountNode
