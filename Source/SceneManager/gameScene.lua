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
  for i,v in ipairs(self.sprites) do
    self.sprites = {}
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

function GameScene:removeSprite(sprite)
  sprite:remove()
  for i,v in ipairs(self.sprites) do
    if v == sprite then
      table.remove(self.sprites, i)
    end
  end
end