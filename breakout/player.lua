function player_load()
    player = {}
    player.height = 20
    player.width = 100
    player.x = VIRTUAL_WIDTH / 2 - (player.width / 2)
    player.y = 240
    player.speed = 100
end

function player_update(dt)

    if love.keyboard.isDown("left") then
        player.x = math.max(0, player.x - player.speed * dt)
    end

    if love.keyboard.isDown("right") then
        player.x = math.min(VIRTUAL_WIDTH - player.width , player.x + player.speed * dt)
    end

end

function player_draw()
    love.graphics.print("player: " .. player.x, 0, 20)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

