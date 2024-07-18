function love.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	isDebugMode = false 

	player = {}
	player.y = 450
	player.x = 50
	player.l = 60
	player.speed = 400

	enemy = {}
	enemy.l = 30
	enemy.speed = 350  
	enemy.y = 0 
	math.randomseed(7)
	enemy.x = math.random(0, screenWidth - enemy.l)

end

function love.update(dt)

	--player movement left and right
	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed * dt
	elseif love.keyboard.isDown("left") then
		player.x = player.x - player.speed * dt 
	end
	
	--player bounds
	if player.x < 0 then
		player.x = 0
	elseif player.x > screenWidth - player.l then
		player.x = screenWidth - player.l
	end

	--enemy
	enemy.y = enemy.y + enemy.speed	* dt
	if enemy.y > screenHeight then
		enemy.x = math.random(0, screenWidth - enemy.l)
		enemy.y = 0
	end
end

function love.draw()

	--draw player
	love.graphics.rectangle("fill", player.x, player.y, player.l, player.l)

	--draw enemy
	love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.l, enemy.l)
	
	--debug text
	if isDebugMode then
		love.graphics.print(player.x)
		love.graphics.print("screen width:" .. screenWidth, 0, 20)
		love.graphics.print("enemy x: " .. enemy.x, 0, 40)
	end

end




-- [x] build character + movement left to right + bounds
-- [ ] make enemies fall from the screen
--		[x] randomize enemy x location
--		[ ] for every n seconds
--		[ ] create new enemy
--		[ ] let it fall to the screen
--		[ ] destroy enemy
-- [ ] store them on a list maybe
-- [ ] collision detection
