--- The UI Canvas to display elements on the screen.
--- @module components_ui_canvas
--- @author Sharper Dev

local Canvas = {}
Canvas.__index = Canvas

local Renderer = require("systems.renderer.m2d_renderer")

--- The Canvas Constructor.
--- @param gameObject table The game object this canvas is attached to.
--- @return self canvas
function Canvas:new(gameObject)
    self = setmetatable({}, Canvas)
    self.screen = TOP_SCREEN
    self.enabled = true
    self.gameObject = gameObject
    self.gameObject.canvas = self
    self.elements = {}

    return self
end

--- Switches the screen of the canvas.
--- @param screen number
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

--- Adds an element to the canvas.
--- @param element table
--- @usage
--- canvas:addElement(image)
function Canvas:addElement(element)
    table.insert(self.elements, element)
    if element.renderTask ~= nil then
        Renderer.registerRenderTask(element.renderTask, self.screen, Renderer.SPACES.SCREEN)
    end
end
--- Removes an element from the canvas.
--- @param element table
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

function Canvas:destroy()
    for i = 1, #self.elements do
        Canvas:delElement(self.elements[i])
    end
    self.gameObject.canvas = nil
    self.gameObject = nil
    self = nil
end

return Canvas