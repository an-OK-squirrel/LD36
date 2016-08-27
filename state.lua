local class = require 'middleclass'

State = class('State')

function State:initialize(name)
    self.name = name;
    self.game = require(name ..  '/main')
    print(self.name)
end

function State:draw()
    self.game.draw()
end

return State
