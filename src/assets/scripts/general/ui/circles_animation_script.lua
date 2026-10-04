local Time = require("time.m2d_time")
local MathE = require("extender.math.m2d_math")

local Script = {}

function Script.create(screen)
    local counter = 0
    local startPos = { x = 216, y = 137 }
    local finalPos = { x = 190, y = 86 }
    local speed = 0.5

    local animation = {}

    function animation.start(gameObject)
        gameObject.transform:setPosition(startPos.x, startPos.y, 1)

        local sprite = gameObject:getComponent("Sprite")
        sprite:setSprite("romfs:/assets/sprites/background/circles.png")
        sprite:setScreen(screen)
        sprite:setColor(254, 245, 213)
    end

    function animation.update(gameObject)
        counter = counter + Time.deltaTime * speed

        local progress = math.min(counter, 1.0)
        local x = MathE.lerp(startPos.x, finalPos.x, progress)
        local y = MathE.lerp(startPos.y, finalPos.y, progress)

        gameObject.transform:setPosition(x, y)
        if counter >= 1.0 then
            counter = 0
        end
    end

    return animation
end

return Script
