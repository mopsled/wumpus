describe 'Map', ->
  describe 'Construction', ->
    map = new Map {}
    tileValues = null
    it 'should have tiles property', ->
      map.should.have.property('tiles')
    it 'should have lots of tiles', ->
      Object.keys(map.tiles).length.should.be.above(100)
    it 'should have floor tiles', ->
      tileValues = (value for _, value of map.tiles)
      hasFloor = tileValues.some((element) -> element == '.')
      hasFloor.should.be.ok
    it 'should have wall tiles', ->
      hasWall = tileValues.some((element) -> element == '#')
      hasWall.should.be.ok