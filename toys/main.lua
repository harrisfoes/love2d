require "player"
require "enemy"

g_ground = 280
debug = true 
collide = false

function love.load()
	player_load()
	enemy_load()

	spr_ground = love.graphics.newImage('graphics/ground.png')
	spr_sky= love.graphics.newImage('graphics/Sky.png')

end

function love.update(dt)

	if not collide then
		player_update(dt)
		enemy_update(dt)
	end
end


function love.draw()	
	love.graphics.draw(spr_sky, 0, 0)
	love.graphics.draw(spr_ground, 0, g_ground)
	player_draw()
	enemy_draw()

	if collide then
		love.graphics.print("Let's stop this game!!", 0, 100)
	end

end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
		   x2 < x1+w1 and
		   y1 < y2+h2 and
		   y2 < y1+h1
end
