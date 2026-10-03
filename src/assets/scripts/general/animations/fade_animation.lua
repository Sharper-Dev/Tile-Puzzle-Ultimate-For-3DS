local Time = require("time.m2d_time")
local MathE = require("extender.math.m2d_math")

local FadeAnimation = {}
FadeAnimation.animating = {}

function FadeAnimation.startFadeIn(image, duration, maxAlpha)
    local anim = {
        image = image,
        duration = duration,
        progress = 0,
        type = "fadeIn",
        maxAlpha = maxAlpha or 255
    }
    table.insert(FadeAnimation.animating, anim)
end

function FadeAnimation.startFadeOut(image, duration, maxAlpha)
    local anim = {
        image = image,
        duration = duration,
        progress = 0,
        type = "fadeOut",
        maxAlpha = maxAlpha or 255
    }
    table.insert(FadeAnimation.animating, anim)
end

function FadeAnimation.update()
    for i, anim in ipairs(FadeAnimation.animating) do
        anim.progress = anim.progress + Time.deltaTime / anim.duration
        if anim.progress >= 1 then
            anim.progress = 1
        end
        local target = anim.type == "fadeIn" and anim.maxAlpha or 0
        local start = anim.type == "fadeIn" and 0 or anim.maxAlpha
        anim.image:setColor(0, 0, 0, math.floor(MathE.lerp(start, target, anim.progress)))
        if anim.progress == 1 then
            table.remove(FadeAnimation.animating, i)
        end
    end
end

return FadeAnimation
