class @Map
  constructor: (@display) ->
    @tiles = generateTiles()

  drawAll: ->
    @drawAt coorForKey(coor)... for coor of @tiles

  drawFOV: (fov) =>
    drawLitTile keyify(x, y), this for [x, y] in fov

  drawAt: (x, y) =>
    @display.draw x, y, @tiles[keyify(x, y)]

  randomFloorSpace: ->
    floor = (f for f of @tiles when @tiles[f] is '.')
    coorForKey(floor.randomize()[0])

  isAFloorSpace: (x, y) =>
    @tiles[keyify(x, y)] == '.'

  generateTiles = () ->
    tiles = {}
    differ = new ROT.Map.Digger()
    differ.create (x, y, wall) ->
      tiles[keyify(x, y)] = '.' if not wall
    tiles[key] = '#' for key in generateWalls tiles
    tiles

  generateWalls = (floor) ->
    floorCoor = (coorForKey(key) for key of floor)
    adjacent = flatten (adjacentCoordinates(x, y) for [x, y] in floorCoor)
    wallCoor = ([x, y] for [x, y] in adjacent when floor[keyify(x, y)] != '.')
    keyify(c...) for c in wallCoor

  drawLitTile = (key, map) ->
    map.display.draw coorForKey(key)..., map.tiles[key], '#fff', '#660'

  keyify = (x, y) ->
    x + ',' + y

  coorForKey = (key) ->
    key.split(',').map Number

  adjacentCoordinates = (x, y) ->
    [x + xi, y + yi] for [xi, yi] in ROT.DIRS[8]

  flatten = (a) ->
    if a.length is 0 then return []
    a.reduce (lhs, rhs) -> lhs.concat rhs


# function Map() {
#   var tiles = generateTiles();

#   this.drawAll = function(display) {
#     for (var key in tiles) {
#       coor = coordinatesForKey(key);
#       this.drawAt(coor.x, coor.y, display);
#     }
#   };

#   this.drawFOV = function(fov, display) {
#     fov.forEach(function(coor) {
#       var tile = tiles[keyify(coor.x, coor.y)];
#       var color = "#660";
#       display.draw(coor.x, coor.y, tile, "#fff", color);
#     });
#   };

#   this.drawAt = function(x, y, display) {
#     display.draw(x, y, tiles[keyify(x, y)]);
#   };

#   this.randomFloorSpace = function() {
#     var allSpaces = Object.keys(tiles).randomize();
#     for (var i = 0; i < allSpaces.length; i++) {
#       var key = allSpaces[i];
#       if (tiles[key] == '.') {
#         return coordinatesForKey(key);
#       }
#     }
#     return null;
#   };

#   this.isAFloorSpace = function(x, y) {
#     return (tiles[keyify(x, y)] === '.');
#   };
# }

# function generateTiles() {
#   var map = {};

#   var digger = new ROT.Map.Digger();
#   digger.create(function(x, y, wall) {
#     if (!wall) map[keyify(x, y)] = '.';
#   });

#   var walls = generateWalls(map);
#   walls.forEach(function(wallKey) {
#     map[wallKey] = '#';
#   });
#   return map;
# }

# function generateWalls(map) {
#   var walls = [];
#   var addWalls = function(adjacentCoordinate) {
#     var adjacentKey = keyify(adjacentCoordinate.x, adjacentCoordinate.y);
#     if (map[adjacentKey] != '.') {
#       walls.push(adjacentKey);
#     }
#   };

#   for (var key in map) {
#     coor = coordinatesForKey(key);
#     adjacentCoordinates(coor.x, coor.y).forEach(addWalls);
#   }
#   return walls;
# }

# function keyify(x, y) {
#   return x + ',' + y;
# }

# function coordinatesForKey(key) {
#   coorArray = key.split(',').map(Number);
#   return {x: coorArray[0], y: coorArray[1]};
# }

# function adjacentCoordinates(x, y) {
#   var adjacent = [];
#   for (var xi = -1; xi <= 1; xi++) {
#     for (var yi = -1; yi <= 1; yi++)  {
#       if (!(xi === 0 && yi === 0)) adjacent.push({x: x + xi, y: y + yi});
#     }
#   }
#   return adjacent;
# }