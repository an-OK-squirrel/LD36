States = require 'state'
local state

function love.load()
    state = States('menu')
end

function love.draw()
    state:draw()
end

function love.update()
    state:update()
end
