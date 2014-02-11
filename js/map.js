var Map = {
	map: generateMap(),

	drawAll: function(display) {
		for (var key in this.map) {
			coor = coordinatesForKey(key);
			display.draw(coor.x, coor.y, this.map[key]);
		}
	},

	drawAt: function(x, y, display) {
		display.draw(x, y, this.map[keyify(x, y)]);
	},

	randomFloorSpace: function() {
		var allSpaces = Object.keys(this.map).randomize();
		for (var i = 0; i < allSpaces.length; i++) {
			var key = allSpaces[i];
			if (this.map[key] == '.') {
				return coordinatesForKey(key);
			}
		}
		return null;
	},

	isAFloorSpace: function(coor) {
		return (this.map[keyify(coor.x, coor.y)] == '.');
	}
}

function generateMap() {
	var map = {};

	var digger = new ROT.Map.Digger();
	digger.create(function(x, y, wall) {
		if (!wall) map[keyify(x, y)] = '.';
	});

	var walls = generateWalls(map);
	walls.forEach(function(wallKey) {
		map[wallKey] = '#';
	});
	return map;
}

function generateWalls(map) {
	var walls = [];
	for (var key in map) {
		coor = coordinatesForKey(key);
		adjacentCoordinates(coor).forEach(function(adjacent) {
			var adjacentKey = keyify(adjacent.x, adjacent.y);
			if (map[adjacentKey] != '.') {
				walls.push(adjacentKey);
			}
		});
	}
	return walls;
}

function keyify(x, y) {
	return x + ',' + y;
}

function coordinatesForKey(key) {
	coorArray = key.split(',').map(Number);
	return {x: coorArray[0], y: coorArray[1]};
}

function adjacentCoordinates(coor) {
	var adjacent = [];
	for (var xi = -1; xi <= 1; xi++) {
		for (var yi = -1; yi <= 1; yi++)  {
			if (!(xi == 0 && yi == 0)) adjacent.push({x: coor.x + xi, y: coor.y + yi});
		}
	}
	return adjacent;
}