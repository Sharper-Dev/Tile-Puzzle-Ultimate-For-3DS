local GameObject = require("gameobject.m2d_gameobject")
local CollisionSystem = require("systems.collision.m2d_collision_system")

local thisObject = GameObject:new("main_panel_bottom")
local Script = thisObject:addComponent("Script")

local playButton
local playButtonText
local creditsButton
local creditsButtonText
local quitButton
local quitButtonText

local function setPanelActive(active)
    playButton.enabled = active
    playButton:getComponent("BoxCollider").enabled = active
    playButtonText.enabled = active
    creditsButton.enabled = active
    creditsButton:getComponent("BoxCollider").enabled = active
    creditsButtonText.enabled = active
    quitButton.enabled = active
    quitButton:getComponent("BoxCollider").enabled = active
    quitButtonText.enabled = active
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    creditsButton = GameObject.findByName("credits_button")
    --creditsButton:getComponent("Button").collider:setLayer(1)

    creditsButtonText = GameObject.findByName("credits_button_text")

    playButton = GameObject.findByName("play_button")
    --playButton:getComponent("Button").collider:setLayer(1)

    playButtonText = GameObject.findByName("play_button_text")

    quitButton = GameObject.findByName("quit_button")
    --quitButton:getComponent("Button").collider:setLayer(1)

    quitButtonText = GameObject.findByName("quit_button_text")

    thisObject.transform:setPosition(0, 0, 2)
    setPanelActive(true)
end

return thisObject