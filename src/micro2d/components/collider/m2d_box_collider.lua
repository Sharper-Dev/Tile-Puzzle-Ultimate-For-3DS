--- Axis-aligned box collider attached to a game object.
--- @module components_boxcollider
--- @author Sharper Dev

local BoxCollider = {}
BoxCollider.__index = BoxCollider

local CollisionSystem = require("systems.collision.m2d_collision_system")
local Debugger = require("debugger.m2d_debugger")
local Renderer = require("systems.renderer.m2d_renderer")
local RenderTask = require("systems.renderer.m2d_render_task")

--- Creates a collider with a default size of 10×10 and registers it with the collision system.
--- @param gameObject table Game object that owns this collider.
--- @return table The new BoxCollider component.
--- @usage local collider = gameObject:addComponent("BoxCollider")
function BoxCollider:new(gameObject)
    self = setmetatable({}, BoxCollider)

    self.enabled = true
    self.name = "BoxCollider"
    self.gameObject = gameObject
    self:setSize(10, 10)
    self:setOffset(0, 0)
    self.enteredCollisions = {}
    self.ignoreMetaLayers = {}
    self.collisionLayer = 1
    self.metaCollisionLayer = 1
    CollisionSystem.registerCollider(self.collisionLayer, self)
    self.renderTask = RenderTask:new({
        layer = 1,
        execute = function() self:render() end
    })
    Renderer.registerRenderTask(self.renderTask, BOTTOM_SCREEN, Renderer.SPACES.SCREEN)
    return self
end

--- Moves this collider to a collision-system layer.
--- @param layer number Collision layer to register under.
--- @usage collider:setLayer(2)
function BoxCollider:setLayer(layer)
    CollisionSystem.registerCollider(layer, self)
    CollisionSystem.unregisterCollider(self.collisionLayer, self)
    self.collisionLayer = layer
end

--- Sets the meta collision layer used to filter collisions.
--- @param layer number Meta collision layer.
--- @usage collider:setMetaLayer(2)
function BoxCollider:setMetaLayer(layer)
    self.metaCollisionLayer = layer
end

--- Adds a meta collision layer to this collider's ignore list.
--- @param metaLayer number Meta collision layer to ignore.
--- @usage collider:insertIgnoreMetaLayer(1)
function BoxCollider:insertIgnoreMetaLayer(metaLayer)
    table.insert(self.ignoreMetaLayers, metaLayer)
end

--- Removes the first matching meta collision layer from the ignore list.
--- @param metaLayer number Meta collision layer to stop ignoring.
--- @usage collider:removeIgnoreMetaLayer(1)
function BoxCollider:removeIgnoreMetaLayer(metaLayer)
    for i, layer in ipairs(self.ignoreMetaLayers) do
        if layer == metaLayer then
            table.remove(self.ignoreMetaLayers, i)
            return
        end
    end
end

--- Draws the collider outline when the debugger is enabled.
function BoxCollider:render()
    if not Debugger.isEnabled() then return end

    local positionx = self.gameObject.transform.position.x
    local positiony = self.gameObject.transform.position.y
    positionx = positionx + self.xoffset
    positiony = positiony + self.yoffset
    Graphics.fillEmptyRect(positionx, self.width + positionx, positiony, self.height + positiony,
        Color.new(0, 255, 0))
end

--- Unregisters the collider and its render task.
function BoxCollider:destroy()
    CollisionSystem.unregisterCollider(self.collisionLayer, self)
    Renderer.unregisterRenderTask(self.renderTask, BOTTOM_SCREEN, Renderer.SPACES.SCREEN)
	self.gameObject = nil
    self.renderTask = nil
    self.enabled = nil
    self = nil
end
--- Sets the collider's width and height.
--- @param width number Collider width.
--- @param height number Collider height.
--- @usage collider:setSize(32, 24)
function BoxCollider:setSize(width, height)
    self.width = width
    self.height = height
end

--- Sets the collider's offset from the game object's position.
--- @param x number Horizontal offset.
--- @param y number Vertical offset.
--- @usage collider:setOffset(4, 0)
function BoxCollider:setOffset(x, y)
    self.xoffset = x
    self.yoffset = y
end

--- Collision-enter callback; override to react when a collision begins.
--- @param collider table The other collider involved in the collision.
--- @usage
--- function collider:onCollisionEnter(other)
---     -- Code here
--- end
function BoxCollider:onCollisionEnter(collider) end

--- Collision-stay callback; override to react while a collision continues.
--- @param collider table The other collider involved in the collision.
--- @usage
--- function collider:onCollisionStay(other)
---     -- Code here
--- end
function BoxCollider:onCollisionStay(collider) end

--- Collision-exit callback; override to react when a collision ends.
--- @param collider table The other collider involved in the collision.
--- @usage
--- function collider:onCollisionExit(other)
---     -- Code here
--- end
function BoxCollider:onCollisionExit(collider) end

--- Touch-down callback; override to react when a touch begins on this collider.
--- @usage
--- function collider:onTouchDown()
---     -- Code here
--- end
function BoxCollider:onTouchDown() end

--- Touch-stay callback; override to react while this collider remains touched.
--- @usage
--- function collider:onTouchStay()
---     -- Code here
--- end
function BoxCollider:onTouchStay() end

--- Touch-click callback; override to react when this collider is clicked.
--- @usage
--- function collider:onTouchClick()
---     -- Code here
--- end
function BoxCollider:onTouchClick() end

--- Touch-up callback; override to react when a touch on this collider ends.
--- @usage
--- function collider:onTouchUp()
---     -- Code here
--- end
function BoxCollider:onTouchUp() end

return BoxCollider