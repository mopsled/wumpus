function Map() {
	var tiles = generateTiles();

	this.drawAll = function(display) {
		for (var key in tiles) {
			coor = coordinatesForKey(key);
			this.drawAt(coor.x, coor.y, display);
		}
	};

	this.drawFOV = function(fov, display) {
		fov.forEach(function(coor) {
			var tile = tiles[keyify(coor.x, coor.y)];
			var color = "#660";
			display.draw(coor.x, coor.y, tile, "#fff", color);
		});
	};

	this.drawAt = function(x, y, display) {
		display.draw(x, y, tiles[keyify(x, y)]);
	};

	this.randomFloorSpace = function() {
		var allSpaces = Object.keys(tiles).randomize();
		for (var i = 0; i < allSpaces.length; i++) {
			var key = allSpaces[i];
			if (tiles[key] == '.') {
				return coordinatesForKey(key);
			}
		}
		return null;
	};

	this.isAFloorSpace = function(x, y) {
		return (tiles[keyify(x, y)] === '.');
	};
}

function generateTiles() {
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
	var addWalls = function(adjacentCoordinate) {
		var adjacentKey = keyify(adjacentCoordinate.x, adjacentCoordinate.y);
		if (map[adjacentKey] != '.') {
			walls.push(adjacentKey);
		}
	};

	for (var key in map) {
		coor = coordinatesForKey(key);
		adjacentCoordinates(coor.x, coor.y).forEach(addWalls);
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

function adjacentCoordinates(x, y) {
	var adjacent = [];
	for (var xi = -1; xi <= 1; xi++) {
		for (var yi = -1; yi <= 1; yi++)  {
			if (!(xi === 0 && yi === 0)) adjacent.push({x: x + xi, y: y + yi});
		}
	}
	return adjacent;
}