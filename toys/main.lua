require "player"
require "enemy"

g_ground = 280

function love.load()
	player_load()
	enemy_load()

	spr_ground = love.graphics.newImage('graphics/ground.png')
	spr_sky= love.graphics.newImage('graphics/Sky.png')

end

function love.update(dt)
	player_update(dt)
	enemy_update(dt)
end


function love.draw()

	love.graphics.draw(spr_sky, 0, 0)
	love.graphics.draw(spr_ground, 0, g_ground)
	player_draw()
	enemy_draw()
	
end
