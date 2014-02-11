var Game = {
	start: function(display) {
		this.display = display;

		this.map = Object.create(Map);
		this.map.drawTo(display);
	},
}