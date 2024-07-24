function love.load()
	print("Hello world")

	player = {}
	player.x = 0
	player.y = 10
	player.l = 40

end

function love.update(dt)
end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, player.l, player.l)
end
