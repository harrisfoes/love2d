-- we want shapes to move different places
-- then we want the shapes to bounce around in the 
--
--
--
function love.load()

	love.window.setTitle("demos_l2d")
	print(love.window.getTitle())

	love.window.setMode(1200, 760)

	shape1_x = 100
	shape1_w = 150
	shape1_h = 200

	shape2_x= 200
	shape2_y = 340
	shape2_w = 80
	shape2_h = 300

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
	if shape1_x > 600 then
		speed = speed * -1
	elseif shape1_x < 0 then
		shape1_x = 1
		speed = speed * -1
	end

	--shape 2
	shape2_x = shape2_x + speed * dt

end

function love.draw()
	--print(x)
	--print(forward)
	love.graphics.rectangle("line", shape1_x, 50, shape1_h, shape1_w)
	love.graphics.print("indie", shape1_x +  (shape1_w / 2), shape1_h / 2)

	love.graphics.rectangle("line", shape2_x, shape2_y, shape2_h, shape2_w)
	love.graphics.print("second", shape2_x +  (shape2_w / 2), shape2_y + (shape2_h / 2))

end
