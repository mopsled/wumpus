var Game = {
	start: function(display) {
		this.display = display;

		this.map = Object.create(Map);
		this.map.drawAll(display);

		this.startEngine();
	},

	startEngine: function() {
		var scheduler = new ROT.Scheduler.Simple();
		this.addActors(scheduler);
		this.engine = new ROT.Engine(scheduler);
		this.engine.start();
	},

	addActors: function(scheduler) {
		var coor = this.map.randomFloorSpace();
		this.player = new Player(coor.x, coor.y);
		scheduler.add(this.player, true);
	}
}

function Player(x, y) {
	this.coordinates = {x: x, y: y};
	this.draw();
}

Player.prototype.draw = function() {
	Game.display.draw(this.coordinates.x, this.coordinates.y, "@", "#ff0");
}

Player.prototype.act = function() {
	Game.engine.lock();
	window.addEventListener("keydown", this);
}

Player.prototype.handleEvent = function(e) {
	var keyMap = {};
	keyMap[ROT.VK_UP] = 0;
	keyMap[ROT.VK_RIGHT] = 1;
	keyMap[ROT.VK_DOWN] = 2;
	keyMap[ROT.VK_LEFT] = 3;
	if (!(e.keyCode in keyMap)) return;

	var delta = ROT.DIRS[4][keyMap[e.keyCode]];
	var newCoordinates = {x: this.coordinates.x + delta[0], y: this.coordinates.y + delta[1]}
	if (!(Game.map.isAFloorSpace(newCoordinates))) return;

	Game.map.drawAt(this.coordinates.x, this.coordinates.y, Game.display);
	this.coordinates = newCoordinates;
	this.draw();
	window.removeEventListener("keydown", this);
	Game.engine.unlock();
}