--- Makes a game object follow the touch while its box collider is pressed.
--- @module components_draggable
--- @author Sharper Dev

local Draggable = {}
Draggable.__index = Draggable

local InputSystem = require("systems.input.m2d_input_system")

--- Creates a draggable component; requires an existing BoxCollider.
--- @param gameObject table Game object to move while dragging.
--- @return table The new Draggable component.
function Draggable:new(gameObject)
    self = setmetatable({}, Draggable)

    self.enabled = true
    self.name = "Draggable"
    self.gameObject = gameObject
    self.boxCollider = gameObject:getComponent("BoxCollider")
    if self.boxCollider == nil then
        error("Draggable requires a BoxCollider component")
    end
    self:registerFunctions()

    return self
end
--- Begins dragging and invokes the drag-start callback.
local function onTouchDown(self)
    self.isDragging = true
    self:onDragStart()
end

--- Ends dragging and invokes the drag-end callback.
local function onTouchUp(self)
    self.isDragging = false
    self:onDragEnd()
end

--- Assigns touch-down and touch-up handlers to the required BoxCollider.
function Draggable:registerFunctions()
    self.boxCollider.onTouchDown = function() onTouchDown(self) end
    self.boxCollider.onTouchUp = function() onTouchUp(self) end
end

--- While dragging, moves the game object to the current touch position and calls `onDragging`.
function Draggable:update()
    if self.isDragging then
        local x, y = InputSystem.getTouch()
        self.gameObject.transform:setPosition(x, y)

        self:onDragging()
    end
end

--- Override to handle the start of a drag, triggered by collider touch-down.
function Draggable:onDragStart() end

--- Override to handle each update while dragging; called after moving the object.
function Draggable:onDragging() end

--- Override to handle the end of a drag, triggered by collider touch-up.
function Draggable:onDragEnd() end

return Draggable