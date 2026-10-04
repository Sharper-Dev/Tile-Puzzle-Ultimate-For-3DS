local MenuPanelButton = require("scripts.builders.menu_panel_button_builder")

return MenuPanelButton.buildButton(
    "credits_button",
    "Credits",
    { x = 45, y = 23 },
    { x = 90, y = 94, z = 1 },
    true
)
