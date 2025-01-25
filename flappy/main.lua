require "player"

GRAVITY = 1000


function love.load()

    background = love.graphics.newImage("graphics/Sky.png")
    ground = love.graphics.newImage("graphics/ground.png")

    player_load()

end

function love.update(dt)
    player_update(dt)
end

function love.draw()

    --background
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, 280)

    player_draw()
end