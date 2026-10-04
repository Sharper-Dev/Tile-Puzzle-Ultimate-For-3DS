--- The Time module.
--- @module time
--- @author Sharper Dev

local Time = {}

--- Duration of the most recently completed runtime frame, in seconds.
--- Updated by Time.update(); initially zero.
Time.deltaTime = 0
local deltaTimeTimer

--- Starts the frame timer and resets deltaTime to zero.
--- @usage Time.init()
function Time.init()
    deltaTimeTimer = Timer.new()
    Time.deltaTime = 0
end

--- Stores elapsed time since the previous update in deltaTime, in seconds.
--- @usage Time.update()
function Time.update()
    Time.deltaTime = Timer.getTime(deltaTimeTimer) / 1000
    Timer.reset(deltaTimeTimer)
end

return Time