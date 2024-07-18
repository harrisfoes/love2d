function love.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	isDebugMode = true 

	timeSinceLastSpawn = 0
	setInterval = 1.2

	player = {}
	player.y = 450
	player.x = 50
	player.l = 60
	player.speed = 400

	enemyList = {}

end

function createEnemy()
    return {
		l = 35,
        x = math.random(0, screenWidth - 35),
        y = 0,
        speed = 350 
    }
end

function love.update(dt)
	-- timer
	timeSinceLastSpawn = timeSinceLastSpawn + dt 

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

	--using timers
	--enemylist 30
	if timeSinceLastSpawn >= setInterval then
		timeSinceLastSpawn = 0 
		table.insert(enemyList, createEnemy())
		print(table.getn(enemyList))
	end

	for i = #enemyList, 1, -1 do
		local enemy = enemyList[i]
		enemy.y = enemy.y + enemy.speed * dt

		--remove enemies that go off-screen
		if enemy.y > screenHeight then
			table.remove(enemyList, i)
		end
	end
end

function love.draw()

	--draw player
	love.graphics.rectangle("fill", player.x, player.y, player.l, player.l)

	--draw enemy
	for i,enemy in ipairs(enemyList) do
		love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.l, enemy.l)
	end
	
	--debug text
	if isDebugMode then
		love.graphics.print(player.x)
		love.graphics.print("screen width:" .. screenWidth, 0, 20)
		love.graphics.print("timer is at: " .. timeSinceLastSpawn, 0, 60)
	end

end




-- [x] build character + movement left to right + bounds
-- [x] make enemies fall from the screen
--		[x] randomize enemy x location
--		[x] for every n seconds
--		[x] create new enemy
--		[x] let it fall to the screen
--		[x] destroy enemy
--		[x] store them on a list maybe
-- [ ] collision detection
-- [ ] scoring system
-- [ ] game over state
