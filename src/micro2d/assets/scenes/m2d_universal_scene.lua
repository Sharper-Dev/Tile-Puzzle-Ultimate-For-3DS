--- Shared scene for GameObjects that should persist while regular scenes change.
--- The scene system loads it by default.

local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("universal_scene")

return thisScene