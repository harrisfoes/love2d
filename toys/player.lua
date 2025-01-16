function player_load()
    player = {}
    player.x = 30
    player.y = 260
    player.width = 50
    player.height = 40
    player.dy = 0
    player.isGrounded = true;
end

function player_update(dt)

    gravity = 1200
    ground = 260
    jump_str = 480

    player.dy = player.dy + gravity * dt

    -- handling the jump logic
    if love.keyboard.isDown("space") and player.isGrounded then
        player.isGrounded = false;
        player.dy = player.dy - jump_str 
    end

    player.y = player.y + player.dy * dt

    -- when player falls to the ground, reset
    if player.y > ground then
        player.y = ground;
        player.isGrounded = true
        player.dy = 0
    end    

end

function player_draw()
    love.graphics.print("player.y " .. player.y .. "; player.dy " .. player.dy)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end