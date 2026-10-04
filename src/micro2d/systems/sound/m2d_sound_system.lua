--- Manages sound effects and background music in the game.
--- @module systems_sound
--- @author Sharper Dev

local SoundsBank = require("banks.sounds.m2d_sounds_bank")
local SoundSystem = {}
local currentBgm = nil

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