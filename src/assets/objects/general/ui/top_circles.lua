local GameObject = require("gameobject.m2d_gameobject")
local CirclesAnimation = require("scripts.general.ui.circles_animation_script").create(TOP_SCREEN)

local thisObject = GameObject:new("top_circles")
local scriptComponent = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

scriptComponent.start = function()
    CirclesAnimation.start(thisObject)
end

scriptComponent.update = function()
    CirclesAnimation.update(thisObject)
end

return thisObject
