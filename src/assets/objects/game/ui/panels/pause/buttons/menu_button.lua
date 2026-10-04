local SceneTransitionButton = require("scripts.builders.scene_transition_button_builder")

return SceneTransitionButton.buildButton(
    "menu_button",
    "Menu",
    { x = 62, y = 23 },
    { x = 90, y = 150, z = 3 },
    1
)
