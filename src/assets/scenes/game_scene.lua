local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("game_scene")

local objectsList = {
    dofile("romfs:/assets/objects/general/ui/top_background.lua"),
    dofile("romfs:/assets/objects/general/ui/bottom_background.lua"),
    dofile("romfs:/assets/objects/general/ui/top_circles.lua"),
    dofile("romfs:/assets/objects/general/ui/bottom_circles.lua"),
    dofile("romfs:/assets/objects/game/board/board_object.lua"),
    dofile("romfs:/assets/objects/game/ui/game_canvas.lua"),
    dofile("romfs:/assets/objects/game/ui/game_canvas_top.lua"),
    dofile("romfs:/assets/objects/game/ui/panels/quit/quit_panel.lua"),
    dofile("romfs:/assets/objects/game/ui/pause_button.lua"),
    dofile("romfs:/assets/objects/game/ui/panels/pause/buttons/return_button.lua"),
    dofile("romfs:/assets/objects/game/ui/panels/pause/buttons/restart_button.lua"),
    dofile("romfs:/assets/objects/game/ui/panels/pause/buttons/menu_button.lua"),
    dofile("romfs:/assets/objects/game/ui/panels/pause/pause_panel_bottom.lua"),
    dofile("romfs:/assets/objects/game/ui/panels/pause/pause_panel_top.lua"),
}

for _, object in ipairs(objectsList) do
    thisScene:addGameObject(object)
end

return thisScene