import "CoreLibs/object"

import "player"
import "ball"
import "wall"
import "block"

local pd = playdate
local gfx = pd.graphics

class('Board').extends(gfx.sprite)

function Board:setup()
  self.score = 0

  self.player = Player()
  self.player:add()

  self.ball = Ball()
  self.ball:add()

  self.ball.onCollideBlock = function (block)
    block:remove()
    self.score = self.score + 10
  end

  self.ball.onFail = function()
    gfx.sprite.removeAll()
    self.player = nil
    self.ball = nil
    self.blocks = {}
    self:setup()
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
      block:add()
      self.blocks[#self.blocks + 1] = block
    end
  end
end


function Board:addWalls()
  local x, y, w, h = pd.display.getRect():unpack()
  local wallWidth = 1
  y = y + wallWidth / 2

  local top = Wall(x + w / 2, y, w, wallWidth)
  top:add()

  y = y + (h / 2)
  local left = Wall(x, y, wallWidth, h)
  left:add()

  local right = Wall(w, y, wallWidth, h)
  right:add()
end
