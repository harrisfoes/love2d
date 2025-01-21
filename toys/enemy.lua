function enemy_load()
    enemy_list = {}

    time_since_last_spawn = 0
    set_interval = 0.6 
    snail_image = love.graphics.newImage('graphics/snail/snail1.png')
end

function create_enemy()
    return {
        width = snail_image:getWidth(),
        height = snail_image:getHeight(),
        x = love.graphics.getWidth(), --todo che`ck this value
        y = 250,
        speed = math.random(600, 800),
        sprite = snail_image 
    }
end

function enemy_update(dt)

    --enemy creation with intervals
    time_since_last_spawn = time_since_last_spawn + dt

    if time_since_last_spawn >= set_interval then
        time_since_last_spawn = 0
        set_interval = math.random(0.8, 3)
        table.insert(enemy_list, create_enemy())
    end

    --enemy movement / collision / destruction
    for i = #enemy_list, 1, -1 do
        local enemy = enemy_list[i]
        if enemy.x <= 0 then
            table.remove(enemy_list, i)
        else 
            enemy.x = enemy.x - enemy.speed * dt
        end
    end

end

function enemy_draw(dt)

    --debug
    if debug then
        love.graphics.setColor(1,0,0)
        love.graphics.print("timeSince" .. time_since_last_spawn, 0, 40)
        love.graphics.print("setInterval" .. set_interval, 0, 60)
        love.graphics.reset()
    end
     
    --enemy draw from table
    for i, enemy in ipairs(enemy_list) do

        if debug then
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill", enemy.x, 250, enemy.width, enemy.height) 
            love.graphics.print("speed" .. enemy.speed, i * 120,20)
            love.graphics.reset()
        end

        love.graphics.draw(enemy.sprite, enemy.x, enemy.y)
    end

end
