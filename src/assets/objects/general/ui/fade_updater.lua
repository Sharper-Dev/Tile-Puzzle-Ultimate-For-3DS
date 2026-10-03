local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")

local thisObject = GameObject:new("fade_updater")

local Script = thisObject:addComponent("Script")

function Script.update()
    FadeAnimation.update()
end

return thisObject