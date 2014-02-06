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

	drawTextCentered("Hunt the Wumpus", 1, this.display);
	drawTextCentered("N - New Game", 12, this.display);
}

Menu.handleEvent = function(e) {
	if (e.keyCode == ROT.VK_N) {
		window.removeEventListener("keydown", this);
		Game.start(this.display);
	}
}

function drawTextCentered(text, y, display) {
	var textX = Math.floor(display.getOptions().width/2 - text.length/2);
	display.drawText(textX, y, text);
}

var Game = {
	start: function(display) {
		display.clear();
		drawTextCentered("You Win!", 11, display);
	}
}