push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Ball'
require 'Pong'

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

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
    pong = Pong(ball, player1, player2, 1, 'start')
    
end

function love.keypressed(key) 
    if key == 'escape' then
        love.event.quit()
    else
        pong:setGameStateOnKeyPress(key) 
    end
end

-- Called each frame by LOVE; dt will be elapsed time in seconds since the last frame
-- Handle game states and object positioning
function love.update(dt)
    pong:updateBallPositionAndMovement()
   
    -- player 1 movement
    if love.keyboard.isDown('w') then
        pong:getPlayer1():setDy(-PADDLE_SPEED)
    elseif love.keyboard.isDown('s') then
        pong:getPlayer1():setDy(PADDLE_SPEED)
    else
        pong:getPlayer1():setDy(0)
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        pong:getPlayer2():setDy(-PADDLE_SPEED)
    elseif love.keyboard.isDown('down') then
        pong:getPlayer2():setDy(PADDLE_SPEED)
    else
        pong:getPlayer2():setDy(0)
    end

    pong:update(dt)
    
end

-- Called each frame by LOVE after update for drawing things on screen once they've changed
function love.draw()
    push:apply('start')

    -- love.graphics.clear(40, 45, 52, 255)

    love.graphics.setFont(smallFont)

    displayScore()

    displayMessages()

    pong:render()

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
    love.graphics.print(tostring(pong:getPlayer1Score()), VIRTUAL_WIDTH / 2 - 50, 
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(pong:getPlayer2Score()), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end

function displayMessages()
    if pong:getGameState() == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif pong:getGameState() == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(pong:getServingPlayer()) .. "'s serve!", 
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif pong:getGameState() == 'play' then
        -- no UI messages to display in play
    elseif pong:getGameState() == 'done' then
        -- UI messages
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(pong:getWinningPlayer()) .. ' wins!',
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end
end