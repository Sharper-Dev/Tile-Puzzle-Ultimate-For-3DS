local Time = require("time.m2d_time")

local SineAnimation = {}
SineAnimation.__index = SineAnimation

function SineAnimation.new(options)
    options = options or {}

    return setmetatable({
        position = options.position,
        amplitudeX = options.amplitudeX or 0,
        amplitudeY = options.amplitudeY or 0,
        frequency = options.frequency or 1,
        phase = options.phase or 0,
        elapsed = 0,
    }, SineAnimation)
end

function SineAnimation:start(gameObject)
    local currentPosition = gameObject.transform.position
    local position = self.position or currentPosition

    self.position = {
        x = position.x,
        y = position.y,
        z = position.z or currentPosition.z,
    }
    self.elapsed = 0
    gameObject.transform:setPosition(self.position.x, self.position.y, self.position.z)
end

function SineAnimation:update(gameObject)
    self.elapsed = self.elapsed + Time.deltaTime

    local angle = self.frequency * self.elapsed + self.phase
    local x = self.position.x + self.amplitudeX * math.sin(angle)
    local y = self.position.y + self.amplitudeY * math.sin(angle)

    gameObject.transform:setPosition(x, y)
end

return SineAnimation
