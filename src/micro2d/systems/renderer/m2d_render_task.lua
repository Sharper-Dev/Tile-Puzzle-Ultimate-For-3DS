--- Defines render tasks with a layer and an execution callback.
--- @module systems_rendertask
--- @author Sharper Dev

local RenderTask = {}
RenderTask.__index = RenderTask
--- Creates a render task. The callback is invoked when the task is drawn.
--- @param params table Task options: optional `layer` number (defaults to `0`) and `execute` function.
--- @return RenderTask The created task.
--- @usage
--- local task = RenderTask:new({
---     layer = 0,
--- execute = function()
---     -- Render code here    
--- end })
function RenderTask:new(params)
    self = setmetatable({}, RenderTask)
    self.layer = params.layer or 0
    self.previousLayer = self.layer
    self.execute = params.execute

    return self
end

return RenderTask