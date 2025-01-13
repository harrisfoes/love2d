function love.load()
isSpace = false;
end

function love.update()

	if love.keyboard.isDown("space") then
		isSpace = true;
	end


end


function love.draw()
	if isSpace then
		love.graphics.print("Hello World", 400,300 )
		isSpace = false
	end

	love.graphics.rectangle("fill", 20, 300, 60, 120, 16, 16)
end
