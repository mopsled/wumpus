var Game = {
	start: function(display) {
		this.display = display;

		this.map = this.generateMap();
		this.drawMap(this.map);
	},

	generateMap: function() {
		var map = {};

		var digger = new ROT.Map.Digger();
		digger.create(function(x, y, wall) {
			if (!wall) map[keyify(x, y)] = '.';
		});

		var walls = this.generateWalls(map);
		walls.forEach(function(wallKey) {
			map[wallKey] = '#';
		});
		return map;
	},

	generateWalls: function(map) {
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
	},

	drawMap: function(map) {
		for (var key in map) {
			coor = coordinatesForKey(key);
			this.display.draw(coor.x, coor.y, map[key]);
		}
	}
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