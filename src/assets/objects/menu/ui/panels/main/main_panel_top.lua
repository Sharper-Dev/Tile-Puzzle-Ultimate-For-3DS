local GameObject = require("gameobject.m2d_gameobject")
local FadeAnimation = require("scripts.general.animations.fade_animation")
local SoundSystem = require("systems.sound.m2d_sound_system")
local SoundsBank = require("banks.sounds.m2d_sounds_bank")

local thisObject = GameObject:new("main_panel_top")
local Script = thisObject:addComponent("Script")

local titleObject
local titleSprite

local function setPanelActive(active)
    titleObject.enabled = active
    titleSprite.enabled = active
end

function thisObject:setVisible(value)
	setPanelActive(value)
end

function Script.start()
    SoundSystem.playBgm("romfs:/assets/sounds/music/menu.ogg")
    titleObject = GameObject.findByName("top_title")
    titleSprite = titleObject:getComponent("Sprite")
    FadeAnimation.callFadeOut(0.2)
    thisObject.transform:setPosition(0, 0, 2)
    setPanelActive(true)
end

return thisObject