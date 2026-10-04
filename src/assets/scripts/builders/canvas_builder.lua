local GameObject = require("gameobject.m2d_gameobject")

local Builder = {}

function Builder.create(name, screen)
    local canvasObject = GameObject:new(name)
    canvasObject:addComponent("Canvas"):switchScreen(screen)
    return canvasObject
end

return Builder
