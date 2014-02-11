var Util = {
	drawTextCentered: function(text, y, display) {
		var textX = Math.floor(display.getOptions().width/2 - text.length/2);
		display.drawText(textX, y, text)
	}
}
