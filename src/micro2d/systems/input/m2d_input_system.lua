--- Reads controller state and exposes button, touch, and motion input queries.
--- @module systems_input
--- @author Sharper Dev

local InputSystem = {}
local InputSettings = require("systems.input.m2d_input_settings")

local previousInput = 0
local currentInput = 0

local downButtons = 0
local upButtons = 0

--- Reading Buttons
--- @section reading_buttons

--- Reads the inputs from the controls and updates the input state.
-- 
--- This function should be called or it won't update the input state.
--
--- It is previously called every frame in the Core Runtime loop.
--- @local
function InputSystem.readInputs()
    previousInput = currentInput
    currentInput = Controls.read()

    local updated = previousInput ~ currentInput
    downButtons = updated & currentInput
    upButtons = updated & previousInput
end

------
--- Gets the raw input as a bitmask.
--- @return integer bitmask representing the current input state.
--- @usage local rawInput = InputSystem.getRawInput()
function InputSystem.getRawInput()
    return currentInput
end

------
--- Checks whether the key is held in the current input state.
--- @param key integer Button bitmask to check.
--- @return boolean `true` when the key is held.
--- @usage local isPressed = InputSystem.getKey(KEY_A)
function InputSystem.getKey(key)
    return Controls.check(currentInput, key)
end

--- Checks whether the key changed from released to pressed this frame.
--- @param key integer Button bitmask to check.
--- @return boolean `true` when the key was pressed this frame.
--- @usage local isDown = InputSystem.getKeyDown(KEY_A)
function InputSystem.getKeyDown(key)
    return Controls.check(downButtons, key)
end

--- Checks whether the key changed from pressed to released this frame.
--- @param key integer Button bitmask to check.
--- @return boolean `true` when the key was released this frame.
--- @usage local isUp = InputSystem.getKeyUp(KEY_A)
function InputSystem.getKeyUp(key)
    return Controls.check(upButtons, key)
end

--- Reading Pads
--- @section circle_pad

------
--- Returns the Circle Pad axes after applying the configured per-axis dead zone.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @usage local x, y = InputSystem.getCirclePad()
function InputSystem.getCirclePad()
    local x, y = Controls.readCirclePad()
    local deadZone = InputSettings.getCirclePadDeadZone()
    x = (math.abs(x) > deadZone) and x or 0
    y = (math.abs(y) > deadZone) and y or 0
    return x, y
end

------
--- Returns the C-Stick axes after applying the configured per-axis dead zone.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @usage local x, y = InputSystem.getCstick()
function InputSystem.getCstick()
    local x, y = Controls.readCstickPad()
    local deadZone = InputSettings.getCStickDeadZone()
    x = (math.abs(x) > deadZone) and x or 0
    y = (math.abs(y) > deadZone) and y or 0
    return x, y
end

--- Reading Touch
--- @section reading_touch

------
--- Returns the current touch coordinates from the controls module.
--- @return integer x-coordinate.
--- @return integer y-coordinate.
--- @usage local x, y = InputSystem.getTouch()
function InputSystem.getTouch()
	return Controls.readTouch()
end

--- Reading Tilting
--- @section reading_tilting

------
--- Returns the current gyroscope readings.
--- @return integer x-axis reading.
--- @return integer y-axis reading.
--- @return integer z-axis reading.
--- @usage local x, y, z = InputSystem.getGyro()
function InputSystem.getGyro()
	return Controls.readGyro()
end

------
--- Returns the current accelerometer readings.
--- @return integer x-axis reading.
--- @return integer y-axis reading.
--- @return integer z-axis reading.
--- @usage local x, y, z = InputSystem.getAccel()
function InputSystem.getAccel()
	return Controls.readAccel()
end

return InputSystem