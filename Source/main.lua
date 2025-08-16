import "board"

local pd = playdate
local gfx = pd.graphics

TAGS = {
  player = 1,
  block = 2,
  wall = 3
}

local board = Board()
board:setup()
board:add()

function pd.update()
  gfx.sprite.update()
  gfx.drawTextInRect(tostring(board.score), 10, 10, 100, 40)
end

