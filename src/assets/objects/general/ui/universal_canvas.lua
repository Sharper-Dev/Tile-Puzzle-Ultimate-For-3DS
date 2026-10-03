local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("universal_canvas")
thisObject:addComponent("Canvas"):switchScreen(BOTTOM_SCREEN)

return thisObject