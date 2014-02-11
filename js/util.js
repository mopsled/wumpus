ROT.Display.prototype.drawTextYCentered = function (y, text, maxWidth) {
	var x = Math.floor(this.getOptions().width/2 - text.length/2);
	this.drawText(x, y, text, maxWidth);
};
