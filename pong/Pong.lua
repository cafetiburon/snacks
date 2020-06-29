Pong = Class{}

function Pong:init(ball, player1, player2, servingPlayer, gameState) 
    self.ball = ball
    self.player1 = player1
    self.player2 = player2
    self.player1Score = 0
    self.player2Score = 0
    self.gameState = gameState
    self.servingPlayer = servingPlayer
    self.winningPlayer = 0

    self.sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
end

function Pong:render()
    self.player1:render()
    self.player2:render()
    self.ball:render()
end

function Pong:update(dt)
    -- update ball position when in play state
    if self.gameState == 'play' then
        self.ball:update(dt)
    end
        
    self.player1:update(dt)
    self.player2:update(dt)
end

function Pong:updateBallPositionAndMovement()
    if self.gameState == 'serve' then
        self.ball:setServePosition(self.servingPlayer)
    elseif self.gameState == 'play' then
        if self.ball:didCollide(self.player1, self.player2) then
            self.sounds['paddle_hit']:play()
        end
        
        if self.ball:didHitWall() then
            self.sounds['wall_hit']:play()
        end

        if self.ball:getX() < 0 then
            self:score(2)
        elseif self.ball:getX() > VIRTUAL_WIDTH then
            self:score(1)
        end
    end
end

function Pong:score(player)
    if player == 1 then
        self.servingPlayer = 2
        self.player1Score = self.player1Score + 1
        self.sounds['score']:play()

        if self.player1Score == 10 then
            self.winningPlayer = 1
            self.gameState = 'done'
        else
            self.gameState = 'serve'
            self.ball:reset()
        end
    elseif player == 2 then
        self.servingPlayer = 1
        self.player2Score = self.player2Score + 1
        self.sounds['score']:play()

        if self.player2Score == 10 then
            self.winningPlayer = 2
            self.gameState = 'done'
        else
            self.gameState = 'serve'
            self.ball:reset()
        end
    end
end

function Pong:setGameStateOnKeyPress(key)
    if key == 'enter' or key == 'return' then
        if self.gameState == 'start' then
            self.gameState = 'serve'
        elseif self.gameState == 'serve' then
            self.gameState = 'play'
        elseif self.gameState == 'done' then
            -- reset game and set serving player to last winner
            self.gameState = 'serve'

            self.ball:reset()
            self.player1Score = 0
            self.player2Score = 0

            if self.winningPlayer == 1 then
                self.servingPlayer = 2
            else
                self.servingPlayer = 1
            end
        end
    end
end

function Pong:getBall()
    return self.ball
end

function Pong:getPlayer1()
    return self.player1
end

function Pong:getPlayer2()
    return self.player2
end

function Pong:getGameState()
    return self.gameState
end

function Pong:setGameState(gameState)
    self.gameState = gameState
end

function Pong:getWinningPlayer()
    return self.winningPlayer
end

function Pong:getServingPlayer()
    return self.servingPlayer
end

function Pong:getPlayer1Score()
    return self.player1Score
end

function Pong:getPlayer2Score()
    return self.player2Score
end