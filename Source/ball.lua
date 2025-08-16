import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('Ball').extends(gfx.sprite)

function Ball:init()
  Ball.super.init(self)
  self.velocity = pd.geometry.vector2D.new(-1, -4)
  self.velocity:normalize()
  self.speed = 4
  self:setSize(10, 10)
  self:setCollideRect(0, 0, self:getSize())
  local screenWidth, screenHeight = pd.display.getSize()
  self:moveTo((screenWidth / 2), screenHeight - 40)
end

function Ball:update()
  local goalX = self.x + self.velocity.dx * self.speed
  local goalY = self.y + self.velocity.dy * self.speed
  local _, _, collisions, _ = self:moveWithCollisions(goalX, goalY)
  for _,v in ipairs(collisions) do
    local n = v.normal
    self.velocity = self:bounce(n, self.velocity:normalized())
    if v.other:getTag() == TAGS.player then
      local paddleWidth = v.otherRect.width
      local paddleX = v.other:getPosition()
      local ballX = self:getPosition()
      local offset = (ballX - paddleX) / (paddleWidth / 2)
      self.velocity.dx = self.velocity.dx + offset * 0.75
    elseif v.other:getTag() == TAGS.block then
      self.onCollideBlock(v.other)
    end
  end
end

function Ball:bounce(n, v)
  return v - (n * (2 * v:dotProduct(n)))
end

function Ball:draw(x, y, width, height)
  gfx.fillCircleInRect(x, y, width, height)
end
