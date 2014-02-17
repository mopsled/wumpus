root = exports ? this

class @Menu
  constructor: ->
    @display = new ROT.Display({fontSize: 17})
    document.body.appendChild @display.getContainer()
    @drawMenu()
    window.addEventListener 'keydown', this

  drawMenu: ->
    @display.drawTextYCentered 1, 'Hunt the Wumpus'
    @display.drawTextYCentered 12, 'N - New Game'

  handleEvent: (event) ->
    switch event.keyCode
      when ROT.VK_N
        window.removeEventListener 'keydown', this
        @display.clear()
        root.game = new Game(@display)
        game.init()