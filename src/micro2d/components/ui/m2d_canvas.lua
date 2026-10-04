--- Canvas that groups UI elements and registers their render tasks on a screen.
--- @module components_ui_canvas
--- @author Sharper Dev

local Canvas = {}
Canvas.__index = Canvas

local Renderer = require("systems.renderer.m2d_renderer")

--- Creates a canvas on the top screen and assigns it to its game object.
--- @param gameObject table Game object that owns the canvas.
--- @return table The new Canvas instance.
function Canvas:new(gameObject)
    self = setmetatable({}, Canvas)
    self.screen = TOP_SCREEN
    self.enabled = true
    self.gameObject = gameObject
    self.gameObject.canvas = self
    self.elements = {}

    return self
end

--- Moves the canvas elements' render tasks to another screen.
--- @param screen number Destination screen, such as `BOTTOM_SCREEN`.
--- @usage
--- canvas:switchScreen(BOTTOM_SCREEN)
function Canvas:switchScreen(screen)
    if self.screen == screen then return end

    for i = 1, #self.elements do
        if self.elements[i].renderTask ~= nil then
            Renderer.unregisterRenderTask(self.elements[i].renderTask, self.screen, Renderer.SPACES.SCREEN)
            Renderer.registerRenderTask(self.elements[i].renderTask, screen, Renderer.SPACES.SCREEN)
        end
    end
    self.screen = screen
end

--- Engine internal functions
--- @section engine_internal

--- Adds an element and registers its render task on this canvas's screen when present.
--- @param element table UI element to add.
--- @usage
--- canvas:addElement(image)
function Canvas:addElement(element)
    table.insert(self.elements, element)
    if element.renderTask ~= nil then
        Renderer.registerRenderTask(element.renderTask, self.screen, Renderer.SPACES.SCREEN)
    end
end
--- Removes the first matching element and unregisters its render task when present.
--- @param element table UI element to remove.
--- @usage
--- canvas:delElement(image)
function Canvas:delElement(element)
	for i, e in ipairs(self.elements or {}) do
		if e == element then
            table.remove(self.elements, i)
            if element.renderTask ~= nil then
                Renderer.unregisterRenderTask(element.renderTask, self.screen, Renderer.SPACES.SCREEN)
            end
			return
		end
	end
end

--- Removes all elements and clears the canvas reference on its game object.
function Canvas:destroy()
    for i = #self.elements, 1, -1 do
        self:delElement(self.elements[i])
    end
    self.gameObject.canvas = nil
    self.gameObject = nil
    self = nil
end

return Canvas