local GameObject = require("gameobject.m2d_gameobject")
local PauseManager = require("scripts.general.managers.pause_manager")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local InputSystem = require("systems.input.m2d_input_system")

local thisObject = GameObject:new("gameover_panel_bottom")
local Script = thisObject:addComponent("Script")
local panelBg

local restartButton
local restartButtonText
local menuButton
local menuButtonText

local function setPanelActive(active)
    panelBg.enabled = active
    restartButton.enabled = active
    restartButtonText.enabled = active
    menuButton.enabled = active
    menuButtonText.enabled = active
    PauseManager.setCanPause(not active)
    CollisionSystem.setLayerActive(1, not active)
    CollisionSystem.setLayerActive(2, not active)
    CollisionSystem.setLayerActive(3, not active)
    CollisionSystem.setLayerActive(4, active)
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    panelBg = GameObject.findByName("panel_background_bottom")

    menuButton = GameObject.findByName("menu_button_gameover")
    menuButton:getComponent("Button").collider:setLayer(4)

    menuButtonText = GameObject.findByName("menu_button_gameover_text")

    restartButton = GameObject.findByName("restart_button_gameover")
    restartButton:getComponent("Button").collider:setLayer(4)

    restartButtonText = GameObject.findByName("restart_button_gameover_text")

    thisObject.transform:setPosition(0, 0, 2)
    setPanelActive(false)
end

return thisObject