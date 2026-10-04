--- Debugger module containing functions for the Micro2D debugger.
--- @module debugger_functions
--- @author Sharper Dev

local Functions = {}
local InputSystem = require("systems.input.m2d_input_system")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local DebuggerUI = require("debugger.m2d_debugger_ui")

--- The key used to trigger debugger functions. | Default: KEY_L
local functionKey = KEY_L

--- The key used to quickly step the debug object movement. | Default: KEY_R
local quickStepKey = KEY_R

--- The key used to disable the debugger. | Default: KEY_B
local disableKey = KEY_B

--- The key used to switch to the top debug screen. | Default: KEY_DUP
local switchToTopKey = KEY_DUP

--- The key used to switch to the bottom debug screen. | Default: KEY_DDOWN
local switchToBottomKey = KEY_DDOWN

--- The key used to switch to the next debug object. | Default: KEY_DRIGHT
local switchObjectToNextKey = KEY_DRIGHT

--- The key used to switch to the previous debug object. | Default: KEY_DLEFT
local switchObjectToPrevKey = KEY_DLEFT

--- Internal function that switches to the next or previous debug object.
--- @param isForward boolean Whether to switch to the next or previous object.
local function switchObject(isForward)
    local Debugger = require("debugger.m2d_debugger")
    local objectCount = #ScenesSystem.getActiveScenes()[1].gameObjects
    local direction = isForward and 1 or -1

    Debugger.currentObjectIndex = (Debugger.currentObjectIndex + direction) % objectCount

    if Debugger.currentObjectIndex < 1 then
        Debugger.currentObjectIndex = objectCount
    end

    Debugger.debugObject(ScenesSystem.getActiveScenes()[1].gameObjects[Debugger.currentObjectIndex])
end

--- Moves the selected debug object in response to directional input.
--- Holding the quick-step key increases each movement from 1 to 10 units.
--- @usage Functions.detectMove()
function Functions.detectMove()
    local Debugger = require("debugger.m2d_debugger")

    if Debugger.getDebugObject() and not InputSystem.getKey(functionKey) then
        local step = (InputSystem.getKey(quickStepKey)) and 10 or 1
        if InputSystem.getKeyDown(KEY_DUP) then
            Debugger.getDebugObject().transform:translate(0, -step)
        end
        if InputSystem.getKeyDown(KEY_DDOWN) then
            Debugger.getDebugObject().transform:translate(0, step)
        end
        if InputSystem.getKeyDown(KEY_DLEFT) then
            Debugger.getDebugObject().transform:translate(-step, 0)
        end
        if InputSystem.getKeyDown(KEY_DRIGHT) then
            Debugger.getDebugObject().transform:translate(step, 0)
        end
    end
end

--- Handles debugger shortcuts while the function key is held.
--- @usage Functions.detectFunction()
function Functions.detectFunction()
    local Debugger = require("debugger.m2d_debugger")

    if InputSystem.getKey(functionKey) then
        if InputSystem.getKeyDown(switchToTopKey) then
            DebuggerUI.switchDebugScreen(TOP_SCREEN)
        elseif InputSystem.getKeyDown(switchToBottomKey) then
            DebuggerUI.switchDebugScreen(BOTTOM_SCREEN)
        end
        if InputSystem.getKeyDown(disableKey) then
            Debugger.setEnable(false)
            DebuggerUI.objects["DEBUGGER_CANVAS"].canvas.enabled = false
        end
        if InputSystem.getKeyDown(switchObjectToNextKey) then
            switchObject(true)
        elseif InputSystem.getKeyDown(switchObjectToPrevKey) then
            switchObject(false)
        end
    end
end

return Functions