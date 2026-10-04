--- The UI Text component to display text on the canvas.
--- @module components_ui_text
--- @author Sharper Dev
local Text = {}
Text.__index = Text

local RenderTask = require("systems.renderer.m2d_render_task")
local FontsBank = require("banks.fonts.m2d_fonts_bank")
local utf8 = require("utf8")

--- The Text Constructor
--- @param gameObject The game object this component is attached to.
function Text:new(gameObject)
    self = setmetatable({}, Text)

    self.enabled = true
    self.name = "Text"
    self.gameObject = gameObject
    self.size = { w = 0, h = 0 }
    self.cursorOffset = { x = 0, y = 0 }
    self:setContent("")
    self:setFont("default")
    self.color = Color.new(255, 255, 255)
    self.lineBreakDistance = 20
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform.position.z,
        execute = function() return self:render() end
    })

    return self
end

--- Sets the canvas for this text component.
--- @param canvas The canvas to set.
--- @return The text component itself.
--- @usage myText:setCanvas(canvas)
function Text:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

--- Sets the content of this text component.
--- @param content The content to set.
--- @usage myText:setContent("Hello, World!")
function Text:setContent(content)
    self.content = content
    self.contentLines = {}

    for line in content:gmatch("[^\r\n]+") do
        table.insert(self.contentLines, line)
    end
    return self
end

--- Returns the content of this text component.
--- @return The content of this text component.
--- @usage local content = myText:getContent()
function Text:getContent()
    return self.content
end

--- Sets the font of this text component.
--- @param fontID The font ID to set.
--- @usage myText:setFont("ComicSans")
function Text:setFont(fontID)
    self.fontID = fontID
    return self
end

--- Sets the line break distance of this text component.
--- @param value The line break distance to set.
--- @usage myText:setLineBreakDistance(10)
function Text:setLineBreakDistance(value)
    self.lineBreakDistance = value
    return self
end

--- Internal function to render the text.
function Text:render()
    if not self.enabled then return end
    if not self.canvas.enabled then return end
    if not self.gameObject.enabled then return end

    local transform = self.gameObject.transform
    local position = transform.position
    local cursorX = position.x + self.cursorOffset.x
    local cursorY = position.y + self.cursorOffset.y
    local font = FontsBank.getFont(self.fontID)
    self.renderTask.layer = position.z

    for _, lineContent in ipairs(self.contentLines) do
        for _, code in utf8.codes(lineContent) do
            local charInfo = font.data.chars[code]
            if charInfo then
                Graphics.drawImageExtended(cursorX + charInfo.xoffset,
                    math.floor(cursorY) + charInfo.yoffset * transform.scale.y,
                    charInfo.x, charInfo.y, charInfo.width, charInfo.height,
                    transform.rotation, transform.scale.x, transform.scale.y, font.sheet)

                cursorX = cursorX + charInfo.xadvance * transform.scale.x
            end
        end

        cursorY = cursorY + self.lineBreakDistance
        cursorX = position.x
    end
end

--- Destroys this text component.
function Text:destroy()
    self.canvas:delElement(self)
    self = nil
end

return Text