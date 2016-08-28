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

local imageNames = {'tile1', 'wall0', 'wall1', 'wall2', 'wall3', 'wall4', 'wall5', 'wall6', 'wall7', 'test', 'mirror0', 'mirror1', 'mirror2', 'mirror3'}

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

function love.mousepressed(x, y, button, isTouch)
    local minSize = math.min(love.graphics.getWidth(), love.graphics.getHeight())
    local xRatio = minSize / const.width
    local yRatio = minSize / const.height
    local xOffset = math.max(0, (love.graphics.getWidth() - minSize) / 2)
    local yOffset = math.max(0, (love.graphics.getHeight() - minSize) / 2)
    local newX = math.floor((x - xOffset) / xRatio)
    local newY = math.floor((y - yOffset) / yRatio)
    state:mouseClicked(newX, newY, button)
end
