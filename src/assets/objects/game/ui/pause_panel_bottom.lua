local GameObject = require("gameobject.m2d_gameobject")
local PauseManager = require("scripts.general.managers.pause_manager")
local InputSystem = require("systems.input.m2d_input_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local Time = require("time.m2d_time")
local Runtime = require("core.m2d_core_runtime")

local thisObject = GameObject:new("pause_panel_bottom")
local Script = thisObject:addComponent("Script")
local Image = thisObject:addComponent("Image")

local pauseButton

local function setPanelActive(active)
    Image.enabled = active
    CollisionSystem.setLayerActive(1, not active)
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    PauseManager.pausePanelBottom = thisObject
    pauseButton = GameObject.findByName("pause_button")
    pauseButton:getComponent("Button").collider:setLayer(2)
    thisObject.transform:setPosition(0, 0, 2)
    local canvas = GameObject.findByName("canvas")
    Image:setColor(0, 0, 0, 150)
    Image:setCanvas(canvas.canvas)
    setPanelActive(false)
end

function Script.update()

end

return thisObject