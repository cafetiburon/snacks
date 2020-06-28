push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

-- Setup game state at the very beginning of execution 
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())
   
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
    })

    player1Score = 0
    player2Score = 0

    servingPlayer = 1

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(WINDOW_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'
end

function love.keypressed(key) 
    if key == 'escape' then
        love.event.quit()
    end
end

-- Called each frame by LOVE; dt will be elapsed time in seconds since the last frame
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
    
    end
    if love.keyboard.isDown('s') then
    
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
    
    end
    if love.keyboard.isDown('down') then
    
    end

end

-- Called each frame by LOVE after update for drawing things on screen once they've changed
function love.draw()
    push:apply('start')

    -- love.graphics.clear(40, 45, 52, 255)

    love.graphics.printf(
        'Hello Pong!',
        0,
        20,
        VIRTUAL_WIDTH,
        'center')
    
    player1:render()
    player2:render()
    ball:render()

    displayFPS()
    
    push:apply('end')
end

function love.resize(w, h)
    push:resize(w,h)
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

--[[
    Simply draws the score to the screen.
]]
function displayScore()
    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, 
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end
