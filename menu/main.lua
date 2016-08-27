local a = 6;
local state = {}
local manager

function state.setManager(p)
    manager = p
end

function state.draw()
    love.graphics.rectangle('fill', 0, 0, 100, 100)
end

function state.start()

end

function state.finish()

end

function state.update()

end

return state
