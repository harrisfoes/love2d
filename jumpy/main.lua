function love.load()
	print("Hello world")

	ground_x = 450

	player = {}
	player.x = 40
	player.y = 400
	player.l = 80 
	player.gravity = 0


end

function love.keypressed(key)	
		player.y = player.y - 200
end

function love.update(dt)


	--falling down
	player.y = player.y + 300 * dt
	player.gravity  = player.gravity + 1
	if player.y > 400 then
		player.y = 400
	end


end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, player.l, player.l)
end



---Planning for jumpy dino game
--[ ] make dino jump
--[ ] make dino fall
--[ ] make enemies appear from the horizon
--[ ] add background
