AtometerView = require './atometer-view'
{CompositeDisposable} = require 'atom'
AtometerTracker = require './atometer-tracker'

module.exports = Atometer =
  atometerView: null
  stats: null

  activate: (state) ->
    @atometerView = new AtometerView()
    @stats = new AtometerTracker(state.stats, @atometerView)

  consumeStatusBar: (statusBar) ->
    @statusBarTile = statusBar.addRightTile(item: @atometerView.element, priority: 0)

  deactivate: ->
    @atometerView.destroy()
    @statusBarTile?.destroy()
    @statusBarTile = null

  serialize: ->
    stats: @stats.serialize()
