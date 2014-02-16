class @Game
  constructor: (@display) ->

  init: ->
    @map = new Map(@display)
    @startEngine()

  startEngine: ->
    scheduler = new ROT.Scheduler.Simple()
    @addActors scheduler
    @engine = new ROT.Engine scheduler
    @engine.start()

  addActors: (scheduler) ->
    [x, y] = @map.randomFloorSpace()
    @player = new Player x, y
    scheduler.add this.player, true