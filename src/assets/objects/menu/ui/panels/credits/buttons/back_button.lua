local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local uiButton = require("scripts.builders.ui_button_builder")
local GameObject = require("gameobject.m2d_gameobject")
local thisObject = uiButton.buildButton("back_button", "Back")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local mainPanelBottom
local mainPanelTop
local creditsPanelBottom
local creditsPanelTop
local baseStart = thisScript.start
thisObject.textOffset = { x = 60, y = 23 }

function thisScript.start()
    baseStart()

    thisObject.transform:setPosition(90, 174, 1)
    mainPanelBottom = GameObject.findByName("main_panel_bottom")
    mainPanelTop = GameObject.findByName("main_panel_top")
    creditsPanelBottom = GameObject.findByName("credits_panel_bottom")
    creditsPanelTop = GameObject.findByName("credits_panel_top")
end

function thisButton.onClick()
    mainPanelBottom:setVisible(true)
    mainPanelTop:setVisible(true)
    creditsPanelBottom:setVisible(false)
    creditsPanelTop:setVisible(false)
end

return thisObject