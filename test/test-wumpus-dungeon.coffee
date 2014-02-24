describe 'WumpusDungeon', ->
  it 'should return lots of tiles', ->
    dungeon = new WumpusDungeon
    count = 0
    dungeon.create (x, y) ->
      count++
    count.should.be.above(10)
  it 'should return valid coordinates', ->
    dungeon = new WumpusDungeon
    dungeon.create (x, y) ->
      Util.isNumber(x).should.be.true
      Util.isNumber(y).should.be.true
  it 'should have some rooms', ->
    dungeon = new WumpusDungeon
    dungeon.create()
    rooms = dungeon.getRooms()
    rooms.should.be.an.instanceOf(Array)
    rooms.length.should.be.above 8