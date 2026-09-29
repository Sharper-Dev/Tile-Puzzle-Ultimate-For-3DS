local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("panel_background_bottom")
local Image = thisObject:addComponent("Image")
local Script = thisObject:addComponent("Script")

function Script.start()
    thisObject.transform:setPosition(0, 0, 2)
    local canvas = GameObject.findByName("canvas")
    Image:setColor(0, 0, 0, 150)
    Image:setCanvas(canvas.canvas)
end

return thisObject