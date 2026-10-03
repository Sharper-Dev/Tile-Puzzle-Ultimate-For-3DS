local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")

local thisObject = GameObject:new("panel_background_top")
local Image = thisObject:addComponent("Image")
local Script = thisObject:addComponent("Script")

local fadeObjectTop
local fadeImageTop

local fadeObjectBottom
local fadeImageBottom

function Script.start()
    thisObject.transform:setPosition(0, 0, 2)
    local canvas = GameObject.findByName("canvas_top")
    Image:setColor(0, 0, 0, 0)
    Image:setCanvas(canvas.canvas)

    fadeObjectTop = GameObject.findByNameUniversal("fade_object_top")
    fadeImageTop = fadeObjectTop:getComponent("Image")

    fadeObjectBottom = GameObject.findByNameUniversal("fade_object_bottom")
    fadeImageBottom = fadeObjectBottom:getComponent("Image")
    fadeImageTop:setColor(0, 0, 0, 0)
    fadeImageBottom:setColor(0, 0, 0, 0)
    FadeAnimation.startFadeOut(fadeImageTop, 0.2)
    FadeAnimation.startFadeOut(fadeImageBottom, 0.2)
end

return thisObject