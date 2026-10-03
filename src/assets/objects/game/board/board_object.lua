local GameObject = require("gameobject.m2d_gameobject")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local BoardChecker = require("scripts.objects.board.board_checker_script")
local Debugger = require("debugger.m2d_debugger")
local SoundSystem = require("systems.sound.m2d_sound_system")
local SoundsBank = require("banks.sounds.m2d_sounds_bank")

local GeneratorScript = dofile("romfs:/assets/scripts/objects/board/board_generator_script.lua")
local thisObject = GameObject:new("board")
local gameOverTopPanel
local gameOverBottomPanel
local timerObject
local Script = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

function thisObject.callCheck()
    if BoardChecker.check(thisObject) then
        Debugger.msg("SOLVED!")
        CollisionSystem.setLayerActive(1, false)
        gameOverTopPanel:setVisible(true, "Completed!")
        gameOverBottomPanel:setVisible(true)
        timerObject.stopTimer()
    end
end

Script.start = function()
    GeneratorScript.start(thisObject)
    gameOverBottomPanel = GameObject.findByName("gameover_panel_bottom")
    gameOverTopPanel = GameObject.findByName("gameover_panel_top")
    timerObject = GameObject.findByName("timer")
    SoundSystem.playBgm("romfs:/assets/sounds/music/ingame.ogg")
end

return thisObject