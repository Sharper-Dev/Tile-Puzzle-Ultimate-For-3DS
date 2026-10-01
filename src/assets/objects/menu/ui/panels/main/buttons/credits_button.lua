local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local uiButton = require("scripts.builders.ui_button_builder")
local GameObject = require("gameobject.m2d_gameobject")
local thisObject = uiButton.buildButton("credits_button", "Credits")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")
local mainPanelBottom
local mainPanelTop
local baseStart = thisScript.start
thisObject.textOffset = { x = 45, y = 23 }

function thisScript.start()
    baseStart()

    thisObject.transform:setPosition(90, 94, 1)
    mainPanelBottom = GameObject.findByName("main_panel_bottom")
    mainPanelTop = GameObject.findByName("main_panel_top")
end

function thisButton.onClick()
    mainPanelBottom:setVisible(false)
    mainPanelTop:setVisible(false)
end

return thisObject