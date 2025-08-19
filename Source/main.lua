import "board"

local pd = playdate
local gfx = pd.graphics

SceneManager = import("SceneManager/sceneManager")

TAGS = {
  player = 1,
  block = 2,
  wall = 3
}

local board = Board()
SceneManager:push(board)

function pd.update()
  gfx.sprite.update()
  SceneManager:update()
end
