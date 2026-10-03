--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}

local InputSystem = require("systems.input.m2d_input_system")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local SoundsBank = require("banks.sounds.m2d_sounds_bank")

local Renderer = require("systems.renderer.m2d_renderer")
local Debugger = require("debugger.m2d_debugger")
local Time = require("time.m2d_time")

local scenesToUnload = {}

--- Pre-clean the screen by filling it with black.
--
--- When the application starts, this is called to clear the top screen.
--
--- Sometimes when the application starts, the first frame may be a weird texture artifact and this helps to clear it.
local function preClean()
    local sceneTimer = Timer.new()

    Controls.disableScreen(TOP_SCREEN) -- I can't show these artifacts :D
    Controls.disableScreen(BOTTOM_SCREEN)

    for _ = 1, 2 do
        Graphics.initBlend(TOP_SCREEN)
        Graphics.fillRect(0, 400, 0, 240, Color.new(0, 0, 0))
        Graphics.termBlend()

        Graphics.initBlend(BOTTOM_SCREEN)
        Graphics.fillRect(0, 320, 0, 240, Color.new(0, 0, 0))
        Graphics.termBlend()

        Graphics.flip()
    end

    while Timer.getTime(sceneTimer) < 1000 do
        -- Wait
    end
    Timer.destroy(sceneTimer)
    Controls.enableScreen(TOP_SCREEN)
    Controls.enableScreen(BOTTOM_SCREEN)
end

--- Ends runtime and returns to HOME Menu.
function CoreRuntime.endRuntime()
    Graphics.term()
    SoundsBank.cleanup()
    Sound.term()
    System.exit()
end

--- Internal function to check and unload scenes to unload.
local function checkScenesToUnload()
    for i = #scenesToUnload, 1, -1 do
        local scene = scenesToUnload[i]
        scene:unload()
        table.remove(scenesToUnload, i)
        ScenesSystem.removeSceneFromTable(1)
        Debugger.debugObject(nil)
        ScenesSystem.startReadyScenes()
    end
end

--- Internal function to request unload of a scene.
function CoreRuntime.requestUnload(scene)
    table.insert(scenesToUnload, scene)
end

------
--- Called when the game starts.
--- Initializes the graphics and loads the first scene.
function CoreRuntime._start()
    Graphics.init()
    preClean()
    Sound.init()
    Time.init()
    ScenesSystem.loadUniversalScene()
    ScenesSystem.loadScene(1)
    ScenesSystem.startReadyScenes()
end

------
--- Called after the game starts and then every frame.
--- Updates the input system, refreshes the screen, updates all components, and renders the active scenes.
function CoreRuntime._loop()
    InputSystem.readInputs()
    CollisionSystem.processCollisions()
    local activeScenes = ScenesSystem.getActiveScenes()
    local universalScene = ScenesSystem.getUniversalScene()
    for i = 1, #activeScenes do
        for j = 1, #activeScenes[i].gameObjects do
            activeScenes[i].gameObjects[j]:callUpdate()
        end
    end
    if universalScene then
        for j = 1, #universalScene.gameObjects do
            universalScene.gameObjects[j]:callUpdate()
        end
    end
    Debugger.update()
    Sound.updateStream()
    Renderer.drawTop()
    Renderer.drawBottom()
    Graphics.flip()

    if InputSystem.getKey(KEY_POWER) then
        CoreRuntime.endRuntime()
    end

    Time.update()
    checkScenesToUnload()
end

return CoreRuntime