// Generated by CoffeeScript 1.7.1
(function() {
  this.ArrayDictionary = (function() {
    var arrayify, isNumber, keyify;

    function ArrayDictionary() {
      this.dict = {};
    }

    ArrayDictionary.prototype.set = function(array, object) {
      if (array instanceof Array) {
        return this.dict[keyify(array)] = object;
      } else {
        throw new Error('ArrayDictionary requires an array-type argument to #set');
      }
    };

    ArrayDictionary.prototype.get = function(array) {
      if (array instanceof Array) {
        return this.dict[keyify(array)];
      } else {
        throw new Error('ArrayDictionary requires an array-type argument to #get');
      }
    };

    ArrayDictionary.prototype.keys = function() {
      var strKey, _i, _len, _ref, _results;
      _ref = Object.keys(this.dict);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        strKey = _ref[_i];
        _results.push(arrayify(strKey));
      }
      return _results;
    };

    keyify = function(array) {
      return array.join(',');
    };

    arrayify = function(string) {
      var p, parts, _i, _len, _results;
      parts = string.split(',');
      _results = [];
      for (_i = 0, _len = parts.length; _i < _len; _i++) {
        p = parts[_i];
        _results.push(isNumber(p) ? Number(p) : p);
      }
      return _results;
    };

    isNumber = function(n) {
      return !isNaN(parseFloat(n)) && isFinite(n);
    };

    return ArrayDictionary;

  })();

}).call(this);