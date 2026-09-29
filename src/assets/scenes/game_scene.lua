local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("game_scene")

local objectsList = {
    "romfs:/assets/objects/general/ui/top_background.lua",
    "romfs:/assets/objects/general/ui/bottom_background.lua",
    "romfs:/assets/objects/general/ui/top_circles.lua",
    "romfs:/assets/objects/general/ui/bottom_circles.lua",
    "romfs:/assets/objects/game/board/board_object.lua",
    "romfs:/assets/objects/game/ui/game_canvas.lua",
    "romfs:/assets/objects/game/ui/game_canvas_top.lua",
    "romfs:/assets/objects/game/ui/panels/quit/quit_panel.lua",
    "romfs:/assets/objects/game/ui/pause_button.lua",
    "romfs:/assets/objects/game/ui/panels/pause/buttons/return_button.lua",
    "romfs:/assets/objects/game/ui/panels/pause/buttons/restart_button.lua",
    "romfs:/assets/objects/game/ui/panels/pause/buttons/menu_button.lua",
    "romfs:/assets/objects/game/ui/panels/gameover/buttons/restart_button.lua",
    "romfs:/assets/objects/game/ui/panels/gameover/buttons/menu_button.lua",
    "romfs:/assets/objects/game/ui/panels/gameover/gameover_panel_top.lua",
    "romfs:/assets/objects/game/ui/panels/gameover/gameover_panel_bottom.lua",
    "romfs:/assets/objects/game/ui/panels/pause/pause_panel_bottom.lua",
    "romfs:/assets/objects/game/ui/panels/pause/pause_panel_top.lua",
    "romfs:/assets/objects/game/ui/panels/panel_background_top.lua",
    "romfs:/assets/objects/game/ui/panels/panel_background_bottom.lua"
}

for _, object in ipairs(objectsList) do
    thisScene:addGameObject(dofile(object))
end

return thisScene