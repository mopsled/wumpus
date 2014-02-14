describe 'ArrayMap', ->
  describe 'set', ->
    arrayMap = new ArrayMap
    it 'should be able to set an array to an object', ->
      (-> arrayMap.set [1, 2], {a: 1}).should.not.throw()
    it 'should throw on a not-array key', ->
      (-> arrayMap.set 'someKey', {}).should.throw()
  describe 'get', ->
    it 'should retrieve previously-stored value', ->
      object = {a: 1}
      arrayMap = new ArrayMap
      arrayMap.set [1, 2], object
      arrayMap.get([1, 2]).should.equal(object)