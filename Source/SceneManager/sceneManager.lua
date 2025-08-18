-- local pd <const> = playdate
-- local gfx <const> = playdate.graphics

local SceneManager = {
  scenes = {}
}

function SceneManager:update()
  if self:top() then
    self:top():update()
  end
end

function SceneManager:top()
  return self.scenes[#self.scenes]
end

function SceneManager:push(scene)
  table.insert(self.scenes, scene)
  scene:onEnter()
end

function SceneManager:pop()
  local scene = self.scenes[#self.scenes]
  if scene then
    scene:onExit()
    table.remove(scene)
  end
end

return SceneManager
