--- Debugger UI module for the Micro2D debugger.
--- @module debugger_ui
--- @author Sharper Dev

local DebuggerUI = {}

local GameObject = require("gameobject.m2d_gameobject")

local currentScreen = BOTTOM_SCREEN

local topScreenOffset = 40

DebuggerUI.objects = {}
DebuggerUI.texts = {}

--- Creates and registers the debugger's canvas, labels, and console.
--- @usage DebuggerUI.createUI()
function DebuggerUI.createUI()
    DebuggerUI.objects["DEBUGGER_CANVAS"] = GameObject.instantiate(GameObject:new("DEBUGGER_CANVAS"), true)
    DebuggerUI.objects["DEBUGGER_CANVAS"].transform:setPosition(0, 0, 99)

    local canvas = DebuggerUI.objects["DEBUGGER_CANVAS"]:addComponent("Canvas", currentScreen)
    canvas:switchScreen(currentScreen)

    DebuggerUI.objects["DEBUGGER_TITLE"] = GameObject.instantiate(GameObject:new("DEBUGGER_TITLE"), true)
    DebuggerUI.objects["DEBUGGER_TITLE"].transform:setPosition(90, 10, 101):setScale(2, 2)
    DebuggerUI.objects["DEBUGGER_TITLE"]:addComponent("Text")
        :setContent("DEBUG MODE")
        :setCanvas(canvas)

    local backgroundObject = GameObject.instantiate(GameObject:new("DEBUGGER_BACKGROUND"), true)

    backgroundObject.transform:setPosition(0, 0, 100):setScale(2)
    backgroundObject:addComponent("Image")
        :setCanvas(canvas)
        :setColor(0, 0, 0)
    DebuggerUI.objects["DEBUGGER_OBJECT_INFO"] = GameObject.instantiate(GameObject:new("DEBUGGER_OBJECT_INFO"), true)
    DebuggerUI.objects["DEBUGGER_OBJECT_INFO"].transform:setPosition(5, 97, 101)

    DebuggerUI.texts["DEBUGGER_OBJECT_INFO"] = DebuggerUI.objects["DEBUGGER_OBJECT_INFO"]:addComponent("Text")
        :setCanvas(canvas)
        :setLineBreakDistance(13)

    DebuggerUI.objects["DEBUGGER_RUNTIME_INFO"] = GameObject.instantiate(GameObject:new("DEBUGGER_RUNTIME_INFO"), true)
    DebuggerUI.objects["DEBUGGER_RUNTIME_INFO"].transform:setPosition(5, 40, 101)

    DebuggerUI.texts["DEBUGGER_RUNTIME_INFO"] = DebuggerUI.objects["DEBUGGER_RUNTIME_INFO"]:addComponent("Text", "")
        :setCanvas(canvas)
        :setLineBreakDistance(13)

    -- DebuggerUI.objects["DEBUGGER_HINTS"] = GameObject.instantiate(GameObject:new("DEBUGGER_HINTS"), true)
    -- DebuggerUI.objects["DEBUGGER_HINTS"].transform:setPosition(205, 40, 101)

    -- DebuggerUI.texts["DEBUGGER_HINTS"] = DebuggerUI.objects["DEBUGGER_HINTS"]:addComponent("Text")
    --     :setContent("L + UP:\nTo top screen\nL + DOWN:\nTo bottom screen\nL + Right/Left:\nSwitch object\nR + Right/Left:\nQuick step\nL + B: Quit")
    --     :setLineBreakDistance(13)
    --     :setCanvas(canvas)

    DebuggerUI.objects["DEBUGGER_CONSOLE"] = GameObject.instantiate(GameObject:new("DEBUGGER_CONSOLE"), true)
    DebuggerUI.objects["DEBUGGER_CONSOLE"].transform:setPosition(5, 200, 101)

    DebuggerUI.texts["DEBUGGER_CONSOLE"] = DebuggerUI.objects["DEBUGGER_CONSOLE"]:addComponent("Text", "")
        :setLineBreakDistance(12)
        :setCanvas(canvas)
end

--- Moves the debugger UI to the selected screen.
--- @param screen screen_id Screen identifier, typically TOP_SCREEN or BOTTOM_SCREEN.
--- @usage DebuggerUI.switchDebugScreen(TOP_SCREEN)
function DebuggerUI.switchDebugScreen(screen)
    if screen == currentScreen then return end
    currentScreen = screen

    DebuggerUI.objects["DEBUGGER_CANVAS"].canvas:switchScreen(screen)
    local offset = screen == TOP_SCREEN and topScreenOffset or -topScreenOffset
    DebuggerUI.objects["DEBUGGER_TITLE"].transform:translate(offset)
    DebuggerUI.objects["DEBUGGER_RUNTIME_INFO"].transform:translate(offset)
    DebuggerUI.objects["DEBUGGER_OBJECT_INFO"].transform:translate(offset)
    --DebuggerUI.objects["DEBUGGER_HINTS"].transform:translate(offset)
    DebuggerUI.objects["DEBUGGER_CONSOLE"].transform:translate(offset)
end

return DebuggerUI