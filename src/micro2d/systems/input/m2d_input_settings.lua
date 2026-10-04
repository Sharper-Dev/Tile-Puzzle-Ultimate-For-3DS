--- Configures input dead zones and motion-control state.
--- @module systems_input_settings
--- @author Sharper Dev

local InputSettings = {}
local circlePadDeadZone = 20
local cStickDeadZone = 20

--- Circle Pad
--- @section circle_pad

------
--- Sets the per-axis dead-zone threshold for the Circle Pad.
--
--- The default value is 20.
--- @param value integer The dead zone value.
--- @usage InputSettings.setCirclePadDeadZone(10)
function InputSettings.setCirclePadDeadZone(value)
    circlePadDeadZone = value
end

--- Returns the configured Circle Pad dead-zone threshold.
-- 
--- The default value is 20.
--- @return integer The dead zone value.
--- @usage local deadZone = InputSettings.getCirclePadDeadZone()
function InputSettings.getCirclePadDeadZone()
    return circlePadDeadZone
end

--- C-Stick
--- @section c_stick

--- Sets the per-axis dead-zone threshold for the C-Stick.
--- @param value integer The dead zone value.
--- @usage InputSettings.setCStickDeadZone(10)
function InputSettings.setCStickDeadZone(value)
    cStickDeadZone = value
end

--- Returns the configured C-Stick dead-zone threshold.
--- @return integer The dead zone value.
--- @usage local deadZone = InputSettings.getCStickDeadZone()
function InputSettings.getCStickDeadZone()
    return cStickDeadZone
end

--- Tilting
--- @section tilting

------
--- Enables or disables both the gyroscope and accelerometer.
--- @param state boolean Whether to enable or disable the controls.
--- @usage InputSettings.setTiltingState(true)
function InputSettings.setTiltingState(state)
    if state then
        Controls.enableGyro(state)
        Controls.enableAccel(state)
    else
        Controls.disableGyro(state)
        Controls.disableAccel(state)
    end
end

return InputSettings