local uiButton = require("scripts.builders.ui_button_builder")
local Runtime = require("core.m2d_core_runtime")
local InputSystem = require("systems.input.m2d_input_system")

local thisObject = uiButton.buildButton("quit_button", "Quit")

local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local baseStart = thisScript.start
local baseUpdate = thisScript.update
thisObject.textOffset = { x = 62, y = 23 }

function thisScript.start()
    baseStart()
    thisObject.transform:setPosition(90, 120, 1)
end

function thisScript.update()
    baseUpdate()
    if InputSystem.getKeyDown(KEY_HOME) then
        Runtime.endRuntime()
    end
end

function thisButton.onClick()
    Runtime.endRuntime()
end

return thisObject