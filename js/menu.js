var Menu = {
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

	this.display.drawTextYCentered(1, "Hunt the Wumpus");
	this.display.drawTextYCentered(12, "N - New Game");
}

Menu.handleEvent = function(e) {
	if (e.keyCode == ROT.VK_N) {
		window.removeEventListener("keydown", this);
		this.display.clear();
		Game.start(this.display);
	}
}