--- Base component providing script lifecycle hooks.
--- @module components_script
--- @author Sharper Dev

local Script = {}
Script.__index = Script
------
--- Creates an enabled script component.
--- @return table The new Script component.
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
--- Override this method; it is invoked by the owning lifecycle, not by `Script:new`.
--- @usage
--- local GameObject = require("gameobject.m2d_gameobject")
---
--- local thisObject = GameObject:new("Name here")
--- local script = thisObject:addComponent("Script", {})
--- 
--- function script:start()
---     -- Start code here
--- end
Script.start = function() end

--- Lifecycle hook for per-frame updates.
--- Override this method to update the object's state; the lifecycle calls it each frame.
--- @usage
--- local GameObject = require("gameobject.m2d_gameobject")
---
--- local thisObject = GameObject:new("Name here")
--- local script = thisObject:addComponent("Script", {})
--- 
--- function script:update()
---     -- Update code here
--- end
Script.update = function() end

return Script