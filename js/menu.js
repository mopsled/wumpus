// Generated by CoffeeScript 1.7.1
(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  this.Menu = (function() {
    function Menu() {
      this.display = new ROT.Display({
        fontSize: 17
      });
      document.body.appendChild(this.display.getContainer());
      this.drawMenu();
      window.addEventListener('keydown', this);
    }

    Menu.prototype.drawMenu = function() {
      this.display.drawTextYCentered(1, 'Hunt the Wumpus');
      return this.display.drawTextYCentered(12, 'N - New Game');
    };

    Menu.prototype.handleEvent = function(event) {
      switch (event.keyCode) {
        case ROT.VK_N:
          window.removeEventListener('keydown', this);
          this.display.clear();
          root.game = new Game(this.display);
          return game.init();
      }
    };

    return Menu;

  })();

}).call(this);
