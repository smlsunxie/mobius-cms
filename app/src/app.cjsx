
React = window.React = require("react")
Router = require('react-router')
Route = Router.Route
Routes = Router.Routes
NotFoundRoute = Router.NotFoundRoute
DefaultRoute = Router.DefaultRoute

RouteStore = window.RouteStore = require('./stores/RouteStore');

Home = require("./components/Home")
Main = require("./components/Main")

window.modules = {}


app = React.createClass(

  render: ->
    createRoute = (route) ->
      <Route name="todo" handler={modules["todo"]}/>

    <Routes location="history">
      <Route name="app" path="/ui" handler={Main}>
        {@props.routes.map(createRoute)}
        <DefaultRoute handler={Home}/>
      </Route>
    </Routes>

)

mountNode = document.getElementById("app")

RouteStore.init(()->
  routes = RouteStore.getAll()
  React.renderComponent <app routes={routes} />, mountNode


)

module.exports = app
