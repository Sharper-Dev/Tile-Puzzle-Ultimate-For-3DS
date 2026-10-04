local GameObject = require("gameobject.m2d_gameobject")
local FontsBank = require("banks.fonts.m2d_fonts_bank")

local Builder = {}

function Builder.buildButton(name, content, img)
    local buttonObject = GameObject:new(name)
    FontsBank.loadFont("LTStudent", "romfs:/assets/fonts/ltstudent")
    FontsBank.loadFont("LTStudent_b", "romfs:/assets/fonts/ltstudent_bold")
    img = img or "romfs:/assets/sprites/buttons/button_large.png"
    local scriptComponent = buttonObject:addComponent("Script")
    buttonObject:addComponent("BoxCollider")
    local buttonComponent = buttonObject:addComponent("Button")
    local imageComponent = buttonObject:addComponent("Image")

    local textObject
    local textComponent

    scriptComponent.start = function()
        local canvasObject = GameObject.findByName("canvas")
        if content then
            textObject = GameObject.instantiate(GameObject:new(name .. "_text"), nil)
            textObject.transform:setPosition(buttonObject.transform.position.x + buttonObject.textOffset.x,
                buttonObject.transform.position.y + buttonObject.textOffset.y, buttonObject.transform.position.z + 1)
            textObject.transform:setScale(0.5, 0.5)
            textComponent = textObject:addComponent("Text")
            textComponent:setCanvas(canvasObject.canvas)
            textComponent:setContent(content)
            textComponent:setFont("LTStudent_b")
        end
        imageComponent:setImage(img)
        imageComponent.pivot = 0.5
        buttonComponent:setCanvas(canvasObject.canvas)
        buttonComponent:setImageComponent(imageComponent)
    end
    scriptComponent.update = function()
        if not textObject then return end
        textObject.transform:setPosition(buttonObject.transform.position.x + buttonObject.textOffset.x,
            buttonObject.transform.position.y + buttonObject.textOffset.y, buttonObject.transform.position.z + 1)
    end

    return buttonObject
end
return Builder