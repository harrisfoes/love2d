function player_load()

    player = {}
    player.sprite = love.graphics.newImage("graphics/Fly1.png")
    player.width = player.sprite:getWidth()
    player.height = player.sprite:getHeight()
    player.x = VIRTUAL_WIDTH / 2 - player.width / 2
    player.y = VIRTUAL_HEIGHT / 2 - player.height - 50
    player.dy = 0

    player.jumpSound = love.audio.newSource("audio/jump.wav", "stream", "true")

end

function player_update(dt)

    player.dy = player.dy + GRAVITY * dt

    if love.keyboard.wasPressed("space") then
        player.dy = -JUMP_STRENGTH 
        player.jumpSound:play() 
    end

    player.y = player.y + player.dy

    if player.y > VIRTUAL_HEIGHT then
        game_state = "game_over"
    end

end

function player_draw()

    love.graphics.draw(player.sprite, player.x, player.y)

end

function player_reset()
    player.x = VIRTUAL_WIDTH / 2 - player.width / 2
    player.y = VIRTUAL_HEIGHT / 2 - player.height - 50
    player.dy = -3
end
