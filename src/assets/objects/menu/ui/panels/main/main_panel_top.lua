local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")
local thisObject = GameObject:new("main_panel_top")
local Script = thisObject:addComponent("Script")

local titleObject
local titleSprite

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
    FadeAnimation.callFadeOut(0.2)
    thisObject.transform:setPosition(0, 0, 2)
    setPanelActive(true)
end

return thisObject