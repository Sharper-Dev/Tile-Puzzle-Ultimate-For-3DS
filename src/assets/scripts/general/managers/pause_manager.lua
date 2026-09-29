local Manager = {}

local isPaused = false
local canPause = true
function Manager.setPause(value)
    if not canPause then return end
    isPaused = value
    Manager.pausePanelBottom:setVisible(value)
    Manager.pausePanelTop:setVisible(value)
end

function Manager.setCanPause(value)
    canPause = value
end

function Manager.isPaused()
	return isPaused
end

return Manager