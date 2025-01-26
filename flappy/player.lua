function player_load()
    player = {}
    player.sprite = love.graphics.newImage("graphics/Fly1.png")
    player.width = player.sprite:getWidth()
    player.height = player.sprite:getHeight()
    player.x = VIRTUAL_WIDTH / 2 - player.width / 2
    player.y = VIRTUAL_HEIGHT / 2 - player.height - 50
    player.dy = 0
end

function player_update(dt)

    player.dy = player.dy + GRAVITY * dt

    if love.keyboard.wasPressed("space") then
        player.dy = -JUMP_STRENGTH 
        spacey = true
    else
        spacey = false
    end

    player.y = player.y + player.dy
end

function player_draw()
    love.graphics.draw(player.sprite, player.x, player.y)
    love.graphics.print(player.x, 0, 20)
    love.graphics.print(player.y, 0, 10)

    if spacey then
        love.graphics.print("spacey", 0, 30)
    else
        love.graphics.print("un-spacey", 0, 30)
    end

    love.graphics.print("awaw", player.x, player.y)
end
