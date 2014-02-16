class @Player
  constructor: (x, y) ->
    @coor = x: x, y: y
    game.map.drawFOV @calculateFOV(), game.display
    @draw()

  draw: ->
    game.display.draw @coor.x, @coor.y, '@', '#ff0', '#660'

  act: ->
    game.engine.lock()
    window.addEventListener 'keydown', this

  calculateFOV: ->
    fov = []
    shadowcaster = new ROT.FOV.PreciseShadowcasting game.map.isAFloorSpace
    shadowcaster.compute @coor.x, @coor.y, 10, (x, y) ->
      fov.push([x, y])
    fov

  handleEvent: (e) ->
    keymap = makeKeymap()

    return if not (e.keyCode of keymap)

    delta = ROT.DIRS[8][keymap[e.keyCode]]
    movedCoor = x: @coor.x + delta[0], y: @coor.y + delta[1]
    canMoveToSpace = game.map.isAFloorSpace movedCoor.x, movedCoor.y
    return if not canMoveToSpace

    fov = @calculateFOV()
    game.map.drawDarkTile x, y, game.display for [x, y] in fov

    # TODO: FOV for each space is being calculated twice. It can be
    # moved to an instance variable to avoid this
    @coor = movedCoor
    game.map.drawFOV @calculateFOV(), game.display
    @draw()

    window.removeEventListener 'keydown', this
    game.engine.unlock()

  makeKeymap = ->
    keymap = {}
    [keymap[ROT.VK_UP], keymap[ROT.VK_K]] = [0, 0]
    [keymap[ROT.VK_RIGHT], keymap[ROT.VK_L]] = [2, 2]
    [keymap[ROT.VK_DOWN], keymap[ROT.VK_J]] = [4, 4]
    [keymap[ROT.VK_LEFT], keymap[ROT.VK_H]] = [6, 6]
    keymap[ROT.VK_U] = 1
    keymap[ROT.VK_N] = 3
    keymap[ROT.VK_B] = 5
    keymap[ROT.VK_Y] = 7
    keymap