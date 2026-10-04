--- Loads the Micro2D runtime and starts the application.
--- This module has no public functions.
--- @module core_loader
--- @author Sharper Dev
--- @see core_runtime
package.path = package.path .. ";romfs:/micro2d/?.lua"

require("m2d_settings")
package.path = package.path .. ";" .. M2D_SETTINGS.ASSETS_PATH .. "?.lua"

require("banks.fonts.m2d_fonts_bank").loadFont("default", "romfs:/micro2d/assets/fonts/dogica_8px")
local m2d_runtime = require("core.m2d_core_runtime")

m2d_runtime._start()

while true do
    m2d_runtime._loop()
end