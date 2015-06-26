module.exports =
class AtometerView

  constructor: () ->
        # Create root element for status bar, must be a span
        @element = document.createElement('span')
        @element.textContent = "000000"
        @element.classList.add('badge')
        # @element.classList.add('badge-small')
        @element.classList.add('atometer')
        

  update: (keys) ->
          k = "000000" + keys
          @element.textContent = k.slice(-6)

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
