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
      tiles.set [x, y], new Floor(x, y) if not wall
    tiles.set [x, y], new Wall(x, y) for [x, y] in generateWalls tiles
    tiles

  generateWalls = (floor) ->
    floorCoor = floor.keys()
    adjacent = flatten (adjacentCoordinates(x, y) for [x, y] in floorCoor)
    wallCoor = (c for c in adjacent when floor.get(c) not instanceof Floor)
    wallCoor

  adjacentCoordinates = (x, y) ->
    [x + xi, y + yi] for [xi, yi] in ROT.DIRS[8]

  flatten = (a) ->
    if a.length is 0 then return []
    a.reduce (lhs, rhs) -> lhs.concat rhs