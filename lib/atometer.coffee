AtometerView = require './atometer-view'
{CompositeDisposable} = require 'atom'
AtometerTracker = require './atometer-tracker'

module.exports = Atometer =
  atometerView: null
  stats: null
  subscriptions: null

  activate: (state) ->
        @subscriptions = new CompositeDisposable
        @atometerView = new AtometerView()
        @stats = new AtometerTracker(state.stats, @atometerView)
        @subscriptions.add atom.commands.add 'atom-workspace',
                'atometer:reset': => @stats.reset()

  consumeStatusBar: (statusBar) ->
        @statusBarTile = statusBar.addRightTile(item: @atometerView.element, priority: 0)

  deactivate: ->
        @atometerView.destroy()
        @statusBarTile?.destroy()
        @statusBarTile = null
        @subscriptions.dispose()

  serialize: ->
        stats: @stats.serialize()
