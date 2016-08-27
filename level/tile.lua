local const = require 'const'
local class = require 'middleclass'

local tiles = {}

tiles.Tile = class('Tile')

function tiles.Tile:initialize(n)
    self.solid = self:isSolid()
    self.meta = n
end

function tiles.Tile:isSolid()
    return false
end

function tiles.Tile:getBouncedLight(direction)
    if self.solid then
        return {}
    else
        return {direction}
    end
end

function tiles.Tile:getImage()
    return 'tile1'
end

tiles.Floor = class('Floor', tiles.Tile)

tiles.Wall = class('Wall', tiles.Tile)

function tiles.Tile:isSolid()
    return true
end

function tiles.Wall:getImage()
    return 'wall' .. self.meta
end

function tiles.getTileFromNumber(n)
    if n == 0 then
        return tiles.Floor(0)
    elseif n < 17 then
        return tiles.Wall(n - 1)
    end
end

return tiles
