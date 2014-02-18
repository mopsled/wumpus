class @ArrayDictionary
  constructor: ->
    @dict = {}

  set: (array, object) ->
    if array instanceof Array
      @dict[keyify(array)] = object
    else
      throw new Error('ArrayDictionary requires an array-type argument to #set')

  get: (array) ->
    if array instanceof Array
      @dict[keyify(array)]
    else
      throw new Error('ArrayDictionary requires an array-type argument to #get')

  keys: ->
    arrayify strKey for strKey in Object.keys(@dict)

  keyify = (array) ->
    array.join ','

  arrayify = (string) ->
    parts = string.split ','
    (if Util.isNumber(p) then Number(p) else p) for p in parts