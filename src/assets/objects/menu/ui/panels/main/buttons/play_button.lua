local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local uiButton = require("scripts.builders.ui_button_builder")
local FadeAnimation = require("scripts.general.animations.fade_animation")

local Time = require("time.m2d_time")

local thisObject = uiButton.buildButton("play_button", "Play")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local counter = 0
local clicked = false
local baseStart = thisScript.start
local baseUpdate = thisScript.update
thisObject.textOffset = { x = 62, y = 23 }

function thisScript.start()
    baseStart()

    thisObject.transform:setPosition(90, 30, 1)
end

function thisScript.update()
	baseUpdate()
	if clicked then
		counter = counter + Time.deltaTime
		if counter >= 0.2 then
            clicked = false
			ScenesSystem.loadScene(2)
		end
	end
end

function thisButton.onClick()
    if clicked then return end
	clicked = true
	counter = 0
    FadeAnimation.callFadeIn(0.2)
	thisButton.collider.enabled = false
end

return thisObject