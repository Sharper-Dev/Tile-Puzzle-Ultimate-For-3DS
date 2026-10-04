--- Base component providing script lifecycle hooks.
--- @module components_script
--- @author Sharper Dev

local Script = {}
Script.__index = Script
------
--- Creates an enabled script component.
--- @return table The new Script component.
--- @usage local script = gameObject:addComponent("Script")
function Script:new()
    self = setmetatable({}, Script)
    self.name = "Script"
    self.enabled = true
    return self
end

--- Clears the script's enabled state and lifecycle hooks when destroyed.
function Script:destroy()
    self.enabled = nil
    self.start = nil
    self.update = nil
    self = nil
end
------
--- Lifecycle hook for one-time initialization when the component starts.
--- @usage
--- function script:start()
---     -- Code here
--- end
Script.start = function() end

--- Lifecycle hook called each frame.
--- @usage
--- function script:update()
---     -- Code here
--- end
Script.update = function() end

return Script