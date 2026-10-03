local GameObject = require("gameobject.m2d_gameobject")
local PauseManager = require("scripts.general.managers.pause_manager")
local InputSystem = require("systems.input.m2d_input_system")
local SineAnimation = require("scripts.general.animations.sine_animation")
local FadeAnimation = require("scripts.general.animations.fade_animation")

local thisObject = GameObject:new("gameover_panel_top")
local Script = thisObject:addComponent("Script")
local panelBg
local panelBgImage
local textObject
local textComponent

local textAnimation = SineAnimation.new({
    position = { x = 85, y = 120, z = 3 },
    amplitudeY = 5,
    frequency = 3,
})

local function setPanelActive(active)
    panelBg.enabled = active
    textComponent.enabled = active

    if active then
        FadeAnimation.startFadeIn(panelBgImage, 0.2, 200)
    end
end

function thisObject:setVisible(value, text)
    if text then
        textComponent:setContent(text)
    end
    if value then
        textAnimation:start(textObject)
    end
    setPanelActive(value)
end

function Script.start()
    textObject = GameObject.instantiate(GameObject:new("gameover_text"), false)
    panelBg = GameObject.findByName("panel_background_top")
    panelBgImage = panelBg:getComponent("Image")

    local canvas = GameObject.findByName("canvas_top")
    textComponent = textObject:addComponent("Text")
    textComponent:setFont("LTStudent_b")
    textComponent:setContent("Game Over")
    textComponent:setCanvas(canvas.canvas)

    thisObject.transform:setPosition(0, 0, 2)
    setPanelActive(false)
end

function Script.update()
    if textObject then
        textAnimation:update(textObject)
    end
end

return thisObject