
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


mountNode = document.getElementById("app")

RouteStore.init(()->
  routes = RouteStore.getAll()
  createRoute = (route) ->
    <Route name="todo" handler={modules["todo"]}/>

  routesCmp =
    <Routes location="history">
      <Route name="app" path="/ui" handler={Main}>
        {routes.map(createRoute)}
        <DefaultRoute handler={Home}/>
      </Route>
    </Routes>

  React.renderComponent routesCmp, mountNode
)
