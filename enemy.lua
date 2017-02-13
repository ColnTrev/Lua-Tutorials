enemy = {}

enemy.timer = 0
enemy.timerLim = math.random(3,5)
enemy.amount = math.random(1,3)
enemy.side = math.random(1,4)

enemy.width = 50
enemy.height = 50
enemy.speed = 1000
enemy.friction = 7.5

function enemy.spawn(x,y)
    table.insert(enemy, {x = x, y = y, x_velocity = 0, y_velocity = 0, health = 2,width = enemy.width, height=enemy.height})
end

function enemy.draw()
    for i,v in ipairs(enemy) do
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle('fill', v.x,v.y,enemy.width, enemy.height)
    end
end

function enemy.generate(dt)
    enemy.timer = enemy.timer + dt
    if enemy.timer > enemy.timerLim then
        -- Spawn enemy
        for i=1,enemy.amount do
            if enemy.side == 1 then -- Left
                enemy.spawn(-50,screenHeight/2 - 25)
            end
            if enemy.side == 2 then --top
                enemy.spawn(screenWidth / 2 - 25, -50)
            end
            if enemy.side == 3 then --right
                enemy.spawn(screenWidth, screenHeight / 2 - 25)
            end
            if enemy.side == 4 then --bottom
                enemy.spawn(screenWidth / 2 - 25, screenHeight)
            end
            enemy.side = math.random(1,4)
        end
        enemy.amount = math.random(1,3)
        enemy.timerLim = math.random(3,5)
        enemy.timer = 0
    end
end

function enemy.physics(dt)
    for i,v in ipairs(enemy) do
        v.x = v.x + v.x_velocity * dt
        v.y = v.y + v.y_velocity * dt
        v.x_velocity = v.x_velocity * (1 - math.min(dt*enemy.friction, 1))
        v.y_velocity = v.y_velocity * (1 - math.min(dt*enemy.friction, 1))
    end
end

function enemy.AI(dt)
    for i,v in ipairs(enemy) do
        -- X axis
        if player.x + player.width / 2 < v.x + v.width / 2 then
            if v.x_velocity > -enemy.speed then
                v.x_velocity = v.x_velocity - enemy.speed * dt
            end
        end

        if player.x + player.width / 2 > v.x + v.width / 2 then
            if v.x_velocity < enemy.speed then
                v.x_velocity = v.x_velocity + enemy.speed * dt
            end
        end

        -- Y axis
        if player.y + player.height / 2 < v.y + v.height / 2 then
            if v.y_velocity > -enemy.speed then
                v.y_velocity = v.y_velocity - enemy.speed * dt
            end
        end

        if player.y + player.height / 2 > v.y + v.height / 2 then
            if v.y_velocity < enemy.speed then
                v.y_velocity = v.y_velocity + enemy.speed * dt
            end
        end
    end
end

function enemy.bullet_collide()
    for i,v in ipairs(enemy) do
        for ia,va in ipairs(bullet) do
            if va.x + va.width > v.x and
            va.x < v.x + v.width and
            va.y + va.height > v.y and
            va.y < v.y + v.height then
                table.remove(enemy, i)
                table.remove(bullet, ia)
            end
        end
    end
end


function DRAW_ENEMY()
    enemy.draw()
end

function UPDATE_ENEMY(dt)
    enemy.physics(dt)
    enemy.AI(dt)
    enemy.generate(dt)
    enemy.bullet_collide()
end