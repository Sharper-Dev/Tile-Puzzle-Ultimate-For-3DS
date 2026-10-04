--- Manages sounds for the Micro2D engine.
--
--- The SoundsBank stores loaded sounds and provides methods to load and unload them. Preventing duplicate loading of the same sound.
--- @module bank_sounds
--- @author Sharper Dev
local Debugger = require("debugger.m2d_debugger")
local SoundsBank = {}

local loadedSounds = {}

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

function SoundsBank.getLoadedSounds()
	return loadedSounds
end

function SoundsBank.cleanup()
    Debugger.msg("Cleaning up sounds")
    for key, _ in pairs(loadedSounds) do
        SoundsBank.unloadSound(loadedSounds[key].path)
    end
	loadedSounds = {}
end

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