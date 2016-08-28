local sprites = {}
local class = require('middleclass')

sprites.Sprite = class('Sprite')

function sprites.Sprite:initialize(x, y)
    self.x = x
    self.y = y

    self.lastX = x
    self.lastY = y
    self.nextX = x
    self.nextY = y
    self.framesMoving = 0
    self.framesDone = 0
    self.moving = false
end

function sprites.Sprite:goTo(x, y, frames)
    self.framesMoving = frames
    self.framesDone = 0
    self.lastX = x
    self.lastY = y
    self.nextX = self.x
    self.nextY = self.y
    self.moving = true
end

function sprites.Sprite.getImage()
    return 'test'
end

function sprites.Sprite.blocksLight()
    return true
end

function sprites.Sprite.move()
    if self.moving then
        self.x = self.lastX + (self.newX - self.lastX) / (framesDone / framesMoving)
        self.y = self.lastY + (self.newY - self.lastY) / (framesDone / framesMoving)
    end
end

return sprites
