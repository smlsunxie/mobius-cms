Timer = require("./Timer")

TodoList = React.createClass(
  render: ->
    createItem = (itemText) ->
      <li>{itemText}</li>
    <ul>{this.props.items.map(createItem)}</ul>

)

TodoApp = React.createClass(
  getInitialState: ->
    items: []
    text: ""

  onChange: (e) ->
    @setState text: e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    nextItems = @state.items.concat([@state.text])
    nextText = ""

    @setState
      items: nextItems
      text: nextText

  render: ->

    <div>
      <h3>TODO</h3>
      <TodoList items={this.state.items} />
      <form onSubmit={this.handleSubmit}>
        <input onChange={this.onChange} value={this.state.text} />
        <button>{'Add #' + (this.state.items.length + 1)}</button>
      </form>
      <Timer />
    </div>
)


module.exports = {
  app: TodoApp
  list: TodoList
}
