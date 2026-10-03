local uiButton = require("scripts.builders.ui_button_builder")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local PauseManager = require("scripts.general.managers.pause_manager")
local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")
local Time = require("time.m2d_time")

local thisObject = uiButton.buildButton("restart_button", "Restart")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local fadeObjectTop
local fadeImageTop
local fadeObjectBottom
local fadeImageBottom
local counter = 0
local clicked = false
local baseStart = thisScript.start
local baseUpdate = thisScript.update

thisObject.textOffset = { x = 40, y = 23 }
thisObject.transform:setPosition(90, 90, 3)

function thisScript.start()
    baseStart()
    fadeObjectTop = GameObject.findByNameUniversal("fade_object_top")
    fadeImageTop = fadeObjectTop:getComponent("Image")
    fadeObjectBottom = GameObject.findByNameUniversal("fade_object_bottom")
    fadeImageBottom = fadeObjectBottom:getComponent("Image")
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
			ScenesSystem.loadScene(2)
		end
	end
end

function thisButton.onClick()
    clicked = true
    FadeAnimation.startFadeIn(fadeImageTop, 0.2)
    FadeAnimation.startFadeIn(fadeImageBottom, 0.2)
end

return thisObject