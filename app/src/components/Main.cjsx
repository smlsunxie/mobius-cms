React = window.React = require("react")
Todo = require("./Todo")
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
    data: RouteStore.getAll()

  render: ->
    <div>
      <header>
        <ul>
          <li><Link to="app">Dashboard</Link></li>
          <li><Link to="todo">todo</Link></li>
        </ul>

      </header>

      <this.props.activeRouteHandler/>
    </div>


)

Main.routes =
  <Routes location="history">
    <Route name="app" path="/ui" handler={Main.app}>
      <Route name="todo" handler={Todo.app}/>
      <DefaultRoute handler={Home}/>
    </Route>
  </Routes>

module.exports = Main
