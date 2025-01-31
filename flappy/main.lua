require "player"
require "pipes"
local push = require "push"

local GAME_WIDTH = 1280
local GAME_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

GRAVITY = 20
JUMP_STRENGTH = 5

DEBUG = false 

SCORE = 0

--game states
-- when game open -> start, when defeated -> game_over, when enter pressed -> start
game_state = "start"

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

    math.randomseed(os.time())

    player_load()
    pipes_load()

    sounds = {}
    sounds.bg = love.audio.newSource('audio/marios_way.mp3', 'stream', 'true')
    sounds.bg:setLooping(true)

    love.audio.setVolume(0.2)
    sounds.bg:play()

    font = love.graphics.newFont('fonts/press_start.ttf', 12)

end

function love.update(dt)

    if game_state == "start" then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % 500
        player_update(dt)
        pipes_update(dt)
    end

    if game_state == "game_over" then

        sounds.bg:stop()

        if love.keyboard.wasPressed("return") then
            reset_game()
        end
    end

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

    pipes_draw()
    player_draw()

    love.graphics.draw(ground, -groundScroll, 272)

    love.graphics.setFont(font)

    if game_state == "game_over" then
       love.graphics.printf("Press <Enter> to play again", 0, 240, VIRTUAL_WIDTH, "center")
    end
    
    love.graphics.print("SCORE: " .. SCORE, 20, 10)

    push:finish()
end

function reset_game()
    game_state = "start"
    backgroundScroll = 0
    groundScroll = 0
    SCORE = 0
    sounds.bg:play()
    player_reset()
    pipes_reset()
end


