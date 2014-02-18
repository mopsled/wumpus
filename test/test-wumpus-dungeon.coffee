describe 'WumpusDungeon', ->
  dungeon = new WumpusDungeon()
  it 'returns tiles', ->
    returnedTile = false
    dungeon.create (x, y) ->
      returnedTile = true
    returnedTile.should.be.true