local GameObject = require("gameobject.m2d_gameobject")
local CollisionSystem = require("systems.collision.m2d_collision_system")

local thisObject = GameObject:new("credits_panel_bottom")
local Script = thisObject:addComponent("Script")
local Image = thisObject:addComponent("Image")
local backButton
local backButtonText

local function setPanelActive(active)
    backButton.enabled = active
    backButton:getComponent("BoxCollider").enabled = active
    backButtonText.enabled = active
    Image.enabled = active
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    local canvasObject = GameObject.findByName("canvas")
    Image:setCanvas(canvasObject.canvas)
    Image:setImage("romfs:/assets/sprites/panels/credits/credits_bottom.png")
    backButton = GameObject.findByName("back_button")

    backButtonText = GameObject.findByName("back_button_text")

    thisObject.transform:setPosition(160, 100, 2)
    setPanelActive(false)
end

return thisObject