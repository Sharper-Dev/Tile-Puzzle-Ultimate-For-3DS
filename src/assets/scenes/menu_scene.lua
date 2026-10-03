local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("menu_scene")

local objectsList = {
    "romfs:/assets/objects/general/creators/universal_objects_creator.lua",
    "romfs:/assets/objects/general/ui/top_background.lua",
    "romfs:/assets/objects/general/ui/bottom_background.lua",
    "romfs:/assets/objects/general/ui/top_circles.lua",
    "romfs:/assets/objects/general/ui/bottom_circles.lua",
    "romfs:/assets/objects/menu/ui/menu_canvas.lua",
    "romfs:/assets/objects/menu/ui/menu_canvas_top.lua",
    "romfs:/assets/objects/menu/ui/panels/main/buttons/play_button.lua",
    "romfs:/assets/objects/menu/ui/panels/main/buttons/quit_button.lua",
    "romfs:/assets/objects/menu/ui/panels/main/buttons/credits_button.lua",
    "romfs:/assets/objects/menu/ui/panels/main/top_title.lua",
    "romfs:/assets/objects/menu/ui/panels/main/main_panel_bottom.lua",
    "romfs:/assets/objects/menu/ui/panels/main/main_panel_top.lua",
    "romfs:/assets/objects/menu/ui/panels/credits/buttons/back_button.lua",
    "romfs:/assets/objects/menu/ui/panels/credits/credits_panel_bottom.lua",
    "romfs:/assets/objects/menu/ui/panels/credits/credits_panel_top.lua"
}

for _, object in ipairs(objectsList) do
    thisScene:addGameObject(dofile(object))
end

return thisScene