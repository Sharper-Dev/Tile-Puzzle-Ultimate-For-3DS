local uiButton = require("scripts.builders.ui_button_builder")
local PauseManager = require("scripts.general.managers.pause_manager")

local thisObject = uiButton.buildButton("return_button", "Return")
local thisButton = thisObject:getComponent("Button")

thisObject.textOffset = { x = 47, y = 23 }
thisObject.transform:setPosition(90, 30, 3)

function thisButton.onClick()
    PauseManager.setPause(false, true)
end

return thisObject