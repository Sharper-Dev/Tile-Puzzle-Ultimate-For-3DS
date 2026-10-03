local GameObject = require("gameobject.m2d_gameobject")

local UniversalManager = {}
local hasCreated = false

local objectsList = {
    "romfs:/assets/objects/general/ui/fade_updater.lua",
    "romfs:/assets/objects/general/ui/universal_canvas.lua",
    "romfs:/assets/objects/general/ui/universal_canvas_top.lua",
    "romfs:/assets/objects/general/ui/fade_object_top.lua",
    "romfs:/assets/objects/general/ui/fade_object_bottom.lua"
}
function UniversalManager.create()
    if hasCreated then return end

    for _, objectPath in ipairs(objectsList) do
        GameObject.instantiate(dofile(objectPath), true)
    end

    hasCreated = true
end

return UniversalManager