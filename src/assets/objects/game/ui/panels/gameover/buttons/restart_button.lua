local uiButton = require("scripts.builders.ui_button_builder")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local PauseManager = require("scripts.general.managers.pause_manager")

local thisObject = uiButton.buildButton("restart_button_gameover", "Restart")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local baseStart = thisScript.start
thisObject.textOffset = { x = 40, y = 23 }
thisObject.transform:setPosition(90, 60, 3)

function thisScript.start()
    baseStart()
end

function thisButton.onClick()
    CollisionSystem.setLayerActive(1, true)
    CollisionSystem.setLayerActive(2, true)
    CollisionSystem.setLayerActive(3, false)
    CollisionSystem.setLayerActive(4, false)
    PauseManager.setPause(false)
    ScenesSystem.loadScene(2)
end

return thisObject