--- UI component that draws an image or a colored placeholder on a canvas.
--- @module components_ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image

local RenderTask = require("systems.renderer.m2d_render_task")
local ImagesBank = require("banks.images.m2d_images_bank")

--- Creates an enabled image component with a white tint.
--- @param gameObject table Game object that owns this component.
--- @return table The new Image component.
--- @usage local image = gameObject:addComponent("Image")
function Image:new(gameObject)
    self = setmetatable({}, Image)

    self.enabled = true
    self.name = "Image"
    self.gameObject = gameObject
    self:setColor(255, 255, 255, nil)
    self.imageWidth = 400
    self.imageHeight = 240
    self.pivot = 0
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform.position.z,
        execute = function() return self:render() end
    })

    return self
end

--- Adds this image to a canvas, removing it from the previous canvas if set.
--- @param canvas table Canvas on which to render this image.
--- @return table This image component.
--- @usage
--- image:setCanvas(canvas)
function Image:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

--- Loads an image from the image bank and updates its dimensions.
--- @param imgPath string Path or bank ID accepted by the image bank.
--- @return table This image component.
--- @usage
--- image:setImage(imgPath)
function Image:setImage(imgPath)
    self.image = ImagesBank.loadImage(imgPath)
    self.imagePath = imgPath
    self.imageWidth = Graphics.getImageWidth(self.image)
    self.imageHeight = Graphics.getImageHeight(self.image)
    return self
end

--- Sets the image tint; alpha defaults to 255 when omitted.
--- @param r number Red color channel.
--- @param g number Green color channel.
--- @param b number Blue color channel.
--- @param a number|nil Alpha channel, defaulting to 255.
--- @return table This image component.
--- @usage
--- image:setColor(r, g, b, a)
function Image:setColor(r, g, b, a)
    if a == nil then a = 255 end
	self.color = Color.new(r, g, b, a)

	return self
end

--- Unloads the image and removes this component from its canvas on scene switch.
function Image:destroy()
    ImagesBank.unloadImage(self.imagePath)
    self.canvas:delElement(self)
    self.gameObject = nil
    self.renderTask = nil
    self.enabled = nil
    self = nil
end

--- Draws the image or its placeholder; invoked by the renderer's registered render task.
function Image:render()
    if not self.enabled then return end
    if not self.canvas.enabled then return end
    if not self.gameObject.enabled then return end

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    local pivotX = self.imageWidth * self.pivot
    local pivotY = self.imageHeight * self.pivot

    if self.image then
        Graphics.drawImageExtended(position.x + pivotX, position.y + pivotY, 0, 0, self.imageWidth, self.imageHeight,
            self.gameObject.transform.rotation,
            self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.image, self.color)
    else
        Graphics.fillRect(position.x, position.x + self.imageWidth, position.y, position.y + self.imageHeight, self.color)
    end
end

return Image