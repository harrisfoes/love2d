function player_load()
    player = {}
    player.x = 30
    player.y = 260
    player.width = 50
    player.height = 40
    player.dy = 0
    player.isGrounded = true;
end

function player_update()

    gravity = 0.3
    ground = 260

    player.dy = player.dy + gravity

    if love.keyboard.isDown("space") and player.isGrounded then
        player.isGrounded = false;
        player.dy = player.dy - 10
    end

    player.y = player.y + player.dy

    if player.y > ground then
        player.y = ground;
        player.isGrounded = true
    end    

end

function player_draw()
    love.graphics.print("player.y " .. player.y .. "; player.dy " .. player.dy)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end