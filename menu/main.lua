local a = 6;
local state = {}

function state.draw()
    love.graphics.rectangle('fill', 0, 0, 100, 100)
end

function state.start()
end

function state.finish()
end

return state
