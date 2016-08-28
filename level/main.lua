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

local oldLights = {}

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
            love.graphics.draw(images[level[y][x]:getImage()], getScreenPos(x), getScreenPos(y))
        end
    end

    for i, light in ipairs(oldLights) do
        love.graphics.draw(images['light' .. (light.stub and 1 or 0)], getScreenPos(light.x) + const.tileSize / 2, getScreenPos(light.y) + const.tileSize / 2, math.pi * light.direction / 2, 1, 1, const.tileSize / 2, const.tileSize / 2)
    end

    for k, object in ipairs(objects) do
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

    -- LIGHT STUFF OH MY GOD I'M DEAD

    local lights = data.lights -- stuff to calculate
    oldLights = {} -- stuff to not calculate
    local newLights = {} -- stuff to calculate next

    while #lights > 0 do
        for i, l in ipairs(lights) do
            (function(light)
                newLights = {}
                local offset = ({{0,-1},{1,0},{0,1},{-1,0}})[light.direction + 1]
                local newX = light.x + offset[1]
                local newY = light.y + offset[2]
                if newX * newY == 0 then return end
                if newX >const.gridSize or newY > const.gridSize then return end
                reflectResult = level[newY][newX]:getBouncedLight(light.direction)
                if #reflectResult > 0 then
                    if #reflectResult > 1 or reflectResult[1] ~= light.direction then
                         table.insert(oldLights, {x = newX, y = newY, direction = (light.direction + 2) % 4, stub = true})
                    end
                    for j, reflect in ipairs(reflectResult) do
                        table.insert(newLights, {x = newX, y = newY, direction = reflect, stub = light.direction ~= reflect})
                    end
                end
            end
            )(l)
        end
        for i = 1, #lights do
            oldLights[#oldLights + 1] = lights[i]
        end
        lights = newLights
    end
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
