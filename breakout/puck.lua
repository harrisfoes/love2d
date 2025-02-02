function puck_load()
    puck = {}
    puck.width = 8;
    puck.height = 8;
    puck.x = VIRTUAL_WIDTH / 2
    puck.y = VIRTUAL_HEIGHT / 2
    puck.dy = -1 
    puck.dx = math.random(-1,1)
    puck.speed = 100;
end

function puck_update(dt)
    puck.x = puck.x + puck.speed * puck.dx * dt
    puck.y = puck.y + puck.speed * puck.dy * dt
end

function puck_draw()
    love.graphics.rectangle("fill", puck.x, puck.y, puck.width, puck.height)
end