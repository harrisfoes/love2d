local push = require "push"
require "player"

GAMEWIDTH = 1280
GAMEHEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT= 288


push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, GAMEWIDTH, GAMEHEIGHT, {
    fullscreen = false,
    vsync = true
})


function love.load()

    love.graphics.setDefaultFilter("nearest", "nearest")

    love.keyboard.keysPressed = {}

    player_load()

end

function love.update(dt)

    player_update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == "escape" then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()

    push:start()

    love.graphics.print("hello world", 0, 10)
    player_draw()

    push:finish()

end