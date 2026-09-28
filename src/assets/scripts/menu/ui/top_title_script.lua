local Script = {}
local SineAnimation = require("scripts.general.animations.sine_animation")
local animation = SineAnimation.new({
    position = { x = 200, y = 120, z = 1 },
    amplitudeY = 5,
    frequency = 3,
})

function Script:start()
    animation:start(self)
    local Sprite = self:getComponent("Sprite")
    Sprite:setSprite("romfs:/assets/sprites/title/title.png")
    Sprite:setScreen(TOP_SCREEN)
end

function Script:update()
    animation:update(self)
end

return Script