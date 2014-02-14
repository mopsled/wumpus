describe 'Map', ->
  map = new Map {}
  describe 'constructor', ->
    tileValues = null
    it 'should have tiles property', ->
      map.should.have.property('tiles')
    it 'should have lots of tiles', ->
      map.tiles.keys().length.should.be.above(100)
    it 'should have floor tiles', ->
      tileValues = (map.tiles.get(c) for c in map.tiles.keys())
      hasFloor = tileValues.some((element) -> element == '.')
      hasFloor.should.be.ok
    it 'should have wall tiles', ->
      hasWall = tileValues.some((element) -> element == '#')
      hasWall.should.be.true