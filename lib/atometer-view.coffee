module.exports =
class AtometerView

  constructor: (serializedState) ->
        # Create root element

        @element = document.createElement('span')
        @element.textContent = "000000"
        @element.classList.add('badge')
        # @element.classList.add('badge-small')

  update: (keys) ->
          k = "000000" + keys
          @element.textContent = k.slice(-6)
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
