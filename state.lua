local class = require 'middleclass'

States = class('States')

function States:initialize(name)
    self.name = name;
    self.game = require(name .. '/main') -- HACK: if I don't finish is not defined :(
    self:switchState(name)
end

function States:draw()
    self.game.draw()
end

function States:update()
    self.game.update()
end

function States:switchState(name)
    self.game.finish()
    self.game = require(name .. '/main')
    self.game.switchState = self.switchState
    self.game.start()
end

return States
