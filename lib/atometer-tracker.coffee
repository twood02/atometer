module.exports =
class AtometerTracker


  constructor: (state, @atometerView) ->
        # probably should just listen within editor, but this is OK
        workspaceView = atom.views.getView(atom.workspace)
        workspaceView.addEventListener 'keydown', => @track(event)
        if state
                @stats = state
        else
                @stats =
                        letters: 0
                        moves: 0
                        symbols: 0
                        lines: 0
        @atometerView.update(@stats.letters)
        # Create a tooltip and fill it with some mess
        @tooltip = atom.tooltips.add(@atometerView.element, title: =>
                "<center><strong>Atometer</strong></center>
                <div style=\"line-height: 26px; text-align:right;\">
                Letters: <span class=\"keystroke\">#{@stats.letters}</span><BR />
                Arrows: <span class=\"keystroke\">#{@stats.moves}</span><BR />
                Symbols: <span class=\"keystroke\">#{@stats.symbols}</span><BR />
                Lines: <span class=\"keystroke\">#{@stats.lines}</span>
                </div>
                "
                )
        console.log @atometerView.element

  # Save the stats measured thus far on exit
  serialize: ->
        @stats

  destroy: ->
          @tooltip.dispose()

  # Record different types of key presses
  track: (event) ->
        if event.which >= 48 and event.which <= 90
                @stats.letters += 1
        else if event.which >= 37 and event.which <= 40
                @stats.moves += 1
        else if (event.which >= 186 and event.which <= 222) or (event.which >= 106 and event.which <= 111)
                @stats.symbols += 1
        else if event.which == 13
                @stats.lines += 1
        @atometerView.update(@stats.letters)
