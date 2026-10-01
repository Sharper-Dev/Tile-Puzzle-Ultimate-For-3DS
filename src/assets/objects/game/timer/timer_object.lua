local GameObject = require("gameobject.m2d_gameobject")
local Time = require("time.m2d_time")
local PauseManager = require("scripts.general.managers.pause_manager")

local thisObject = GameObject:new("timer")
local Script = thisObject:addComponent("Script")
local Text = thisObject:addComponent("Text")

local gameOverBottomPanel
local gameOverTopPanel

local isCounting = true
local initialTime = 90
local timerValue = initialTime

function Script.start()
    thisObject.transform:setPosition(95, 210, 1)
    local canvas = GameObject.findByName("canvas_top")
    Text:setCanvas(canvas.canvas)
    Text:setFont("LTStudent")
    Text:setContent("00:00:00")
    isCounting = true
    gameOverBottomPanel = GameObject.findByName("gameover_panel_bottom")
    gameOverTopPanel = GameObject.findByName("gameover_panel_top")
end

function Script.update()
    if isCounting and not PauseManager.isPaused() then
        timerValue = timerValue - Time.deltaTime
        if timerValue <= 0 then
            timerValue = 0
            isCounting = false
            gameOverTopPanel:setVisible(true, "Game Over")
            gameOverBottomPanel:setVisible(true)
        end
        Text:setContent(string.format("%02d:%02d:%02d", math.floor(timerValue / 60), math.floor(timerValue % 60), math.floor((timerValue % 1) * 100)))
    end
end

function thisObject.stopTimer()
    isCounting = false
end

return thisObject