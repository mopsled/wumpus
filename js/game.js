var Game = {
	start: function(display) {
		this.display = display;

		this.map = new Map();
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
};