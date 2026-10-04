--- Renders a selected cell from a sprite sheet.
--- @see components_sprite
--- @module components_multisprite
--- @author Sharper Dev

local Sprite = require("components.sprite.m2d_sprite")

local MultiSprite = {}
setmetatable(MultiSprite, { __index = Sprite })
MultiSprite.__index = MultiSprite

--- Creates a MultiSprite with a 16×16 cell size and cursor at (0, 0).
--- @param gameObject table Game object that owns this component.
--- @return table The new MultiSprite component.
--- @usage local multi = gameObject:addComponent("MultiSprite")
function MultiSprite:new(gameObject)
    self = Sprite.new(self, gameObject)
    setmetatable(self, MultiSprite)
    self.name = "MultiSprite"

    --- The size of each cell in the sprite sheet.
    --- @field x integer The width of each cell.
    --- @field y integer The height of each cell.
    self.cellSize = { x = 16, y = 16 }

    --- The current cell cursor position.
    --- @field x integer The x position of the cell cursor.
    --- @field y integer The y position of the cell cursor.
    self.cellCursor = { x = 0, y = 0 }

    return self
end

--- Draws the selected sprite-sheet cell when the component is enabled.
function MultiSprite:render()
    if not self.enabled then return end

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    local cellX = self.cellCursor.x * self.cellSize.x
    local cellY = self.cellCursor.y * self.cellSize.y

    if self.sprite then
        Graphics.drawImageExtended(position.x, position.y, cellX, cellY, self.cellSize.x, self.cellSize.y,
            self.gameObject.transform.rotation,
            self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.sprite, self.color)
    else
        Graphics.fillRect(position.x, position.x + self.imageWidth, position.y, position.y + self.imageHeight, self
        .color)
    end
end

return MultiSprite