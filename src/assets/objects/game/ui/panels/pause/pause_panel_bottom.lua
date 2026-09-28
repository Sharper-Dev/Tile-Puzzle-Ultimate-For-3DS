local GameObject = require("gameobject.m2d_gameobject")
local PauseManager = require("scripts.general.managers.pause_manager")
local InputSystem = require("systems.input.m2d_input_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")

local thisObject = GameObject:new("pause_panel_bottom")
local Script = thisObject:addComponent("Script")
local Image = thisObject:addComponent("Image")

local pauseButton
local returnButton
local returnButtonText
local restartButton
local restartButtonText
local menuButton
local menuButtonText

local function setPanelActive(active)
    Image.enabled = active
    returnButton.enabled = active
    returnButtonText.enabled = active
    restartButton.enabled = active
    restartButtonText.enabled = active
    menuButton.enabled = active
    menuButtonText.enabled = active
    CollisionSystem.setLayerActive(1, not active)
    CollisionSystem.setLayerActive(2, not active)
    CollisionSystem.setLayerActive(3, active)
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    PauseManager.pausePanelBottom = thisObject

    pauseButton = GameObject.findByName("pause_button")
    pauseButton:getComponent("Button").collider:setLayer(2)

    returnButton = GameObject.findByName("return_button")
    returnButton:getComponent("Button").collider:setLayer(3)

    returnButtonText = GameObject.findByName("return_button_text")

    menuButton = GameObject.findByName("menu_button")
    menuButton:getComponent("Button").collider:setLayer(3)

    menuButtonText = GameObject.findByName("menu_button_text")

    restartButton = GameObject.findByName("restart_button")
    restartButton:getComponent("Button").collider:setLayer(3)

    restartButtonText = GameObject.findByName("restart_button_text")

    thisObject.transform:setPosition(0, 0, 2)
    local canvas = GameObject.findByName("canvas")
    Image:setColor(0, 0, 0, 150)
    Image:setCanvas(canvas.canvas)
    setPanelActive(false)
end

return thisObject