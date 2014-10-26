React = window.React = require("react")

Home = require("./Home")

RouteStore = require('../stores/RouteStore');

Router = require('react-router')
Route = Router.Route
Routes = Router.Routes
NotFoundRoute = Router.NotFoundRoute
DefaultRoute = Router.DefaultRoute
Link = Router.Link
Main = {}
Main.app = React.createClass(
  getInitialState: ->
    that = @
    return routes: RouteStore.getAll()

  render: ->
    createUl = (route) ->
      <li><Link to={route.name} >{route.title}</Link></li>



    <div>
      <header>
        <ul>
          <li><Link to="app">Dashboard</Link></li>

          {@state.routes.map(createUl)}
        </ul>

      </header>

      <this.props.activeRouteHandler/>
    </div>


)



mountNode = document.getElementById("app")

RouteStore.init(()->
  routes = RouteStore.getAll()
  createRoute = (route) ->
    <Route name="todo" handler={modules["todo"]}/>

  Main.routes =
    <Routes location="history">
      <Route name="app" path="/ui" handler={Main.app}>
        {routes.map(createRoute)}
        <DefaultRoute handler={Home}/>
      </Route>
    </Routes>

  React.renderComponent Main.routes, mountNode
)


module.exports = Main
