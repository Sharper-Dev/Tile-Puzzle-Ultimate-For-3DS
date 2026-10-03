local uiButton = require("scripts.builders.ui_button_builder")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local PauseManager = require("scripts.general.managers.pause_manager")
local FadeAnimation = require("scripts.general.animations.fade_animation")
local Time = require("time.m2d_time")

local thisObject = uiButton.buildButton("menu_button_gameover", "Menu")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local counter = 0
local clicked = false
local baseStart = thisScript.start
local baseUpdate = thisScript.update
thisObject.textOffset = { x = 62, y = 23 }
thisObject.transform:setPosition(90, 120, 3)

function thisScript.start()
    baseStart()
end

function thisScript.update()
    baseUpdate()
    if clicked then
		counter = counter + Time.deltaTime
		if counter >= 0.3 then
            clicked = false
            CollisionSystem.setLayerActive(1, true)
            CollisionSystem.setLayerActive(2, true)
            CollisionSystem.setLayerActive(3, false)
            CollisionSystem.setLayerActive(4, false)
            PauseManager.setPause(false)
			ScenesSystem.loadScene(1)
		end
	end
end

function thisButton.onClick()
    if clicked then return end
    clicked = true
    FadeAnimation.callFadeIn(0.2)
end

return thisObject