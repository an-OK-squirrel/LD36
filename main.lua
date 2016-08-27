States = require 'state'
const = require 'const'
local state

function love.load()
    state = States('menu')
end

function love.draw()
    -- Scaling
    local minSize = math.min(love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.translate(math.max(0, (love.graphics.getWidth() - minSize) / 2), math.max(0, (love.graphics.getHeight() - minSize) / 2))
    love.graphics.scale(minSize / const.width, minSize / const.height)
    -- Rest of graphics
    state:draw()
end

function love.update()
    state:update()
end
