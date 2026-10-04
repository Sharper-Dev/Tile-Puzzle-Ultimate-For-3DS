--- Component that renders an image or colored rectangle in world space.
--- @module components_sprite
--- @author Sharper Dev

local Sprite = {}
Sprite.__index = Sprite

local RenderTask = require("systems.renderer.m2d_render_task")
local Renderer = require("systems.renderer.m2d_renderer")
local ImagesBank = require("banks.images.m2d_images_bank")

--- Creates an enabled sprite component with a white tint.
--- @param gameObject table Game object that owns this component.
--- @return table The new Sprite component.
function Sprite:new(gameObject)
    self = setmetatable({}, Sprite)

    self.enabled = true
    self.name = "Sprite"
    self.gameObject = gameObject
    self.imageWidth = 128
    self.imageHeight = 128
    self:setColor(255, 255, 255, nil)
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform.position.z,
        execute = function() return self:render() end
    })

    return self
end

--- Registers this sprite's render task on the given screen in world space.
--- @param screen number Screen on which to render the sprite.
--- @return table This sprite component.
--- @usage sprite:setScreen(TOP_SCREEN) 
function Sprite:setScreen(screen)
    if self.screen == screen then return self end
    if self.screen ~= nil then
        Renderer.unregisterRenderTask(self.renderTask, self.screen, Renderer.SPACES.WORLD)
    end
    Renderer.registerRenderTask(self.renderTask, screen, Renderer.SPACES.WORLD)
    self.screen = screen
    return self
end

--- Sets the sprite tint; alpha defaults to 255 when omitted.
--- @param r number Red color channel.
--- @param g number Green color channel.
--- @param b number Blue color channel.
--- @param a number|nil Alpha channel, defaulting to 255.
--- @return table This sprite component.
--- @usage sprite:setColor(255, 0, 0)
function Sprite:setColor(r, g, b, a)
    if a == nil then a = 255 end
    self.color = Color.new(r, g, b, a)

    return self
end

--- Loads the sprite image and updates the component's dimensions.
--- @param imgPath string Path or bank ID accepted by the image bank.
--- @return table This sprite component.
--- @usage sprite:setSprite("sprites/player.png")
function Sprite:setSprite(imgPath)
    self.sprite = ImagesBank.loadImage(imgPath)
    self.spritePath = imgPath
    self.imageWidth = Graphics.getImageWidth(self.sprite)
    self.imageHeight = Graphics.getImageHeight(self.sprite)

    return self
end

--- Destroys the sprite component.
--
-- 
--- Unregisters the render task; called automatically when the scene switches.
function Sprite:destroy()
    Renderer.unregisterRenderTask(self.renderTask, self.screen, Renderer.SPACES.WORLD)
    self.gameObject = nil
    self.renderTask = nil
    self.enabled = nil
    self = nil
end

--- Draws the sprite or its colored placeholder when invoked by the renderer.
function Sprite:render()
    if not self.enabled then return end

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    if self.sprite then
        Graphics.drawImageExtended(position.x, position.y, 0, 0, self.imageWidth, self.imageHeight,
            self.gameObject.transform.rotation,
            self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.sprite, self.color)
    else
        Graphics.fillRect(position.x, position.x + self.imageWidth, position.y, position.y + self.imageHeight, self.color)
    end
end

return Sprite