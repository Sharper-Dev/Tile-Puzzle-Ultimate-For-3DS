local GameObject = require("gameobject.m2d_gameobject")
local Script = require("scripts.menu.ui.top_title_script")

local thisObject = GameObject:new("top_title")
local scriptComponent = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

scriptComponent.start = function()
    Script.start(thisObject)
end

scriptComponent.update = function()
    Script.update(thisObject)
end

return thisObject