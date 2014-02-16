// Generated by CoffeeScript 1.7.1
(function() {
  this.Player = (function() {
    var makeKeymap;

    function Player(x, y) {
      this.coor = {
        x: x,
        y: y
      };
      game.map.drawFOV(this.calculateFOV(), game.display);
      this.draw();
    }

    Player.prototype.draw = function() {
      return game.display.draw(this.coor.x, this.coor.y, '@', '#ff0', '#660');
    };

    Player.prototype.act = function() {
      game.engine.lock();
      return window.addEventListener('keydown', this);
    };

    Player.prototype.calculateFOV = function() {
      var fov, shadowcaster;
      fov = [];
      shadowcaster = new ROT.FOV.PreciseShadowcasting(game.map.isAFloorSpace);
      shadowcaster.compute(this.coor.x, this.coor.y, 10, function(x, y) {
        return fov.push([x, y]);
      });
      return fov;
    };

    Player.prototype.handleEvent = function(e) {
      var canMoveToSpace, delta, fov, keymap, movedCoor, x, y, _i, _len, _ref;
      keymap = makeKeymap();
      if (!(e.keyCode in keymap)) {
        return;
      }
      delta = ROT.DIRS[8][keymap[e.keyCode]];
      movedCoor = {
        x: this.coor.x + delta[0],
        y: this.coor.y + delta[1]
      };
      canMoveToSpace = game.map.isAFloorSpace(movedCoor.x, movedCoor.y);
      if (!canMoveToSpace) {
        return;
      }
      fov = this.calculateFOV();
      for (_i = 0, _len = fov.length; _i < _len; _i++) {
        _ref = fov[_i], x = _ref[0], y = _ref[1];
        game.map.drawDarkTile(x, y, game.display);
      }
      this.coor = movedCoor;
      game.map.drawFOV(this.calculateFOV(), game.display);
      this.draw();
      window.removeEventListener('keydown', this);
      return game.engine.unlock();
    };

    makeKeymap = function() {
      var keymap, _ref, _ref1, _ref2, _ref3;
      keymap = {};
      _ref = [0, 0], keymap[ROT.VK_UP] = _ref[0], keymap[ROT.VK_K] = _ref[1];
      _ref1 = [2, 2], keymap[ROT.VK_RIGHT] = _ref1[0], keymap[ROT.VK_L] = _ref1[1];
      _ref2 = [4, 4], keymap[ROT.VK_DOWN] = _ref2[0], keymap[ROT.VK_J] = _ref2[1];
      _ref3 = [6, 6], keymap[ROT.VK_LEFT] = _ref3[0], keymap[ROT.VK_H] = _ref3[1];
      keymap[ROT.VK_U] = 1;
      keymap[ROT.VK_N] = 3;
      keymap[ROT.VK_B] = 5;
      keymap[ROT.VK_Y] = 7;
      return keymap;
    };

    return Player;

  })();

}).call(this);
