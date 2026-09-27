local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("menu_scene")

thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/top_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/bottom_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/top_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/bottom_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/menu/ui/menu_canvas.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/menu/ui/play_button.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/menu/ui/quit_button.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/menu/ui/top_title.lua"))

return thisScene