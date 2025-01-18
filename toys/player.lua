function player_load()
    player = {}
    player.x = 30
    player.y = 280 - 80
    player.width = 50
    player.height = 80
    player.dy = 0
    player.isGrounded = true;
    player.sprite = love.graphics.newImage('graphics/Player/player_stand.png')
end

function player_update(dt)

    gravity = 1200
    ground = 280
    jump_str = 480

    player.dy = player.dy + gravity * dt

    -- handling the jump logic
    if love.keyboard.isDown("space") and player.isGrounded then
        player.isGrounded = false;
        player.dy = player.dy - jump_str 
    end

    player.y = player.y + player.dy * dt

    -- when player falls to the ground, reset
    if player.y + player.height > ground then
        player.y = ground - player.height;
        player.isGrounded = true
        player.dy = 0
    end    

end

function player_draw()
    love.graphics.print("player.y " .. player.y .. "; player.dy " .. player.dy)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    love.graphics.draw(player.sprite, player.x, player.y)
    love.graphics.line(0, 280, love.graphics.getWidth(), 280)
end