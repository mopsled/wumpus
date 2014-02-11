function Player(x, y) {
	this.coordinates = {x: x, y: y};
	Game.map.drawFOV(this.calculateFOV(), Game.display);
	this.draw();
}

Player.prototype.draw = function() {
	Game.display.draw(this.coordinates.x, this.coordinates.y, "@", "#ff0", "#660");
};

Player.prototype.act = function() {
	Game.engine.lock();
	window.addEventListener("keydown", this);
};

Player.prototype.calculateFOV = function() {
	var fov = [];
	var shadowcaster = new ROT.FOV.PreciseShadowcasting(Game.map.isAFloorSpace);
	shadowcaster.compute(this.coordinates.x, this.coordinates.y, 10, function(x, y) {
		fov.push({x: x, y: y});
	});
	return fov;
};

Player.prototype.handleEvent = function(e) {
	var keyMap = {};
	keyMap[ROT.VK_UP] = 0;
	keyMap[ROT.VK_RIGHT] = 1;
	keyMap[ROT.VK_DOWN] = 2;
	keyMap[ROT.VK_LEFT] = 3;
	if (!(e.keyCode in keyMap)) return;

	var delta = ROT.DIRS[4][keyMap[e.keyCode]];
	var newCoordinates = {x: this.coordinates.x + delta[0], y: this.coordinates.y + delta[1]};
	if (!(Game.map.isAFloorSpace(newCoordinates.x, newCoordinates.y))) return;

	Game.map.drawAt(this.coordinates.x, this.coordinates.y, Game.display);
	var fov = this.calculateFOV();
	fov.forEach(function(coor) {
		Game.map.drawAt(coor.x, coor.y, Game.display);
	});

	this.coordinates = newCoordinates;
	Game.map.drawFOV(this.calculateFOV(), Game.display);
	this.draw();

	window.removeEventListener("keydown", this);
	Game.engine.unlock();
};