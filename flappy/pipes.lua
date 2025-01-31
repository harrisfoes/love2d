require "player"

local pipeRespawnTimer = 0
local pipeRespawnInterval = 1.5
local pipeSpeed = 120

local pipeImage = love.graphics.newImage("graphics/pipe.png")
local pipeImageHeight = pipeImage:getHeight()
local pipeImageWidth = pipeImage:getWidth()

local score = love.audio.newSource('audio/score.wav', 'stream', 'true')
local explode = love.audio.newSource('audio/explosion.wav', 'stream', 'true')

function pipes_load()
    pipeList = {}
end

function create_pipe()

    local height = math.random(40, 150)
    local gap = math.random(90, 120)

    return {
        topX = VIRTUAL_WIDTH - 10,
        topY = 0,
        width = 60,
        height = height,
        gap = gap,
        pipeIsChecked = false
    }
end

function pipes_update(dt)

    pipeRespawnTimer = pipeRespawnTimer + dt

    if pipeRespawnTimer > pipeRespawnInterval then
        table.insert(pipeList, create_pipe())
        pipeRespawnTimer = 0
        pipeRespawnInterval = math.random(1.6,2.8)
    end

    for i = #pipeList, 1, -1 do
        local pipe = pipeList[i]

        --pipes move backwards
        pipe.topX = pipe.topX - pipeSpeed * dt

        --destroy pipe if out of bounds
        if pipe.topX + pipe.width < 0 then
            table.remove(pipeList, i)
        end

        --collider minified
        local colliderX = player.x + 12
        local colliderY = player.y + 12
        local colliderW = player.width - 32
        local colliderH = player.height - 16

        --check collision
        if checkCollision(pipe.topX,pipe.topY,pipe.width, pipe.height, colliderX, colliderY, colliderW, colliderH)
            or checkCollision(pipe.topX, pipe.topY + pipe.height + pipe.gap, pipe.width, VIRTUAL_HEIGHT - pipe.topY, colliderX, colliderY, colliderW, colliderH)
        then
            explode:play()
            game_state = "game_over"
        end

        --score
        if player.x > pipe.topX + pipe.width and pipe.pipeIsChecked == false then
            SCORE = SCORE + 100
            score:play()
            pipe.pipeIsChecked = true
        end
    end

end

function pipes_draw()

    for i, pipes in ipairs(pipeList) do

    --topPipeQuad:flip(true,false)

        --top
        love.graphics.draw(pipeImage, pipes.topX, pipes.height, 0, -1, -1, pipeImageWidth)
        --bottom
        love.graphics.draw(pipeImage, pipes.topX, pipes.topY + pipes.height + pipes.gap)

        -- debug lines top / bottom
        if DEBUG then
            love.graphics.setColor(255,0,255)
            love.graphics.rectangle("line", pipes.topX, pipes.topY, pipes.width, pipes.height)
            love.graphics.rectangle("line", pipes.topX, pipes.topY + pipes.height + pipes.gap, pipes.width, VIRTUAL_HEIGHT - pipes.topY)
            love.graphics.setColor(1,1,0)
            love.graphics.rectangle("line", player.x + 12, player.y + 12, player.width - 32, player.height - 16)
            love.graphics.setColor(1,1,1)
        end 

    end

end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

function pipes_reset()

    pipeRespawnTimer = 0

    for i = #pipeList, 1, -1 do
        local pipe = pipeList[i]
        table.remove(pipeList, i)
    end
end