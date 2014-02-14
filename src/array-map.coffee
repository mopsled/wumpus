class @ArrayMap
  constructor: ->
    @map = {}

  set: (array, object) ->
    if array instanceof Array
      @map[keyify(array)] = object
    else
      throw new Error('ArrayMap requires an array-type argument to #set')

  get: (array) ->
    if array instanceof Array
      @map[keyify(array)]
    else
      throw new Error('ArrayMap requires an array-type argument to #get')

  keyify = (array) ->
    array.join ','