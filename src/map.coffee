class @Map
  constructor: (@display) ->
    @tiles = generateTiles()

  drawFOV: (fov) =>
    t.draw(@display, inFOV=true) for t in (@tiles.get(c) for c in fov)

  drawDarkTile: (x, y) =>
    tile = @tiles.get([x, y])
    tile.draw(@display)

  randomFloorSpace: ->
    floor = (k for k in @tiles.keys() when @tiles.get(k) instanceof Floor)
    floor.randomize()[0]

  isAFloorSpace: (x, y) =>
    @tiles.get([x, y]) instanceof Floor

  generateTiles = () ->
    tiles = new ArrayDictionary
    digger = new ROT.Map.Digger()
    digger.create (x, y, wall) ->
      tile = (if wall then new Wall(x, y) else new Floor(x, y))
      tiles.set [x, y], tile
    tiles

  adjacentCoordinates = (x, y) ->
    [x + xi, y + yi] for [xi, yi] in ROT.DIRS[8]

  flatten = (a) ->
    if a.length is 0 then return []
    a.reduce (lhs, rhs) -> lhs.concat rhs