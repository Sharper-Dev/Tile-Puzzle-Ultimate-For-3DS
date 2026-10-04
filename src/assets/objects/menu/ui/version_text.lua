local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("version_text")
local textComponent = thisObject:addComponent("Text")
local Script = thisObject:addComponent("Script")

function Script.start()
    thisObject.transform:setPosition(283, 231)
    thisObject.transform:setScale(0.25, 0.25)
    textComponent:setCanvas(GameObject.findByName("canvas").canvas)
    textComponent:setFont("LTStudent")
    textComponent:setContent("v0.1.0")
end

return thisObject