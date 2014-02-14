class @Map
  constructor: (@display) ->
    @tiles = generateTiles()

  drawAll: ->
    @drawAt [x, y] for [x, y] in @tiles.keys()

  drawFOV: (fov) =>
    drawLitTile [x, y], this for [x, y] in fov

  drawAt: (x, y) =>
    @display.draw x, y, @tiles[keyify(x, y)]

  randomFloorSpace: ->
    floor = (f for f of @tiles when @tiles[f] is '.')
    coorForKey(floor.randomize()[0])

  isAFloorSpace: (x, y) =>
    @tiles[keyify(x, y)] == '.'

  generateTiles = () ->
    tiles = new ArrayDictionary
    differ = new ROT.Map.Digger()
    differ.create (x, y, wall) ->
      tiles.set [x, y], '.' if not wall
    tiles.set coor, '#' for coor in generateWalls tiles
    tiles

  generateWalls = (floor) ->
    floorCoor = floor.keys()
    adjacent = flatten (adjacentCoordinates(x, y) for [x, y] in floorCoor)
    wallCoor = ([x, y] for [x, y] in adjacent when floor[keyify(x, y)] != '.')
    wallCoor

  drawLitTile = (key, map) ->
    map.display.draw coorForKey(key)..., map.tiles[key], '#fff', '#660'

  adjacentCoordinates = (x, y) ->
    [x + xi, y + yi] for [xi, yi] in ROT.DIRS[8]

  flatten = (a) ->
    if a.length is 0 then return []
    a.reduce (lhs, rhs) -> lhs.concat rhs