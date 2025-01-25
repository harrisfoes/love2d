function player_load()
    player = {}
    player.sprite = love.graphics.newImage("graphics/Fly1.png")
    player.width = player.sprite:getWidth()
    player.height = player.sprite:getHeight()
    player.x = love.graphics.getWidth() / 2 - player.width / 2
    player.y = love.graphics.getHeight() / 2 - player.height - 50
end

function player_update(dt)
    player.y = player.y + GRAVITY * dt
end

function player_draw()
    love.graphics.draw(player.sprite, player.x, player.y)
end
