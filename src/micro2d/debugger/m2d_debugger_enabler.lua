--- Module for enabling the Micro2D debugger.
--- @module debugger_enabler
--- @author Sharper Dev

local Enabler = {}

local InputSystem = require("systems.input.m2d_input_system")

local hasSetup = false
--- Button sequence required to enable the debugger.
--- The default sequence is the Konami code.
local enableCode = { KEY_DUP, KEY_DUP,
    KEY_DDOWN, KEY_DDOWN,
    KEY_DLEFT, KEY_DRIGHT,
    KEY_DLEFT, KEY_DRIGHT,
    KEY_B, KEY_A, KEY_START }

local currentCodeIndex = 1

--- Checks the current input for progress through the debugger activation sequence.
--- @usage Enabler.detectCode()
function Enabler.detectCode()
    local rawInput = InputSystem.getRawInput() & 0x0FFF
    local Debugger = require("debugger.m2d_debugger")
    if rawInput == 0 or Debugger.isEnabled() then return end

    if currentCodeIndex == #enableCode + 1 then
        if not hasSetup then
            Debugger.setupDebugger()
            hasSetup = true
        else
            Debugger.setEnable(true)
            require("debugger.m2d_debugger_ui").objects["DEBUGGER_CANVAS"].canvas.enabled = true
        end
        currentCodeIndex = 1
        return
    end

    if InputSystem.getKeyDown(enableCode[currentCodeIndex]) then
        if rawInput == enableCode[currentCodeIndex] then
            currentCodeIndex = currentCodeIndex + 1
        end
        return
    end

    if InputSystem.getKeyDown(rawInput) then
        currentCodeIndex = 1
    end
end

return Enabler