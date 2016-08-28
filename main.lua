local States = require 'state'
local const = require 'const'

local state
local images = {}

function love.load()
    state = States('menu')
    state.images = images
end

function loadImage(name)
    images[name] = love.graphics.newImage('assets/'..name..'.png')
end

local imageNames = {'tile1', 'wall0', 'wall1', 'wall2', 'wall3', 'wall4', 'wall5', 'wall6', 'wall7', 'test'}

for _, imageName in pairs(imageNames) do
    loadImage(imageName)
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
