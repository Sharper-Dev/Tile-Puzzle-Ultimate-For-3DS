local GameObject = require("gameobject.m2d_gameobject")
local PauseManager = require("scripts.general.managers.pause_manager")
local InputSystem = require("systems.input.m2d_input_system")
local SineAnimation = require("scripts.general.animations.sine_animation")

local thisObject = GameObject:new("pause_panel_top")
local Script = thisObject:addComponent("Script")
local Image = thisObject:addComponent("Image")
local textObject

local titleAnimation = SineAnimation.new({
    position = { x = 140, y = 120, z = 3 },
    amplitudeY = 5,
    frequency = 3,
})

local function setPanelActive(active)
    Image.enabled = active
    textObject.enabled = active
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    textObject = GameObject.instantiate(GameObject:new("pause_text"), false)
    titleAnimation:start(textObject)
    local textComponent = textObject:addComponent("Text")
    textComponent:setFont("LTStudent_b")
    textComponent:setContent("PAUSE")

    PauseManager.pausePanelTop = thisObject
    thisObject.transform:setPosition(0, 0, 2)
    local canvas = GameObject.findByName("canvas_top")
    textComponent:setCanvas(canvas.canvas)
    Image:setColor(0, 0, 0, 150)
    Image:setCanvas(canvas.canvas)
    setPanelActive(false)
end

function Script.update()
    if textObject then
        titleAnimation:update(textObject)
    end
    if InputSystem.getKeyDown(KEY_START) then
        local isPaused = PauseManager.isPaused()
        PauseManager.setPause(not isPaused)
    end
end

return thisObject