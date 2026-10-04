--- Loads and caches bitmap fonts for the Micro2D engine.
--- Each font consists of a Lua data file and a PNG image sheet.
--
--- You can use my own tool called [BMFont2Lua](https://github.com/Sharper-Dev/BMFont2Lua) to convert your own BMFonts JSON files to Lua table.
--- @module bank_fonts
--- @author Sharper Dev
--- 
local FontsBank = {}
local loadedFonts = {}

--- Loads a font from the given path and associates it with the given ID.
--
--- The font is stored in memory and can be retrieved using `FontsBank.getFont(id)`.
--- @param id string The ID to associate the font with.
--- @param fontPath string The path to the font files. The font name should be the last part of the path, and the files should be named `<fontName>.lua` and `<fontName>.png`.
--- @return table The loaded font data.
--- @usage local myFont = FontsBank.loadFont("myFont", "romfs/micro2d/fonts/myFont")
function FontsBank.loadFont(id, fontPath)
    if loadedFonts[id] then
        return loadedFonts[id]
    end

    local fontName = fontPath:match("[^/]+$")
    loadedFonts[id] = {
        data = dofile(fontPath .. "/" .. fontName .. ".lua"),
        sheet = Graphics.loadImage(fontPath .. "/" .. fontName .. ".png")
    }

    return loadedFonts[id]
end

--- Frees the image sheet and removes the font associated with the ID.
--- @param id string ID of the font to unload.
--- @usage FontsBank.unloadFont("myFont")
function FontsBank.unloadFont(id)
    Graphics.freeImage(loadedFonts[id].sheet)
    loadedFonts[id] = nil
end

--- Returns the cached font entry for the ID, or `nil` if it is not loaded.
--- @param id string ID of the font to retrieve.
--- @return table|nil Font entry containing `data` and `sheet`.
--- @usage local myFont = FontsBank.getFont("myFont")
function FontsBank.getFont(id)
    return loadedFonts[id]
end

return FontsBank