import "CoreLibs/object"

class("GameScene").extends()

function GameScene:init()
  self.sprites = {}
end

function GameScene:onEnter()
  -- set up when scene will appear
end

function GameScene:onExit()
  -- optional, clean up
  -- must call super if implemented
  for _,v in ipairs(self.sprites) do
    table.remove(self.sprites)
    v:remove()
  end
end

function GameScene:update()
  -- optional, called on active scene by scene manager
end

function GameScene:addSprite(sprite)
  table.insert(self.sprites, sprite)
  sprite:add()
end
