--- Stores a scene's game objects and provides scene lifecycle operations.
--- @module systems_scenes_scene
--- @author Sharper Dev

local Scene = {}
Scene.__index = Scene

--- Creates a scene with an empty game-object list.
--- @param name string Scene name.
--- @return Scene The new scene.
--- @usage local scene = Scene:new("my_scene")
function Scene:new(name)
    self = setmetatable({}, Scene)
    self.gameObjects = {}
    self.name = name
    return self
end

--- Adds a game object, assigns its scene and list index, and returns it.
--- @param gameObject GameObject Object to add.
--- @return GameObject The added object.
--- @usage local addedObject = scene:addGameObject(gameObject)
function Scene:addGameObject(gameObject)
    table.insert(self.gameObjects, gameObject)
    gameObject.scene = self
    gameObject.index = #self.gameObjects

    return gameObject
end

--- Disables every game object in preparation for unloading.
function Scene:setupUnload()
    for i = 1, #self.gameObjects do
        self.gameObjects[i].enabled = false
    end
end

--- Destroys all game objects and clears the scene's object and component references.
--- Called when the scene transitions to another scene.
function Scene:unload()
    for i = 1, #self.gameObjects do
        self.gameObjects[i]:destroy()
    end
    for i = 1, #self.gameObjects do
        for j = 1, #self.gameObjects[i].components do
            setmetatable(self.gameObjects[i].components[j], nil)
            self.gameObjects[i].components[j] = nil
        end
        setmetatable(self.gameObjects[i], nil)
        self.gameObjects[i] = nil
    end
    self.gameObjects = nil
	self = nil
end
return Scene