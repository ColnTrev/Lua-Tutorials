bullet = {}
bullet.width = 5
bullet.height = 5
bullet.speed = 500

function bullet.spawn(x, y, dir)
    table.insert(bullet, {x=x,y=y,dir=dir, width = bullet.width, height=bullet.height})
end

function bullet.draw()
    for i,v in ipairs(bullet) do
        love.graphics.setColor(0,0,255)
        love.graphics.rectangle('fill', v.x,v.y,bullet.width,bullet.height)
    end
end

function bullet.move(dt)
    for i,v in ipairs(bullet) do
        if v.dir == 'up' then
            v.y = v.y - bullet.speed * dt
        end
        if v.dir == 'down' then
            v.y = v.y + bullet.speed * dt
        end

        if v.dir == 'left' then
            v.x = v.x - bullet.speed * dt
        end

        if v.dir == 'right' then
            v.x = v.x + bullet.speed * dt
        end
    end
end
function DRAW_BULLET()
    bullet.draw()
end

function UPDATE_BULLET(dt)
    bullet.move(dt)
end