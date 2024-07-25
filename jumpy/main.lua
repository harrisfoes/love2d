function love.load()
	print("Hello world")

	player = {}
	player.x = 20
	player.y = 400
	player.l = 40

end

function love.keypressed(key)	
		player.y = player.y - 60
end

function love.update(dt)


	--falling down
	if player.y < 400 then
		player.y = player.y + 18 * dt
	end

end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, player.l, player.l)
end
