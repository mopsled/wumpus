var Map = {
	map: generateMap(),

	drawTo: function(display) {
		for (var key in this.map) {
			coor = coordinatesForKey(key);
			display.draw(coor.x, coor.y, this.map[key]);
		}
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