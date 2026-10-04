--- Provides background music playback through the sound bank.
--- @module systems_sound
--- @author Sharper Dev

local SoundsBank = require("banks.sounds.m2d_sounds_bank")
local SoundSystem = {}
local currentBgm = nil
--- Opens and loops an OGG track, unloading the previous background track first.
--- @param soundPath string Path to the OGG file.
--- @usage SoundSystem.playBgm("romfs:/sounds/music.ogg")
function SoundSystem.playBgm(soundPath)
    if currentBgm then
        SoundsBank.unloadSound(currentBgm.path)
    end
    SoundsBank.loadSound("ogg", true, soundPath)
    local loadedSounds = SoundsBank.getLoadedSounds()
    currentBgm = loadedSounds[soundPath]
    Sound.play(currentBgm.wav_id, LOOP)
end

return SoundSystem