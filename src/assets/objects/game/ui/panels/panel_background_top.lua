local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")

local thisObject = GameObject:new("panel_background_top")
local Image = thisObject:addComponent("Image")
local Script = thisObject:addComponent("Script")

function Script.start()
    thisObject.transform:setPosition(0, 0, 2)
    local canvas = GameObject.findByName("canvas_top")
    Image:setColor(0, 0, 0, 0)
    Image:setCanvas(canvas.canvas)

    FadeAnimation.callFadeOut(0.2)
end

return thisObject