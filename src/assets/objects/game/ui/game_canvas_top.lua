local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("canvas_top")
thisObject:addComponent("Canvas"):switchScreen(TOP_SCREEN)

return thisObject