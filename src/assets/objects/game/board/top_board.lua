local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("top_board")

local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

function Script.start()
    thisObject.transform:setPosition(200, 94, 3)
    thisObject.transform:setScale(0.6, 0.6)
    Sprite:setSprite("romfs:/assets/sprites/pieces/numbers/numbers.png")
    Sprite:setScreen(TOP_SCREEN)
end

return thisObject