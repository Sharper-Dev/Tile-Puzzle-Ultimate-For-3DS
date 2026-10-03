local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")
local Time = require("time.m2d_time")
local thisObject = GameObject:new("main_panel_top")
local Script = thisObject:addComponent("Script")

local titleObject
local titleSprite
local fadeObjectTop
local fadeImageTop

local fadeObjectBottom
local fadeImageBottom
local function setPanelActive(active)
    titleObject.enabled = active
    titleSprite.enabled = active
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    titleObject = GameObject.findByName("top_title")
    titleSprite = titleObject:getComponent("Sprite")
    fadeObjectTop = GameObject.findByNameUniversal("fade_object_top")
    fadeImageTop = fadeObjectTop:getComponent("Image")

    fadeObjectBottom = GameObject.findByNameUniversal("fade_object_bottom")
    fadeImageBottom = fadeObjectBottom:getComponent("Image")
    fadeImageTop:setColor(0, 0, 0, 0)
    fadeImageBottom:setColor(0, 0, 0, 0)
    FadeAnimation.startFadeOut(fadeImageTop, 0.2)
    FadeAnimation.startFadeOut(fadeImageBottom, 0.2)
    thisObject.transform:setPosition(0, 0, 2)
    setPanelActive(true)
end

return thisObject