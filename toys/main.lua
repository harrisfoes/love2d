require "player"
require "enemy"

g_ground = 300
debug = false  
game_over = false

function love.load()
	player_load()
	enemy_load()

	spr_ground = love.graphics.newImage('graphics/ground.png')
	spr_sky= love.graphics.newImage('graphics/Sky.png')

	sounds = {}
	sounds.bg = love.audio.newSource("audio/music.wav", "stream", "true")
	sounds.bg:setLooping(true)
	sounds.jump = love.audio.newSource("audio/jump.mp3", "stream", "true")

	love.audio.setVolume(0.2)
	sounds.bg:play()

	font = love.graphics.newFont('font/Pixeltype.ttf', 40)
	score = 0

end

function love.update(dt)

	if not game_over then

		--score
		score = math.floor(score + (dt * 90))

		player_update(dt)
		enemy_update(dt)
	end

	if game_over then
		--
		if love.keyboard.isDown("return") then
			reset_game()
		end
	end
end


function love.draw()	

	--draw the stuff
	love.graphics.draw(spr_sky, 0, 0)
	love.graphics.draw(spr_ground, 0, g_ground)
	player_draw()
	enemy_draw()

	--score
	love.graphics.setFont(font)
	love.graphics.setColor(0, 0.4, 0.6, 0.3)
	love.graphics.printf("Score: " .. score, 20, 30, love.graphics.getWidth(), "left")
	love.graphics.reset()

	--game over logic
	if game_over then
		sounds.bg:stop()
		love.graphics.setFont(font)
		love.graphics.setColor(1, 0.4, 0.6, 0.3)
		love.graphics.printf("GAME OVER!", 0, 200, love.graphics.getWidth(), "center")
		love.graphics.printf("Press <Enter> to play again", 0, 240, love.graphics.getWidth(), "center")
		love.graphics.reset()
	end

end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
		   x2 < x1+w1 and
		   y1 < y2+h2 and
		   y2 < y1+h1
end

function reset_game() 

	score = 0
	game_over = false

	player_reset()
	enemy_reset()
	sounds.bg:play()
end
