import "CoreLibs/object"

import "player"
import "ball"
import "wall"
import "block"
import "textBox"
import "SceneManager/gameScene"

local pd = playdate

class('Board').extends(GameScene)

function Board:onEnter()
  self.score = 0
  self.failed = false

  self.scoreBox = TextBox(110, 50, 200, 80)
  self.scoreBox:setText(tostring(self.score))
  self.scoreBox:setZIndex(900)
  self:addSprite(self.scoreBox)

  self.player = Player()
  self:addSprite(self.player)

  self.ball = Ball()
  self:addSprite(self.ball)

  self.ball.onCollideBlock = function (block)
    block:remove()
    self.score = self.score + 10
    self.scoreBox:setText(tostring(self.score))
  end

  self.ball.onFail = function()
    if not self.failed then
      SceneManager:pop()
      SceneManager:push(Board())
      self.failed = true
    end
  end

  self:addBlocks()
  self:addWalls()
end

function Board:addBlocks()
  self.blocks = {}
  local x0, y0, sw, _ = pd.display.getRect():unpack()
  local hCount = 8
  local vCount = 4
  local padding = 4
  y0 = y0 + 40 -- starting y position

  -- Compute the usable width and height
  local totalPaddingX = padding * (hCount + 1)
  local blockWidth = (sw - totalPaddingX) / hCount
  local blockHeight = 12

  -- Loop over columns and rows
  for col = 1, hCount do
    for row = 1, vCount do
      local x = x0 + padding + (col - 1) * (blockWidth + padding) + blockWidth / 2
      local y = y0 + padding + (row - 1) * (blockHeight + padding) + blockHeight / 2

      local block = Block(x, y, blockWidth, blockHeight)
      table.insert(self.blocks, block)
      self:addSprite(block)
    end
  end
end


function Board:addWalls()
  local x, y, w, h = pd.display.getRect():unpack()
  local wallWidth = 1
  y = y + wallWidth / 2

  local top = Wall(x + w / 2, y, w, wallWidth)
  self:addSprite(top)

  y = y + (h / 2)
  local left = Wall(x, y, wallWidth, h)
  self:addSprite(left)

  local right = Wall(w, y, wallWidth, h)
  self:addSprite(right)
end

