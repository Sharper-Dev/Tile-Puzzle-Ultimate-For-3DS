local GameObject = require("gameobject.m2d_gameobject")
local InputSystem = require("systems.input.m2d_input_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local Time = require("time.m2d_time")
local Runtime = require("core.m2d_core_runtime")
local FadeAnimation = require("scripts.general.animations.fade_animation")

local thisObject = GameObject:new("quit_panel")
local Script = thisObject:addComponent("Script")
local Image = thisObject:addComponent("Image")
local textComponent
local quitTimer = 0
local hasQuit = false
local fadeObjectTop
local fadeImageTop

local fadeObjectBottom
local fadeImageBottom
local function setPanelActive(active)
    Image.enabled = active
    textComponent.enabled = active
    CollisionSystem.setLayerActive(1, not active)
end

function Script.start()
    thisObject.transform:setPosition(160, 108)
    local canvas = GameObject.findByName("canvas")
    Image:setImage("romfs:/assets/sprites/panels/dialog_panel.png")
    Image:setCanvas(canvas.canvas)

    fadeObjectTop = GameObject.findByNameUniversal("fade_object_top")
    fadeImageTop = fadeObjectTop:getComponent("Image")

    fadeObjectBottom = GameObject.findByNameUniversal("fade_object_bottom")
    fadeImageBottom = fadeObjectBottom:getComponent("Image")
    fadeImageTop:setColor(0, 0, 0, 0)
    fadeImageBottom:setColor(0, 0, 0, 0)

    local textObject = GameObject.instantiate(GameObject:new("quit_text"), false)
    textObject.transform:setScale(0.4, 0.4)
    textComponent = textObject:addComponent("Text")
    textComponent:setContent("Quitting...")
    textComponent:setCanvas(canvas.canvas)
    textComponent:setFont("LTStudent")
    textComponent.gameObject.transform:setPosition(121, 95, thisObject.transform.position.z + 1)
    setPanelActive(false)
end

function Script.update()
    if InputSystem.getKeyDown(KEY_HOME) then
        if not hasQuit then
            FadeAnimation.startFadeIn(fadeImageTop, 1)
            FadeAnimation.startFadeIn(fadeImageBottom, 1)
            hasQuit = true
            CollisionSystem.setLayerActive(1, false)
            CollisionSystem.setLayerActive(2, false)
            CollisionSystem.setLayerActive(3, false)
            CollisionSystem.setLayerActive(4, false)
        end
        quitTimer = quitTimer + Time.deltaTime
        if quitTimer >= 1 then
            Runtime.endRuntime()
        end
        setPanelActive(true)
    end
end

return thisObject