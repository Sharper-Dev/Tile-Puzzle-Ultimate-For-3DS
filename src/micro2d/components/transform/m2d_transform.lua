--- Stores a game object's position, rotation, and scale.
--- @module components_transform
--- @author Sharper Dev

local Transform = {}
Transform.__index = Transform

--- Functions
--- @section functions

--- Creates a transform at the origin with zero rotation and unit scale.
--- @param gameObject table Game object that owns this transform.
--- @return table The new Transform.
function Transform:new(gameObject)
    self = setmetatable({}, Transform)
    self.gameObject = gameObject
    self.position = { x = 0, y = 0, z = 0 }
    self.rotation = 0
    self.scale = { x = 1, y = 1 }

    return self
end

--- Sets the provided position coordinates; omitted (`nil`) coordinates remain unchanged.
--- @param x number|nil X coordinate.
--- @param y number|nil Y coordinate.
--- @param z number|nil Z coordinate.
--- @return table This transform.
--- @usage
--- thisObject.transform:setPosition(0, 0, 0)
function Transform:setPosition(x, y, z)
    self.position.x = x or self.position.x
    self.position.y = y or self.position.y
    self.position.z = z or self.position.z

    return self
end

--- Sets the provided scale axes; omitted (`nil`) axes remain unchanged.
--- @param x number|nil Horizontal scale.
--- @param y number|nil Vertical scale.
--- @return table This transform.
--- @usage
--- thisObject.transform:setScale(2, 2)
function Transform:setScale(x, y)
    self.scale.x = x or self.scale.x
    self.scale.y = y or self.scale.y

    return self
end

--- Adds the provided offsets to the current position; omitted offsets default to zero.
--- @param x number|nil Horizontal offset.
--- @param y number|nil Vertical offset.
--- @param z number|nil Depth offset.
--- @return table This transform.
--- @usage
--- thisObject.transform:translate(0, 0, 0)
function Transform:translate(x, y, z)
    self.position.x = self.position.x + (x or 0)
    self.position.y = self.position.y + (y or 0)
    self.position.z = self.position.z + (z or 0)

    return self
end

return Transform