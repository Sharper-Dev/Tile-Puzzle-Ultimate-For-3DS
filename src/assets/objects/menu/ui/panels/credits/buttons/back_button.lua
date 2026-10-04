local MenuPanelButton = require("scripts.builders.menu_panel_button_builder")

return MenuPanelButton.buildButton(
    "back_button",
    "Back",
    { x = 60, y = 23 },
    { x = 90, y = 174, z = 1 },
    false
)
