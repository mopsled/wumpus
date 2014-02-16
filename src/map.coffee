class @Map
  constructor: (@display) ->
    @tiles = generateTiles()

  drawFOV: (fov) =>
    drawLitTile x, y, this for [x, y] in fov

  drawDarkTile: (x, y) =>
    @display.draw x, y, @tiles.get([x, y]), "#777", "#222"

  randomFloorSpace: ->
    floor = (k for k in @tiles.keys() when @tiles.get(k) is '.')
    floor.randomize()[0]

  isAFloorSpace: (x, y) =>
    @tiles.get([x, y]) == '.'

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
    wallCoor = ([x, y] for [x, y] in adjacent when floor.get([x, y]) != '.')
    wallCoor

  drawLitTile = (x, y, map) ->
    map.display.draw x, y, map.tiles.get([x, y]), '#fff', '#000'

  adjacentCoordinates = (x, y) ->
    [x + xi, y + yi] for [xi, yi] in ROT.DIRS[8]

  flatten = (a) ->
    if a.length is 0 then return []
    a.reduce (lhs, rhs) -> lhs.concat rhs