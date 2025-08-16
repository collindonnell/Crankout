import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

class('Block').extends(gfx.sprite)

function Block:init(x, y, w, h)
  Block.super.init(self)
  self:setImage(gfx.image.new(w, h, gfx.kColorBlack))
  self:setSize(w, h)
  self:moveTo(x, y)
  self:setCollideRect(0, 0, self:getSize())
  self:setTag(TAGS.block)
end
