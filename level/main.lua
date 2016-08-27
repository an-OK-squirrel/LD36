local const = require 'const'
local tiles = require 'level/tile'
local levels = require 'level/leveldata'
local pp = require 'pprint'

local a = 6;
local state = {}
local manager
local images = {}
local level = {}

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
end

function state.start()
    images = manager.images
    state.setLevel(1)
end

function state.setLevel(n)
    level = map(levels[n], function(a) return map(a, tiles.getTileFromNumber) end)
end

function state.finish()

end

function state.update()

end

return state
