function love.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	isDebugMode = true 
	isCollide = false

	isGameOver = false

	timeSinceLastSpawn = 0
	setInterval = 0.6

	score = 0

	player = {}
	player.l = 60 
	player.y = 450
	player.x = math.random(0, screenWidth - player.l)
	player.speed = 400
	player.sprite = love.graphics.newImage('ship.png')

	background = love.graphics.newImage('bg_space.png')

	enemyList = {}
	enemyList.sprite = love.graphics.newImage('meteor.png')

end

function resetGame()
	timeSinceLastSpawn = 0
	player.x = math.random(0, screenWidth - player.l)
	score = 0

	for i = #enemyList, 1, -1 do 
		table.remove(enemyList, i)
	end
end

function createEnemy()
    return {
		l = 35,
        x = math.random(0, screenWidth - 35),
        y = 0,
        speed = 350 
    }
end

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.update(dt)

	if not isGameOver then

		--score 
		score = math.floor(score + (dt * 60)) 

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

		-- enemy spawntimer
		timeSinceLastSpawn = timeSinceLastSpawn + dt 

		--using timers to make enemies
		if timeSinceLastSpawn >= setInterval then
			timeSinceLastSpawn = 0 
			table.insert(enemyList, createEnemy())
		end

		--loop through enemies in reverse and do checks 
		for i = #enemyList, 1, -1 do
			local enemy = enemyList[i]
			enemy.y = enemy.y + enemy.speed * dt

			--remove enemies that go off-screen
			if enemy.y > screenHeight then
				table.remove(enemyList, i)
			end

			--CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
			if CheckCollision(player.x,player.y,player.l,player.l, enemy.x,enemy.y,enemy.l,enemy.l) then
				isCollide = true
				isGameOver = true
			else
				isCollide = false
			end
		end

	elseif isGameOver then
		if love.keyboard.isDown("space") then
			resetGame()
			isGameOver = false
		end
	end
end

function resetGraphicsColor()
	love.graphics.setColor(1,1,1)
end

function love.draw()

	--bg
	love.graphics.draw(background, 0, 0)

	--draw player
	love.graphics.setColor(1,0,0)
	love.graphics.rectangle("line", player.x, player.y, player.l, player.l)
	resetGraphicsColor()
	love.graphics.draw(player.sprite, player.x, player.y, nil, 0.675)

	--draw enemy
	for i,enemy in ipairs(enemyList) do
		if isCollide then
			love.graphics.setColor(1,0,0)
		end
		love.graphics.rectangle("line", enemy.x, enemy.y, enemy.l, enemy.l)
		love.graphics.draw(enemyList.sprite, enemy.x, enemy.y, 0, 0.425)
	end

	--score
	love.graphics.print("Score: " .. score)
	
	--debug text
    love.graphics.setColor(1,1,1)
	if isDebugMode then
		love.graphics.print("screen width:" .. screenWidth, 0, 40)
		love.graphics.print("timer is at: " .. timeSinceLastSpawn, 0, 60)

		love.graphics.print("enemylist: " .. table.getn(enemyList), 0, 80)

		if isCollide then
			love.graphics.print("COLLIDE!", 0, 100)
		end
	end

	if isGameOver then
		love.graphics.print("GAME OVER PRESS SPACE TO AGAIN", 400,300)	
		love.graphics.print("Final Score is " .. score, 400,320)
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
-- [x] collision detection
-- [x] scoring system
-- [x] game over state
-- [ ] better sprites // or not
-- [ ] sound effects
