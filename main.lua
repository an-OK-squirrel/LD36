State = require 'state'

function love.load()
    menu = State:new('menu')
end

function love.draw()
    menu:draw()
end
