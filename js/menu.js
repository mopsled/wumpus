var Menu = {
	display: null,

	init: function() {
		this.display = new ROT.Display();
		document.body.appendChild(this.display.getContainer());
		this.drawMenu();
		window.addEventListener("keydown", this);
	}
}

Menu.drawMenu = function() {
	var width = this.display.getOptions().width;
	var height = this.display.getOptions().height;

	Util.drawTextCentered("Hunt the Wumpus", 1, this.display);
	Util.drawTextCentered("N - New Game", 12, this.display);
}

Menu.handleEvent = function(e) {
	if (e.keyCode == ROT.VK_N) {
		window.removeEventListener("keydown", this);
		this.display.clear();
		Game.start(this.display);
	}
}