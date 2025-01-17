function enemy_load()
    enemy_list = {}

    time_since_last_spawn = 0
    set_interval = 0.6 
end

function create_enemy()
    return {
        width = 60,
        height = 60,
        x = love.graphics.getWidth(), --todo check this value
        y = 260,
        speed = 600
    }
end

function enemy_update(dt)

    --enemy creation with intervals
    time_since_last_spawn = time_since_last_spawn + dt

    if time_since_last_spawn >= set_interval then
        time_since_last_spawn = 0
        set_interval = math.random(0.8, 2)
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
    love.graphics.print("enemy is here",0,20)
    love.graphics.print("timeSince" .. time_since_last_spawn, 0, 40)
    love.graphics.print("setInterval" .. set_interval, 0, 60)
     
    --enemy draw from table
    love.graphics.setColor(1,0,0)
    for i, enemy in ipairs(enemy_list) do
        love.graphics.rectangle("fill", enemy.x, 260, enemy.width, enemy.height) 
    end
    love.graphics.reset()

end
