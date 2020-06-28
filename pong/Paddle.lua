Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.height = height
    self.width = width
    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

-- To be called in love.draw()
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:getDx()
    return self.dx
end

function Paddle:getDy()
    return self.dy
end

function Paddle:getX()
    return self.x
end

function Paddle:getY()
    return self.y
end

function Paddle:setDx(dx)
    self.dx = dx
end

function Paddle:setDy(dy)
    self.dy = dy
end

function Paddle:setX(x)
    self.x = x
end

function Paddle:setY(y)
    self.y = y
end
