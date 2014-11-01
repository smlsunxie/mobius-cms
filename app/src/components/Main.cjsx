Router = require('react-router')

Link = Router.Link

module.exports = React.createClass(
  getInitialState: ->
    that = @
    return routes: RouteStore.getAll()

  render: ->
    createUl = (route) ->
      <li><Link to={route.name} >{route.title}</Link></li>


    console.log 'modules["foot"]', modules["foot"]

    <div>
      <header>
        <ul className="nav nav-pills">
          <li><Link to="app">Dashboard</Link></li>

          {@state.routes.map(createUl)}
        </ul>

      </header>

      <this.props.activeRouteHandler/>

      <footer>
        {if modules["foot"] then modules["foot"]() }
      </footer>

    </div>


)
