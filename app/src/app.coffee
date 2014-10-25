###*
@jsx React.DOM
###
React = window.React = require("react")
Timer = require("./ui/Timer")
mountNode = document.getElementById("app")
Router = require("react-router")

div = React.DOM.div
h3 = React.DOM.h3
form = React.DOM.form;
input = React.DOM.input;
button = React.DOM.button;
ul = React.DOM.ul;
li = React.DOM.li;



console.log "hello!!"

TodoList = React.createClass(
  render: ->

    createItem = (itemText) ->
      li null, itemText


    ul null, this.props.items.map(createItem)

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
    return div(null, [
      h3(null, "TODO")
      TodoList(items: this.state.items)
      form(onSubmit: this.handleSubmit,[
        input({onChange: this.onChange, value: this.state.text})
        button null, 'Add #' + (this.state.items.length + 1)
      ])
      Timer()
    ])
)

console.log("mountNode", mountNode);
React.renderComponent TodoApp(), mountNode
