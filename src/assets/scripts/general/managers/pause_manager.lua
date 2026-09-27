local Manager = {}

local isPaused = false

function Manager.setPause(value)
    isPaused = value
    Manager.pausePanelBottom:setVisible(value)
    Manager.pausePanelTop:setVisible(value)
end

function Manager.isPaused()
	return isPaused
end

return Manager