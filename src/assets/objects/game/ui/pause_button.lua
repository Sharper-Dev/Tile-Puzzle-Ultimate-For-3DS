local uiButton = require("scripts.builders.ui_button_builder")
local PauseManager = require("scripts.general.managers.pause_manager")
local thisObject = uiButton.buildButton("pause_button", nil, "romfs:/assets/sprites/buttons/button_pause.png")
local thisButton = thisObject:getComponent("Button")

thisObject.transform:setPosition(281, 201, 1)

function thisButton.onClick()
    local currentStatus = PauseManager.isPaused()
	PauseManager.setPause(not currentStatus)
end

return thisObject