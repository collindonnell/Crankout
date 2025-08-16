import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('Wall').extends(gfx.sprite)

function Wall:init(x, y, w, h)
  Wall.super.init(self)
  self:setSize(w, h)
  self:setCollideRect(0, 0, self:getSize())
  self:moveTo(x, y)
end
