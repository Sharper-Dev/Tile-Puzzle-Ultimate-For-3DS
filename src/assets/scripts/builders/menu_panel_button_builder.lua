local GameObject = require("gameobject.m2d_gameobject")
local uiButton = require("scripts.builders.ui_button_builder")

local Builder = {}

function Builder.buildButton(name, label, textOffset, position, showCredits)
    local buttonObject = uiButton.buildButton(name, label)
    local script = buttonObject:getComponent("Script")
    local button = buttonObject:getComponent("Button")
    local mainPanelBottom
    local mainPanelTop
    local creditsPanelBottom
    local creditsPanelTop

    buttonObject.textOffset = textOffset
    buttonObject.transform:setPosition(position.x, position.y, position.z)

    local baseStart = script.start
    function script.start()
        baseStart()
        mainPanelBottom = GameObject.findByName("main_panel_bottom")
        mainPanelTop = GameObject.findByName("main_panel_top")
        creditsPanelBottom = GameObject.findByName("credits_panel_bottom")
        creditsPanelTop = GameObject.findByName("credits_panel_top")
    end

    function button.onClick()
        mainPanelBottom:setVisible(not showCredits)
        mainPanelTop:setVisible(not showCredits)
        creditsPanelBottom:setVisible(showCredits)
        creditsPanelTop:setVisible(showCredits)
    end

    return buttonObject
end

return Builder
