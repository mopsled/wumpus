// Generated by CoffeeScript 1.7.1
(function() {
  describe('Map constructor', function() {
    var display;
    display = {};
    return it('should construct with a display', function() {
      var map;
      map = new Map(display);
      return map.display.should.equal(display);
    });
  });

}).call(this);
