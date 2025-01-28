require "player"
require "pipes"
local push = require "push"

local GAME_WIDTH = 1280
local GAME_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GRAVITY = 20
JUMP_STRENGTH = 5

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413


function love.load()

    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, GAME_WIDTH, GAME_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    background = love.graphics.newImage("graphics/background.png")
    ground = love.graphics.newImage("graphics/ground.png")

    backgroundScroll = 0
    groundScroll = 0

    love.keyboard.keysPressed = {}

    player_load()
    pipes_load()

end

function love.update(dt)

    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % 500

    player_update(dt)
    pipes_update(dt)

    --reset the keys pressed table, we only want to check per frame
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

    --background
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, 272)
    
    player_draw()
    pipes_draw()

    push:finish()
end