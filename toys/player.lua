
player_box = love.graphics.newImage('graphics/Player/player_stand.png')


function player_load()
    player = {}
    player.x = 30
    player.y = 300 - 80
    player.width = player_box:getWidth() 
    player.height = player_box:getHeight() 
    player.dy = 0
    player.isGrounded = true
    player.spr_jump = love.graphics.newImage('graphics/Player/jump.png')
    player.spr_walk1 = love.graphics.newImage('graphics/Player/player_walk_1.png')
    player.spr_walk2 = love.graphics.newImage('graphics/Player/player_walk_2.png')
    
    walkcycle_counter = 0
    walkcycle_interval = 0.15
    walksprite = 1
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
        sounds.jump:play()
    end

    player.y = player.y + player.dy * dt

    -- when player falls to the ground, reset
    if player.y + player.height > g_ground then
        player.y = g_ground - player.height
        player.isGrounded = true
        player.dy = 0
    end 
    
    --animation counter
    walkcycle_counter = walkcycle_counter + dt

    if walkcycle_counter >= walkcycle_interval then
        walkcycle_counter = 0
        if walksprite == 1 then
            walksprite = 2
        else
            walksprite = 1
        end
    end


end

function player_debug()

    love.graphics.setColor(1,0,0)
    love.graphics.print("player.y " .. player.y .. "; player.dy " .. player.dy)
    love.graphics.setColor(1,0,1)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    love.graphics.reset()
    --love.graphics.line(0, 280, love.graphics.getWidth(), 280)
end

function player_draw()

    if debug then
        player_debug()
    end

    if player.isGrounded then
        if walksprite == 1 then
            love.graphics.draw(player.spr_walk1, player.x, player.y)
        elseif walksprite == 2 then
            love.graphics.draw(player.spr_walk2, player.x, player.y)
        end
    else
        love.graphics.draw(player.spr_jump, player.x, player.y)
    end
end

function player_reset()
    player.x = 30
    player.y = 220
    player.isGrounded = true
    walkcycle_counter = 0
end