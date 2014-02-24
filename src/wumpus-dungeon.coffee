class @WumpusDungeon
  constructor: (@width=32, @height=32) ->

  create: (callback=->) ->
    @rooms = []
    for _ in [0...roomCount]
      startX = Math.floor ROT.RNG.getUniform() * (@width - maxRoomWidth)
      startY = Math.floor ROT.RNG.getUniform() * (@height - maxRoomHeight)
      @rooms.push [startX, startY, startX+maxRoomWidth, startY+maxRoomHeight]
      for x in [startX..startX+maxRoomWidth]
        callback x, y for y in [startY...startY+maxRoomHeight]

  getRooms: ->
    @rooms

  roomCount = 10
  maxRoomWidth = 4
  maxRoomHeight = 3