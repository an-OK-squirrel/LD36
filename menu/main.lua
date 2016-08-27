const = require 'const'

local a = 6;
local state = {}
local manager

function state.setManager(p)
    manager = p
end

function state.draw()
    love.graphics.rectangle('fill', 0, 0, const.width, const.height)
end

function state.start()

end

function state.finish()

end

function state.update()
    if love.keyboard.isDown('space') then
        manager:switchState('level')
    end
end

return state
