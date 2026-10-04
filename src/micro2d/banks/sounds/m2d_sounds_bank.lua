--- Manages sounds for the Micro2D engine.
--
--- The SoundsBank stores loaded sounds and provides methods to load and unload them. Preventing duplicate loading of the same sound.
--- @module bank_sounds
--- @author Sharper Dev
local Debugger = require("debugger.m2d_debugger")
local SoundsBank = {}

local loadedSounds = {}
--- Loads a sound file into memory.
--- @param format string The format of the sound file ("wav" or "ogg").
--- @param useStreaming boolean Whether to use streaming mode.
--- @param path string The path to the sound file.
--- @usage SoundsBank.loadSound("wav", false, "sounds/background.wav")
--- @return sound The loaded sound.
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
--- Returns the list of loaded sounds.
--- @return table The list of loaded sounds.
--- @usage local sounds = SoundsBank.getLoadedSounds()
function SoundsBank.getLoadedSounds()
	return loadedSounds
end
--- Unloads all loaded sounds.
--- @usage SoundsBank.cleanup()
function SoundsBank.cleanup()
    Debugger.msg("Cleaning up sounds")
    for key, _ in pairs(loadedSounds) do
        SoundsBank.unloadSound(loadedSounds[key].path)
    end
	loadedSounds = {}
end
--- Unloads a sound from memory.
--- @param path string The path to the sound file.
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