--- The GameObject module.
--- @module gameobject
--- @author Sharper Dev

local GameObject = {}
GameObject.__index = GameObject

local Transform = require("components.transform.m2d_transform")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")

local componentsList = {
    ["Script"] = "components.script.m2d_script",
    ["Canvas"] = "components.ui.m2d_canvas",
    ["Image"] = "components.ui.m2d_image",
    ["Text"] = "components.ui.m2d_text",
    ["Sprite"] = "components.sprite.m2d_sprite",
    ["MultiSprite"] = "components.sprite.m2d_multisprite",
    ["Button"] = "components.ui.m2d_button",
    ["BoxCollider"] = "components.collider.m2d_box_collider",
    ["Draggable"] = "components.draggable.m2d_draggable"
}

--- Creates a GameObject with a transform and no components.
--- @param name string Name assigned to the new object.
--- @return GameObject object The created object.
--- @usage
--- local GameObject = require("gameobject.m2d_gameobject")
--- local obj = GameObject:new("MyObject")
function GameObject:new(name)
    self = setmetatable({}, GameObject)
    self.transform = Transform:new(self)
    self.enabled = true
    self.components = {}
    self.updateableComponents = {}
    self.name = name

    return self
end

--- Creates and attaches a component by its registered component name.
--- @param component string Registered component name, such as "Script" or "Sprite".
--- @return Component component The created component.
--- @usage
--- local obj = GameObject:new("MyObject")
--- obj:addComponent("Script")
function GameObject:addComponent(component)
    local comp = require(componentsList[component]):new(self)
    comp.gameObject = self
    table.insert(self.components, comp)
    if comp.update then
        table.insert(self.updateableComponents, comp)
    end
    return comp
end

--- Returns the first attached component whose name matches the argument.
--- @param componentName string Component name to look up.
--- @return Component|nil component Matching component, or nil if none is found.
--- @usage
--- local obj = GameObject:new("MyObject")
--- obj:addComponent("Script")
--- local script = obj:getComponent("Script")
function GameObject:getComponent(componentName)
    for i = 1, #self.components do
        local component = self.components[i]
        if component.name == componentName then
            return component
        end
    end
    return nil
end

--- Calls update on each enabled updateable component if this object is enabled.
--- @usage gameObject:callUpdate()
function GameObject:callUpdate()
    if not self.enabled then return end

	for i = 1, #self.updateableComponents do
		local component = self.updateableComponents[i]
		if component.enabled then
			component:update()
		end
	end
end

--- Adds a GameObject to the active scene, or to the universal scene when requested.
--- Accepts either a Lua file path to load with dofile or an existing GameObject.
--- @param gameObjectPath string|GameObject File path or GameObject instance to add.
--- @param isUniversal boolean|nil If true, add to the universal scene.
--- @return GameObject object The added object.
--- @usage
--- local obj = GameObject.instantiate("path/to/GameObject.lua")
function GameObject.instantiate(gameObjectPath, isUniversal)
    local scene = (isUniversal and ScenesSystem.getUniversalScene() or ScenesSystem.getActiveScenes()[1])

    local newObject

    if type(gameObjectPath) == "string" then
        newObject = scene:addGameObject(dofile(gameObjectPath))
        newObject.name = tostring(newObject)
    else
        newObject = scene:addGameObject(gameObjectPath)
    end

    for i = 1, #newObject.components do
        if newObject.components[i].start then
            newObject.components[i]:start()
        end
    end

    return newObject
end

--- Finds the first GameObject with this name in the first active scene.
--- @param name string Name to search for.
--- @return GameObject|nil object Matching object, or nil if none is found.
--- @usage
--- local obj = GameObject.findByName("MyObject")
function GameObject.findByName(name)
    for _, object in ipairs(ScenesSystem.getActiveScenes()[1].gameObjects) do
        if object.name == name then
            return object
        end
    end

    return nil
end

--- Finds the first GameObject with this name in the universal scene.
--- @param name string Name to search for.
--- @return GameObject|nil object Matching object, or nil if none is found.
--- @usage
--- local obj = GameObject.findByNameUniversal("MyObject")
function GameObject.findByNameUniversal(name)
    for _, object in ipairs(ScenesSystem.getUniversalScene().gameObjects) do
        if object.name == name then
            return object
        end
    end

    return nil
end

--- Disables the object, invokes its onDestroy hook, and destroys its components.
--- Clears the object's transform and updateable-component references.
--- @usage gameObject:destroy()
function GameObject:destroy()
    self.enabled = false

    if self.onDestroy then
        self:onDestroy()
    end

    for i = 1, #self.components do
        if self.components[i].destroy then
            self.components[i]:destroy()
        end
    end
    self.transform.gameObject = nil
    self.transform = nil
    self.enabled = nil
    self.updateableComponents = nil
    self = nil
end

return GameObject