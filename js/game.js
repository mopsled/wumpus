// Generated by CoffeeScript 1.7.1
(function() {
  this.Game = (function() {
    function Game(display) {
      this.display = display;
    }

    Game.prototype.init = function() {
      this.map = new Map(this.display);
      return this.startEngine();
    };

    Game.prototype.startEngine = function() {
      var scheduler;
      scheduler = new ROT.Scheduler.Simple();
      this.addActors(scheduler);
      this.engine = new ROT.Engine(scheduler);
      return this.engine.start();
    };

    Game.prototype.addActors = function(scheduler) {
      var x, y, _ref;
      _ref = this.map.randomFloorSpace(), x = _ref[0], y = _ref[1];
      this.player = new Player(x, y);
      return scheduler.add(this.player, true);
    };

    return Game;

  })();

}).call(this);
