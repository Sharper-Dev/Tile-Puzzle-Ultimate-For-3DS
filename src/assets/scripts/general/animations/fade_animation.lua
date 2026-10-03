local Time = require("time.m2d_time")
local MathE = require("extender.math.m2d_math")
local GameObject = require("gameobject.m2d_gameobject")

local FadeAnimation = {}
FadeAnimation.animating = {}
local globalFadeImages

local function getGlobalFadeImages()
    if globalFadeImages then
        return globalFadeImages
    end

    local topFade = GameObject.findByNameUniversal("fade_object_top")
    local bottomFade = GameObject.findByNameUniversal("fade_object_bottom")
    globalFadeImages = {
        topFade:getComponent("Image"),
        bottomFade:getComponent("Image")
    }
    return globalFadeImages
end

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

local function startGlobalFade(startFunction, duration, maxAlpha)
    for _, image in ipairs(getGlobalFadeImages()) do
        startFunction(image, duration, maxAlpha)
    end
end

function FadeAnimation.callFadeIn(duration, maxAlpha)
    startGlobalFade(FadeAnimation.startFadeIn, duration, maxAlpha)
end

function FadeAnimation.callFadeOut(duration, maxAlpha)
    startGlobalFade(FadeAnimation.startFadeOut, duration, maxAlpha)
end

function FadeAnimation.update()
    for i = #FadeAnimation.animating, 1, -1 do
        local anim = FadeAnimation.animating[i]
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
