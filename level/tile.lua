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

function tiles.Wall:isSolid()
    return true
end

function tiles.Wall:getImage()
    return 'wall' .. self.meta
end

tiles.Mirror = class('Mirror', tiles.Tile)

function tiles.Mirror.isSolid()
    return true
end

function tiles.Mirror:getImage()
    return 'mirror' .. self.meta
end

function tiles.Mirror:getBouncedLight(direction)
    if direction == self.meta then
        return {(direction + 1) % 4}
    elseif (direction + 1) % 4 == self.meta then
        return {(direction + 2) % 4}
    end
    return {}
end

function tiles.getTileFromNumber(n)
    if n == 0 then
        return tiles.Floor(0)
    elseif n < 17 then
        return tiles.Wall(n - 1)
    elseif n < 25 then
        return tiles.Mirror(n - 17)
    end
    return 'test'
end

return tiles
