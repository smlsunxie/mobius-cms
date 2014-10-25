React = window.React = require("react")
Router = require("react-router")
Todo = require("./ui/Todo")
mountNode = document.getElementById("app")


Route = Router.Route;
Routes = Router.Routes;


routes =
  <Routes>
    <Route handler={Todo.app} />
  </Routes>



React.renderComponent routes, mountNode
