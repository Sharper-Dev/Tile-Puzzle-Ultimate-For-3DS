local uiButton = require("scripts.builders.ui_button_builder")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local PauseManager = require("scripts.general.managers.pause_manager")
local FadeAnimation = require("scripts.general.animations.fade_animation")
local Time = require("time.m2d_time")

local Builder = {}

function Builder.buildButton(name, label, textOffset, position, sceneIndex)
    local buttonObject = uiButton.buildButton(name, label)
    local script = buttonObject:getComponent("Script")
    local button = buttonObject:getComponent("Button")
    local elapsed = 0
    local clicked = false

    buttonObject.textOffset = textOffset
    buttonObject.transform:setPosition(position.x, position.y, position.z)

    local baseUpdate = script.update
    function script.update()
        baseUpdate()
        if not clicked then return end

        elapsed = elapsed + Time.deltaTime
        if elapsed < 0.3 then return end

        clicked = false
        elapsed = 0
        CollisionSystem.setLayerActive(1, true)
        CollisionSystem.setLayerActive(2, true)
        CollisionSystem.setLayerActive(3, false)
        CollisionSystem.setLayerActive(4, false)
        PauseManager.setPause(false)
        ScenesSystem.loadScene(sceneIndex)
    end

    function button.onClick()
        if clicked then return end
        clicked = true
        elapsed = 0
        FadeAnimation.callFadeIn(0.2)
    end

    return buttonObject
end

return Builder
