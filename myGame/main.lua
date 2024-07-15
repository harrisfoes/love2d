function love.load()
    x = 50
    forward = true

    fruits = {"apple", "banana"}
end

function love.update(dt)
    speed = 150

    if forward then
        x = x + speed * dt
    else
        x = x - speed * dt
    end

    if x >= 200 or x <= 20 then
        forward = not forward
    end

end


function love.draw()
    love.graphics.circle("fill", 10, 10, 100, 25)
    love.graphics.rectangle("line", 200, 30, 120, 100)
    love.graphics.rectangle("fill", x, 200, 50, 80)
end


function test(a,b)
    return a+b
end


