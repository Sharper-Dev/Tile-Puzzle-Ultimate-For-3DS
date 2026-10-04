--- Opens, tracks, and closes sound resources by file path.
--- @module bank_sounds
--- @author Sharper Dev
local Debugger = require("debugger.m2d_debugger")
local SoundsBank = {}

local loadedSounds = {}
--- Opens a WAV or OGG file unless its path is already loaded.
--- This function does not return the sound handle; use `getLoadedSounds` to access the entry.
--- @param format string File format: `"wav"` or `"ogg"`.
--- @param useStreaming boolean Whether to open the sound in streaming mode.
--- @param path string Path to the sound file; also used as its cache key.
--- @usage SoundsBank.loadSound("wav", false, "romfs:/sounds/effect.wav")
function SoundsBank.loadSound(format, useStreaming, path)
    if loadedSounds[path] then
        return
    end
    local finalWavId
    if format == "wav" then
        finalWavId = Sound.openWav(path, useStreaming)
    elseif format == "ogg" then
        finalWavId = Sound.openOgg(path, useStreaming)
    end
    loadedSounds[path] = {
        format = format,
        wav_id = finalWavId,
        path = path,
    }
end
--- Returns the table of loaded sound entries, keyed by file path.
--- @return table Loaded sounds; each entry contains `format`, `wav_id`, and `path`.
--- @usage local sounds = SoundsBank.getLoadedSounds()
function SoundsBank.getLoadedSounds()
	return loadedSounds
end
--- Closes every loaded sound and clears the cache.
--- @usage SoundsBank.cleanup()
function SoundsBank.cleanup()
    Debugger.msg("Cleaning up sounds")
    for key, _ in pairs(loadedSounds) do
        SoundsBank.unloadSound(loadedSounds[key].path)
    end
	loadedSounds = {}
end
--- Pauses a playing sound, closes it, and removes it from the cache.
--- Does nothing if the path is not loaded.
--- @param path string Path used to load the sound.
--- @usage SoundsBank.unloadSound("sounds/background.wav")
function SoundsBank.unloadSound(path)
    if loadedSounds[path] ~= nil then
        Debugger.msg("Unloading sound: " .. path)
        if Sound.isPlaying(loadedSounds[path].wav_id) then
            Sound.pause(loadedSounds[path].wav_id)
        end
        Sound.close(loadedSounds[path].wav_id)
        loadedSounds[path] = nil
    end
end

return SoundsBank