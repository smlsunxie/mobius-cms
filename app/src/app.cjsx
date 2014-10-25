React = window.React = require("react")
Todo = require("./components/Todo")
Home = require("./components/Home")
Main = require("./components/Main")
mountNode = document.getElementById("app")



React.renderComponent Main.routes, mountNode
