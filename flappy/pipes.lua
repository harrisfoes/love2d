local pipeRespawnTimer = 0
local pipeRespawnInterval = 2.7
local pipeSpeed = 100

function pipes_load()
    pipeList = {}
end

function create_pipe()

    local height = math.random(40, 160)
    local gap = math.random(85, 120)

    return {
        topX = VIRTUAL_WIDTH - 10,
        topY = 0,
        width = 60,
        height = height,
        gap = gap 
    }
end

function pipes_update(dt)
    pipeRespawnTimer = pipeRespawnTimer + dt

    if pipeRespawnTimer > pipeRespawnInterval then
        table.insert(pipeList, create_pipe())
        pipeRespawnTimer = 0
    end

    for i = #pipeList, 1, -1 do
        local pipe = pipeList[i]
        pipe.topX = pipe.topX - pipeSpeed * dt

        if pipe.topX + pipe.width < 0 then
            table.remove(pipeList, i)
        end
    end
end

function pipes_draw()

    love.graphics.print("timer " .. pipeRespawnTimer, 0, 60)
    love.graphics.print("pipe size " .. #pipeList, 0, 70)

    for i, pipes in ipairs(pipeList) do
        love.graphics.setColor(255,0,255)
        love.graphics.rectangle("fill", pipes.topX, pipes.topY, pipes.width, pipes.height)
        love.graphics.rectangle("fill", pipes.topX, pipes.topY + pipes.height + pipes.gap, pipes.width, VIRTUAL_HEIGHT - pipes.topY)
    end

end