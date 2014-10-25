jest.dontMock "../Timer"
describe "Timer", ->
  Timer = require("../Timer")
  React = require("react/addons")
  TestUtils = React.addons.TestUtils
  timer = null
  beforeEach ->
    timer = TestUtils.renderIntoDocument(Timer())
    return

  it "increments seconds elapsed with each tick", ->
    expect(timer.state.secondsElapsed).toBe 0
    timer.tick()
    expect(timer.state.secondsElapsed).toBe 1
    return

  it "registers tick to run once each second", ->
    expect(setInterval.mock.calls.length).toBe 1
    expect(setInterval.mock.calls[0][0]).toBe timer.tick
    expect(setInterval.mock.calls[0][1]).toBe 1000
    return

  return
