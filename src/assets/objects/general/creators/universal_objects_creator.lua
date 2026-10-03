local GameObject = require("gameobject.m2d_gameobject")
local UniversalManager = require("scripts.general.managers.universal_manager")

local thisObject = GameObject:new("universal_objects_creator")
local Script = thisObject:addComponent("Script")

function Script.start()
    UniversalManager.create()
end

return thisObject