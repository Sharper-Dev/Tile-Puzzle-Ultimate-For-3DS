--- The module containing the Micro2D engine settings.
--- @module settings
--- @author Sharper Dev

local Settings = {}

--- Prefix used to resolve game asset scripts through package.path.
--- Include a trailing slash in the path.
--- @usage Settings.ASSETS_PATH = "romfs:/assets/"
Settings.ASSETS_PATH = "romfs:/assets/"

--- Ordered paths to scene scripts; the scenes system loads scenes by index.
--- Paths must identify Lua scene scripts.
--- @usage Settings.SCENES[1] = "romfs:/assets/scripts/scenes/sample_scene.lua"
Settings.SCENES = {}

Settings.SCENES[1] = "romfs:/assets/scenes/menu_scene.lua"
Settings.SCENES[2] = "romfs:/assets/scenes/game_scene.lua"

_G.M2D_SETTINGS = Settings