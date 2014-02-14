describe 'ArrayDictionary', ->
  describe 'set', ->
    arrayDict = new ArrayDictionary
    it 'should be able to set an array to an object', ->
      (-> arrayDict.set [1, 2], {a: 1}).should.not.throw()
    it 'should throw on a not-array key', ->
      (-> arrayDict.set 'someKey', {}).should.throw()

  describe 'get', ->
    it 'should retrieve previously-stored value', ->
      object = {a: 1}
      arrayDict = new ArrayDictionary
      arrayDict.set [1, 2], object
      arrayDict.get([1, 2]).should.equal object

  describe 'keys', ->
    arrayDict = new ArrayDictionary
    it 'should return an empty array when empty', ->
      arrayDict.keys().should.be.empty
    it 'should return a key that is set', ->
      arrayDict.set [1, 2], {}
      arrayDict.keys().should.eql [[1, 2]]