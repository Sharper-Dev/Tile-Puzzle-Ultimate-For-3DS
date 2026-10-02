local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("credits_panel_top")
local Script = thisObject:addComponent("Script")
local Image = thisObject:addComponent("Image")

local function setPanelActive(active)
    Image.enabled = active
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    local canvasObject = GameObject.findByName("canvas_top")
    Image:setCanvas(canvasObject.canvas)
    Image:setImage("romfs:/assets/sprites/panels/credits/credits_top.png")

    thisObject.transform:setPosition(203, 121, 2)
    setPanelActive(false)
end

return thisObject