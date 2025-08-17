import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

class('TextBox').extends(gfx.sprite)

function TextBox:init(x, y, w, h)
  TextBox.super.init(self)
  self:setSize(w, h)
  self:moveTo(x, y)
end

function TextBox:draw()
  local w, h = self:getSize()
  gfx.pushContext()
  gfx.drawTextInRect(self.text, 0, 0, w, h)
  gfx.popContext()
end

function TextBox:setText(text)
  self.text = text
  self:markDirty() -- tell the sprite it needs to redraw
end
