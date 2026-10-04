--- Interactive UI button backed by a BoxCollider.
--- @module components_ui_button
--- @author Sharper Dev

local Button = {}
Button.__index = Button

--- Creates a button and binds its input handlers to the object's BoxCollider.
--- @param gameObject table Game object that owns the button and its BoxCollider.
--- @return table The new Button instance.
--- @usage local button = gameObject:addComponent("Button")
function Button:new(gameObject)
    self = setmetatable({}, Button)

    self.enabled = true
    self.name = "Button"
    self.gameObject = gameObject
    self.hasTouch = false
    self.collider = gameObject:getComponent("BoxCollider")
    if not self.collider then
        error("Cannot create button without a BoxCollider component")
    end
    self.collider.button = self
    self.collider.onTouchDown = function() self:onDown() end
    self.collider.onTouchClick = function() self:onClick() end
    self.collider.onTouchUp = function() self:onUp() end
    self:setSize(10, 10)
    return self
end

--- Per-frame update; keeps the assigned image positioned with the button.
function Button:update()
    if not self.enabled then return end

    if self.imageComponent then
        self.imageComponent.gameObject.transform:setPosition(self.gameObject.transform.position.x,
            self.gameObject.transform.position.y)
    end
end

--- Adds the button to a canvas, removing it from its previous canvas if present.
--- @param canvas table Canvas that will contain the button.
--- @return table This button.
--- @usage button:setCanvas(canvas)
function Button:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

--- Sets the size of the button.
--
--- It is necessary to calculate the collision box size.
--- @param width The width of the button.
--- @param height The height of the button.
--- @return The button instance.
--- @usage button:setSize(100, 50)
function Button:setSize(width, height)
    self.width = width
    self.height = height
    self.collider:setSize(width, height)

    return self
end

--- Sets the image component for the button.
--
--- When the button contains an image component, its size will be set to match the image dimensions.
--- @param imageComponent The image component to set.
--- @return The button instance.
--- @usage button:setImageComponent(imageComponent)
function Button:setImageComponent(imageComponent)
    self.imageComponent = imageComponent
    self:setSize(imageComponent.imageWidth, imageComponent.imageHeight)
    imageComponent:setCanvas(self.canvas)
    return self
end

--- Sets the text component for the button.
--- @param textComponent The text component to set.
--- @return The button instance.
--- @usage button:setTextComponent(textComponent)
function Button:setTextComponent(textComponent)
    self.textComponent = textComponent
    textComponent:setCanvas(self.canvas)
    return self
end

--- Destroys the button, removing it from the canvas and cleaning up resources.
--
--- It is called automatically when the scene changes.
function Button:destroy()
    self.canvas:delElement(self)
    self.collider.button = nil
    self.textComponent = nil
    self.imageComponent = nil
    self.gameObject = nil
    self.hasTouch = nil
    self = nil
end

--- Events
--- @section events

--- Override for the press event, triggered by the collider's touch-down callback.
--- @usage
--- function button.onDown()
---     -- Code here
--- end
function Button.onDown() end

--- Override for the held event; this method is not invoked by this component's update logic.
function Button.onHold() end

--- Override for the release event, triggered by the collider's touch-up callback.
--- @usage
--- function button.onUp()
---     -- Code here
--- end
function Button.onUp() end

--- Override for the click event, triggered by the collider's touch-click callback.
--- @usage
--- function button.onClick()
---     -- Code here
--- end
function Button.onClick() end

return Button