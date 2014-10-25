React = require("react")
div = React.DOM.div
Timer = React.createClass(
  getInitialState: ->
    return {secondsElapsed: 0}

  tick: ->
    @setState secondsElapsed: @state.secondsElapsed + 1
    return

  componentDidMount: ->
    @interval = setInterval(@tick, 1000)
    return

  componentWillUnmount: ->
    clearInterval @interval
    return

  render: ->
    div null, "Seconds Elapsed:"+ this.state.secondsElapsed
)
module.exports = Timer
