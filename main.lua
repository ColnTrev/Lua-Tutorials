require 'player'
require 'bullet'
require 'enemy'
function love.load()
    love.graphics.setBackgroundColor(255,255,255)
    player.load()
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
end

function love.keypressed(key)
    player.shoot(key)
end

function love.update(dt)
    UPDATE_PLAYER(dt)
    UPDATE_BULLET(dt)
    UPDATE_ENEMY(dt)
end

function love.draw()
    DRAW_PLAYER()
    DRAW_BULLET()
    DRAW_ENEMY()
end