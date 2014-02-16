class Tile
  constructor: (@x, @y) ->

  draw: (display) ->
    display.draw x, y, '?'

class @Floor extends Tile
  draw: (display, inFOV) ->
    if inFOV
      display.draw @x, @y, '.', '#fff', '#000'
    else
      display.draw @x, @y, '.', '#777', '#222'

class @Wall extends Tile
  draw: (display, inFOV=false) ->
    if inFOV
      display.draw @x, @y, '#', '#fff', '#000'
    else
      display.draw @x, @y, '#', '#777', '#222'