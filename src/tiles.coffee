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
  fcolor: '#ddd'
  bcolor: '#111'
  symbol: '.'

class @Wall extends Tile
  fcolor: '#222'
  bcolor: '#bbb'
  symbol: '#'

darken = (color, amount) ->
  colorArray = ROT.Color.fromString(color)
  darkened = ROT.Color.interpolate colorArray, [0, 0, 0], amount
  ROT.Color.toHex(darkened)