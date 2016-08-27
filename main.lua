States = require 'state'
const = require 'const'
local state

function love.load()
    state = States('menu')
end

function love.draw()
    -- Scaling
    local minSize = math.min(love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.scale(minSize / const.width, minSize / const.height)
    love.graphics.translate(math.max(0, (love.graphics.getWidth() - minSize) / 4), math.max(0, (love.graphics.getHeight() - minSize) / 4))
    -- Normal graphics
    state:draw()
end

function love.update()
    state:update()
end
