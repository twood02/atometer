# module.exports =
#   activate: ->
#           atom.commands.add 'atom-workspace', "atometer:convert", => @convert()
#
#   convert: ->
#         # This assumes the active pane item is an editor
#         editor = atom.workspace.getActivePaneItem()
#         editor.insertText('Hello, World!')

AtometerView = require './atometer-view'
{CompositeDisposable} = require 'atom'
AtometerTracker = require './atometer-tracker'
# AtometerTileView = require './atometer-tile-view'

module.exports = Atometer =
  atometerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atometerView = new AtometerView(state.atometerViewState)
    @stats = new AtometerTracker(@atometerView)
    # @atometerView.test("blah")
    console.log @atometerView
    @modalPanel = atom.workspace.addModalPanel(item: @atometerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atometer:toggle': => @toggle()

  consumeStatusBar: (statusBar) ->
    console.log "consume status bar: "
    console.log @atometerView.element
    # @atometerTileView = new AtometerTileView()
    # console.log @atometerTileView
    # @atometerTileView.initialize(@stats)
    # @statusBarTile = statusBar.addLeftTile(item: @atometerTileView, priority: 100)
    @statusBarTile = statusBar.addRightTile(item: @atometerView.element, priority: 0)
    console.log @statusBarTile

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atometerView.destroy()
    @statusBarTile?.destroy()
    @statusBarTile = null


  serialize: ->
    atometerViewState: @atometerView.serialize()

  toggle: ->
    console.log 'Atometer was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
