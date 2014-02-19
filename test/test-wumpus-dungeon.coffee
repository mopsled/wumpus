describe 'WumpusDungeon', ->
  dungeon = new WumpusDungeon 10
  it 'should return lots of tiles', ->
    count = 0
    dungeon.create (x, y) ->
      count++
    count.should.be.above(10)
  it 'should return valid coordinates', ->
    dungeon.create (x, y) ->
      Util.isNumber(x).should.be.true
      Util.isNumber(y).should.be.true