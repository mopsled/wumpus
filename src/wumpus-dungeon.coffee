class @WumpusDungeon
  constructor: (@width=32, @height=32) ->

  create: (callback) ->
    for x in [0...@width]
      callback x, y for y in [0...@height]