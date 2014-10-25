React = window.React = require("react")
Todo = require("./ui/Todo")
Home = require("./ui/Home")
mountNode = document.getElementById("app")


Router = require('react-router')
Route = Router.Route
Routes = Router.Routes
NotFoundRoute = Router.NotFoundRoute
DefaultRoute = Router.DefaultRoute
Link = Router.Link

App = React.createClass(
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

routes =
  <Routes location="history">
    <Route name="app" path="/ui" handler={App}>
      <Route name="todo" handler={Todo.app}/>
      <DefaultRoute handler={Home}/>
    </Route>
  </Routes>



React.renderComponent routes, mountNode
