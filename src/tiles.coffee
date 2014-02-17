class Tile
  fcolor: '#fff'
  bcolor: '#000'
  symbol: '?'

  constructor: (@x, @y) ->

  draw: (display, inFOV=false) ->
    if inFOV
      display.draw @x, @y, @symbol, @fcolor, @bcolor
    else
      display.draw @x, @y, @symbol, darken(@fcolor, 0.8), darken(@bcolor, 0.8)

class @Floor extends Tile
  symbol: '.'

  constructor: (@x, @y) ->
    @fcolor = darken '#ddd', ROT.RNG.getUniform() * 0.2
    @bcolor = darken '#111', ROT.RNG.getUniform() * 0.2

class @Wall extends Tile
  symbol: '#'

  constructor: (@x, @y) ->
    @fcolor = darken '#222', ROT.RNG.getUniform() * 0.2
    @bcolor = darken '#bbb', ROT.RNG.getUniform() * 0.4

asArray = (hex, callback) ->
  a = ROT.Color.fromString(hex)
  ROT.Color.toHex callback(a)

darken = (color, amount) ->
  asArray color, (a) ->
    ROT.Color.interpolate a, [0, 0, 0], amount
