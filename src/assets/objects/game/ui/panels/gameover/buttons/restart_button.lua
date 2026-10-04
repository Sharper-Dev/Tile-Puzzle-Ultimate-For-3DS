local SceneTransitionButton = require("scripts.builders.scene_transition_button_builder")

return SceneTransitionButton.buildButton(
    "restart_button_gameover",
    "Restart",
    { x = 40, y = 23 },
    { x = 90, y = 60, z = 3 },
    2
)
