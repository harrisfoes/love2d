local push = require "push"
require "player"
require "puck"

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

    --random seed
    math.randomseed(os.time())

    player_load()
    puck_load()

end

function love.update(dt)

    player_update(dt)
    puck_update(dt)

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
    puck_draw()

    push:finish()

end