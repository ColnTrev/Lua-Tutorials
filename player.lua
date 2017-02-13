player = {}

function player.load()
    player.x = 5
    player.y = 5
    player.width = 50
    player.height = 50
    player.x_velocity = 0
    player.y_velocity = 0
    player.friction = 7
    player.speed = 1200
end

function player.draw()
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
end

function player.physics(dt)
    player.x = player.x + player.x_velocity * dt
    player.y = player.y + player.y_velocity * dt
    player.x_velocity = player.x_velocity * (1 - math.min(dt*player.friction, 1))
    player.y_velocity = player.y_velocity * (1 - math.min(dt*player.friction, 1))
end

function player.move(dt)
    if love.keyboard.isDown('d') and
        player.x_velocity < player.speed then
        player.x_velocity = player.x_velocity + player.speed * dt
    end

    if love.keyboard.isDown('a') and
        player.x_velocity > -player.speed then
        player.x_velocity = player.x_velocity - player.speed * dt
    end

    if love.keyboard.isDown('w') and
        player.y_velocity > -player.speed then
        player.y_velocity = player.y_velocity - player.speed * dt
    end

    if love.keyboard.isDown('s') and
        player.y_velocity < player.speed then
        player.y_velocity = player.y_velocity + player.speed * dt
    end
end

function player.shoot(key)
    if key == 'up' then
        bullet.spawn(player.x + player.width / 2 - bullet.width / 2, player.y - bullet.height, key)
    end

    if key == 'down' then
        bullet.spawn(player.x + player.width / 2 - bullet.width / 2, player.y + player.height, key)
    end

    if key == 'left' then
        bullet.spawn(player.x - bullet.width / 2, player.y + player.height / 2 - bullet.height / 2, key)
    end
    if key == 'right' then
        bullet.spawn(player.x + player.width, player.y + player.height / 2 - bullet.height / 2, key)
    end
end
function player.boundary()
    if player.x < 0 then
        player.x = 0
        player.x_velocity = 0
    end
    if player.y < 0 then
        player.y = 0
        player.y_velocity = 0
    end
    if player.x + player.width > screenWidth then
        player.x = screenWidth - player.width
        player.x_velocity = 0
    end
    if player.y + player.height > screenHeight then
        player.y = screenHeight - player.height
        player.y_velocity = 0
    end
end

function UPDATE_PLAYER(dt)
    player.physics(dt)
    player.move(dt)
    player.boundary()
end

function DRAW_PLAYER()
    player.draw()
end
