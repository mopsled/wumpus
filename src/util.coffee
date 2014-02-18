class @Util
  @isNumber: (n) ->
    !isNaN(parseFloat(n)) && isFinite(n)

ROT.Display.prototype.drawTextYCentered = (y, text, maxWidth) ->
  x = Math.floor (@getOptions().width/2 - text.length/2)
  @drawText x, y, text, maxWidth
