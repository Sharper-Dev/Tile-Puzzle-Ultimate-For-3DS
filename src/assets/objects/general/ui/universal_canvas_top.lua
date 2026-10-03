local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("universal_canvas_top")
thisObject:addComponent("Canvas"):switchScreen(TOP_SCREEN)

return thisObject