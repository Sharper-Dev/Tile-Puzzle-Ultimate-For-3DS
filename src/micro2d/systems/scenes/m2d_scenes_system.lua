--- Loads, starts, and unloads configured game scenes.
--- @module systems_scenes
--- @author Sharper Dev

local ScenesSystem = {}
local activeScenes = {}
local readyScenes = {}

local universalScene

--- Loads the configured scene at the index, first requesting unload of active scenes.
--- @param sceneIndex integer Index into `M2D_SETTINGS.SCENES`.
--- @usage ScenesSystem.loadScene(1)
function ScenesSystem.loadScene(sceneIndex)
    for i, _ in ipairs(activeScenes) do
        ScenesSystem.unloadScene(i)
    end

    local scenePath = M2D_SETTINGS.SCENES[sceneIndex]
    local scene = dofile(scenePath)
    table.insert(activeScenes, scene)
    table.insert(readyScenes, scene)
end

--- Calls `start` on components in scenes loaded since the previous start pass.
--- @usage ScenesSystem.startReadyScenes()
function ScenesSystem.startReadyScenes()
    for i = 1, #readyScenes do
        local scene = readyScenes[i]
        for _, object in ipairs(scene.gameObjects) do
            for _, component in ipairs(object.components) do
                if component.start then
                    component:start()
                end
            end
        end
    end
    readyScenes = {}
end

--- Returns the universal scene loaded by `loadUniversalScene`.
--- @return Scene|nil Universal scene, or `nil` before it is loaded.
--- @usage local scene = ScenesSystem.getUniversalScene()
function ScenesSystem.getUniversalScene()
    return universalScene
end

--- Loads the engine's universal scene from its built-in asset path.
function ScenesSystem.loadUniversalScene()
	universalScene = dofile("romfs:/micro2d/assets/scenes/m2d_universal_scene.lua")
	for i = 1, #universalScene.gameObjects do
		local object = universalScene.gameObjects[i]
		for _, component in ipairs(object.components) do
			if component.start then
				component:start()
			end
		end
	end
end

--- Disables the indexed active scene and requests its runtime unload.
--- @param sceneIndex integer Index in the active-scenes list.
--- @usage ScenesSystem.unloadScene(1)
function ScenesSystem.unloadScene(sceneIndex)
    if activeScenes[sceneIndex] then
        local Runtime = require("core.m2d_core_runtime")
        activeScenes[sceneIndex]:setupUnload()
        Runtime.requestUnload(activeScenes[sceneIndex])
    end
    collectgarbage("collect")
end

--- Removes the scene at the index from the active-scenes list.
--- @param index integer Index in the active-scenes list.
--- @usage ScenesSystem.removeSceneFromTable(1)
function ScenesSystem.removeSceneFromTable(index)
    table.remove(activeScenes, index)
end

--- Returns the active-scenes list.
--- @return table Active scenes.
--- @usage local scenes = ScenesSystem.getActiveScenes()
function ScenesSystem.getActiveScenes()
    return activeScenes
end

return ScenesSystem