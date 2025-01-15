require "player"
require "enemy"

function love.load()
	player_load()
	enemy_load()
end

function love.update(dt)
	player_update(dt)
	enemy_update(dt)
end


function love.draw()
	player_draw()
	enemy_draw()
end
