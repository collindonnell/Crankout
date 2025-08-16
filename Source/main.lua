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

function pd.update()
  gfx.sprite.update()
end

