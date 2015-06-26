AtometerView = require './atometer-view'
{CompositeDisposable} = require 'atom'
AtometerTracker = require './atometer-tracker'

module.exports = Atometer =
  atometerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atometerView = new AtometerView()
    @stats = new AtometerTracker(state.stats, @atometerView)
    # console.log @atometerView
    @modalPanel = atom.workspace.addModalPanel(item: @atometerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atometer:toggle': => @toggle()

  # Add atometer to status bar to the right
  consumeStatusBar: (statusBar) ->
    # console.log @atometerView.element
    @statusBarTile = statusBar.addRightTile(item: @atometerView.element, priority: 0)
    # console.log @statusBarTile

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atometerView.destroy()
    @statusBarTile?.destroy()
    @statusBarTile = null


  serialize: ->
    stats: @stats.serialize()

  # Not currently used
  toggle: ->
    console.log 'Atometer was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
