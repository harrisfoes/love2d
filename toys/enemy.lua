function enemy_load()
    enemy = {}
    enemy.width = 60
    enemy.height = 60
    enemy.x = love.graphics.getWidth() - enemy.width
    enemy.y = 260
    enemy.speed = 8 
end

function enemy_update(dt)
    -- move the enemy backwards
    enemy.x = enemy.x - enemy.speed

    --reset the enemy
    if enemy.x <= 0 then
        enemy.x = love.graphics.getWidth() - enemy.width
    end
end

function enemy_draw(dt)
    love.graphics.print("enemy is here",0,20)
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill", enemy.x, 260, enemy.width, enemy.height) 
    love.graphics.reset()
end
