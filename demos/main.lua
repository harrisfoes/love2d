-- we want shapes to move different places
-- then we want the shapes to bounce around in the 
--
--
--
function love.load()
	shape1_x = 100
	shape1_w = 150
	shape1_h = 200

	speed = 200
	forward = true
end

function love.update(dt)

	--forward and back
	if forward then
		shape1_x = shape1_x + speed * dt
	else
		shape1_x = shape1_x - speed * dt
	end	

	-- direction logic
	if shape1_x >= 600 then
		forward = false	
	elseif shape1_x < 0 then
		forward = true	
	end
end

function love.draw()
	--print(x)
	--print(forward)
	love.graphics.rectangle("line", shape1_x, 50, shape1_h, shape1_w)
	love.graphics.print("indie", shape1_x +  (shape1_w / 2), shape1_h / 2)
end
