local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("fade_object_bottom")
local Image = thisObject:addComponent("Image")
local Script = thisObject:addComponent("Script")

function Script.start()
    local canvasObject = GameObject.findByNameUniversal("universal_canvas")
    thisObject.transform:setPosition(0, 0, 80)
    Image:setCanvas(canvasObject.canvas)
    Image:setColor(0, 0, 0, 0)
end

return thisObject