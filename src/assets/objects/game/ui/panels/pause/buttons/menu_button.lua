local uiButton = require("scripts.builders.ui_button_builder")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local PauseManager = require("scripts.general.managers.pause_manager")

local thisObject = uiButton.buildButton("menu_button", "Menu")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local baseStart = thisScript.start
thisObject.textOffset = { x = 62, y = 23 }
thisObject.transform:setPosition(90, 150, 3)

function thisScript.start()
    baseStart()
end

function thisButton.onClick()
    CollisionSystem.setLayerActive(1, true)
    CollisionSystem.setLayerActive(2, true)
    PauseManager.setPause(false)
    ScenesSystem.loadScene(1)
end

return thisObject