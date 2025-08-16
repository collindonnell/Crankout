import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init()
  Player.super.init(self)
  self:setSize(40, 10)
  self:setCollideRect(0, 0, self:getSize())
  local screenWidth, screenHeight = pd.display.getSize()
  self:moveTo(screenWidth / 2, screenHeight - 30)
  self:setTag(TAGS.player)
end

function Player:draw(x, y, width, height)
  playdate.graphics.fillRect(x, y, width, height)
end

function Player:update()
  local change, _ = pd.getCrankChange()
  local x, y = self:getPosition()
  self:moveWithCollisions(x + change, y)
end

