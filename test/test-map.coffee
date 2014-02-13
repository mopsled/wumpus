describe 'Map constructor', ->
  display = {}
  it 'should construct with a display', ->
    map = new Map display
    map.display.should.equal display