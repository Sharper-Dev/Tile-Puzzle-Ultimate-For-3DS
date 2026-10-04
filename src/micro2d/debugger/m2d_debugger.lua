--- Debugger module for the Micro2D engine.
--- @module debugger
--- @author Sharper Dev

local Debugger = {}

local Time = require("time.m2d_time")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local Enabler = require("debugger.m2d_debugger_enabler")
local DebuggerUI = require("debugger.m2d_debugger_ui")
local Functions = require("debugger.m2d_debugger_functions")

local isEnabled = false

local consoleMessages = {"-", "-", "-", "-"}

local runtimeUpdateDelay = 0.5
local runtimeUpdateTimer

local objectToDebug

Debugger.currentObjectIndex = 1

--- Internal function to update the runtime info.
local function updateRuntimeInfo()
    local fps = math.floor(1 / Time.deltaTime)
    DebuggerUI.texts["DEBUGGER_RUNTIME_INFO"]:setContent(string.format("Lua RAM Usage: %.2f MB\nFPS: %d\nDelta Time: %.3fs\nCurrent scene: %s",
        collectgarbage("count") / 1024,
        fps,
        Time.deltaTime,
        ScenesSystem.getActiveScenes()[1].name))
end

--- Internal function to update the object info.
local function updateObjectInfo()
    if objectToDebug then
        local name = objectToDebug.name
        local position = objectToDebug.transform.position
        local rotation = objectToDebug.transform.rotation
        local scale = objectToDebug.transform.scale

        DebuggerUI.texts["DEBUGGER_OBJECT_INFO"]:setContent(string.format(
            "Debugging:\n%s\nPosition: (%.1f, %.1f, %.1f)\nRotation: %d\nScale: (%.1f, %.1f)",
            name, position.x, position.y, position.z, rotation, scale.x, scale.y))
    else
        DebuggerUI.texts["DEBUGGER_OBJECT_INFO"]:setContent("Not debugging object")
    end
end

--- Internal function to set up the debugger UI when the sequence code is activated.
function Debugger.setupDebugger()
    runtimeUpdateTimer = Timer.new()
    isEnabled = true
    DebuggerUI.createUI()
    updateRuntimeInfo()
    Debugger.debugObject(ScenesSystem.getActiveScenes()[1].gameObjects[Debugger.currentObjectIndex])
    Debugger.msg("Debugger initialized")
end

--- Adds a message to the debugger console when the debugger is enabled.
--- The console retains only the four most recent messages.
--- @param msg string Message text to display.
--- @usage Debugger.msg("Simulation started")
function Debugger.msg(msg)
    if not isEnabled then return end

    table.insert(consoleMessages, msg)

    if #consoleMessages > 4 then
        table.remove(consoleMessages, 1)
    end

    local content = ""

    for i = 1, #consoleMessages do
        content = content .. consoleMessages[i] .. "\n"
    end

    DebuggerUI.texts["DEBUGGER_CONSOLE"]:setContent(content)
end
--- Internal function that updates the debugger state each frame.
function Debugger.update()
    Enabler.detectCode()
    Functions.detectFunction()
    if isEnabled then
        Functions.detectMove()
        updateObjectInfo()
        if Timer.getTime(runtimeUpdateTimer) / 1000 >= runtimeUpdateDelay then
            updateRuntimeInfo()
            Timer.reset(runtimeUpdateTimer)
        end
    end
end

--- Returns whether debugger updates are enabled.
--- @return boolean enabled True when the debugger is enabled.
--- @usage local enabled = Debugger.isEnabled()
function Debugger.isEnabled()
    return isEnabled
end

--- Enables or disables debugger updates.
--- @param value boolean True to enable the debugger; false to disable it.
--- @usage Debugger.setEnable(false)
function Debugger.setEnable(value)
    isEnabled = value
end

--- Selects the object whose details are shown by the debugger.
--- Pass nil to clear the selection.
--- @param obj GameObject|nil Object to inspect, or nil to clear it.
--- @usage Debugger.debugObject(myGameObject)
function Debugger.debugObject(obj)
    objectToDebug = obj
end

--- Returns the selected debug object, if any.
--- @return GameObject|nil object Selected object, or nil when none is selected.
--- @usage local object = Debugger.getDebugObject()
function Debugger.getDebugObject()
    return objectToDebug
end

return Debugger