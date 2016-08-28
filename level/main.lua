local const = require 'const'
local tiles = require 'level/tile'
local levels = require 'level/leveldata'
local sprite = require 'level/sprite'
local pp = require 'pprint'

local a = 6;
local state = {}
local manager
local images = {}
local level = {}
local data = {}
local objects = {}

local playerX = 1
local playerY = 1
local animationFramesLeft = 0

function map(table, func)
    local result = {}
    for k, v in pairs(table) do
        result[k] = func(v, k)
    end
    return result
end

function state.setManager(p)
    manager = p
end

function state.draw()
    for y = 1, const.gridSize  do
        for x = 1, const.gridSize do
            love.graphics.draw(images[level[y][x]:getImage()], (x - 1) * const.tileSize, (y - 1) * const.tileSize)
        end
    end

    for k,object in ipairs(objects) do
        love.graphics.draw(images[object:getImage()], object.x, object.y)
    end
end

function state.start()
    images = manager.images
    state.setLevel(1)
end

function state.setLevel(n)
    level = map(levels[n][1], function(a) return map(a, tiles.getTileFromNumber) end)
    data = levels[n][2]
    playerX = data.playerX
    playerY = data.playerY
    objects = {}
    objects[1] = sprite.Sprite(getScreenPos(data.playerX), getScreenPos(data.playerY))
end

function state.finish()

end

function state.update()
    -- SPRITE ANIMATION MOVEMENT
    for k,object in ipairs(objects) do
        object:move()
    end
    animationFramesLeft = animationFramesLeft - 1
    if animationFramesLeft > 0 then return end
    -- PLAYER MOVEMENT
    if love.keyboard.isDown('up') then movePlayerTo(playerX, playerY - 1, 30) end
    if love.keyboard.isDown('down') then movePlayerTo(playerX, playerY + 1, 30) end
    if love.keyboard.isDown('left') then movePlayerTo(playerX - 1, playerY, 30) end
    if love.keyboard.isDown('right') then movePlayerTo(playerX + 1, playerY, 30) end
end

function movePlayerTo(x, y, f)
    if x < 1 or y < 1 then return false end
    if level[y][x].isSolid() then return false end
    playerX = x
    playerY = y
    animationFramesLeft = math.max(30, animationFramesLeft)
    objects[1]:moveTo(getScreenPos(x), getScreenPos(y), f)
    return true
end

function state.mouseClicked(x, y, button)
    local tileX = math.floor(x / const.tileSize) + 1
    local tileY = math.floor(y / const.tileSize) + 1
    print(tileX, tileY)
end

function getScreenPos(n)
    return (n - 1) * const.tileSize
end

return state
