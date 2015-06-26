module.exports =
class AtometerTracker
  letters: 0
  moves: 0
  symbols: 0
  lines: 0

  constructor: (@atometerView) ->
        workspaceView = atom.views.getView(atom.workspace)
        workspaceView.addEventListener 'keydown', => @track(event)

  track: (event) ->
        if event.which >= 48 and event.which <= 90
                @letters += 1
        else if event.which >= 37 and event.which <= 40
                @moves += 1
        else if (event.which >= 186 and event.which <= 222) or (event.which >= 106 and event.which <= 111)
                @symbols += 1
        else if event.which == 13
                @lines += 1
        @atometerView.update(@letters)
