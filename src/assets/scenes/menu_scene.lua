local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("menu_scene")

local objectsList = {
    dofile("romfs:/assets/objects/general/ui/top_background.lua"),
    dofile("romfs:/assets/objects/general/ui/bottom_background.lua"),
    dofile("romfs:/assets/objects/general/ui/top_circles.lua"),
    dofile("romfs:/assets/objects/general/ui/bottom_circles.lua"),
    dofile("romfs:/assets/objects/menu/ui/menu_canvas.lua"),
    dofile("romfs:/assets/objects/menu/ui/play_button.lua"),
    dofile("romfs:/assets/objects/menu/ui/quit_button.lua"),
    dofile("romfs:/assets/objects/menu/ui/top_title.lua"),
}

for _, object in ipairs(objectsList) do
    thisScene:addGameObject(object)
end

return thisScene