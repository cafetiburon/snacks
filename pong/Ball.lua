Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = math.random(2) == 1 and 100 or -100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end

function Ball:wallHit()
     -- detect upper and lower screen boundary collision
    if self.y <= 0 then
        return true
    end

    -- -4 to account for the ball's size
    if self.y >= VIRTUAL_HEIGHT - 4 then
        return true
    end

    return false
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(-50, 50)
    self.dy = math.random(2) == 1 and -100 or 100
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:getDx()
    return self.dx
end

function Ball:getDy()
    return self.dy
end

function Ball:getX()
    return self.x
end

function Ball:getY()
    return self.y
end

function Ball:setDx(dx)
    self.dx = dx
end

function Ball:setDy(dy)
    self.dy = dy
end

function Ball:setX(x)
    self.x = x
end

function Ball:setY(y)
    self.y = y
end

function Ball:setServePosition(servingPlayer)
    self.dy = math.random(-50, 50)
    if servingPlayer == 1 then
        self.dx = math.random(140, 200)
    else
        self.dx = -math.random(140, 200)
    end
end

function Ball:didCollide(player1, player2) 
    collision = false

    if self:collides(player1) then
        collision = true
        -- reverse direction
        self.dx = -self.dx * 1.03
        self.x = player1:getX() + 5

        -- randomize velocity in same direction
        if self.dy < 0 then
            self.dy = -math.random(10, 150)
        else
            self.dy = math.random(10, 150)
        end
    elseif self:collides(player2) then
        collision = true
        -- reverse direction
        self.dx = -self.dx * 1.03
        self.x = player2:getX() - 4

        -- randomize velocity in same direction
        if self.dy < 0 then
            self.dy = -math.random(10, 150)
        else
            self.dy = math.random(10, 150)
        end        
    end

    return collision
end

function Ball:didHitWall() 
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy

        return true

    elseif self.y >= VIRTUAL_HEIGHT - 4 then
        self.y = VIRTUAL_HEIGHT - 4
        self.dy = -self.dy

        return true

    end

    return false
end
