require "player"

GRAVITY = 500

local BACKGROUND_SCROLL_SPEED = 300
local BACKGROUND_LOOPING_POINT = 413


function love.load()

    background = love.graphics.newImage("graphics/background.png")
    ground = love.graphics.newImage("graphics/ground.png")

    backgroundScroll = 0

    player_load()

end

function love.update(dt)

    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    player_update(dt)
end

function love.draw()

    --background
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, 0, 272)
    love.graphics.print(backgroundScroll, 0, 400)
    

    player_draw()
end