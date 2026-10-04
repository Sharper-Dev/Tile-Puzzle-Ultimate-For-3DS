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

--- Clears startup artifacts by briefly drawing black to both screens.
--- @private
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

--- Terminates graphics and audio, then exits to the HOME Menu.
--- @usage CoreRuntime.endRuntime()
function CoreRuntime.endRuntime()
    Graphics.term()
    SoundsBank.cleanup()
    Sound.term()
    System.exit()
end

--- Unloads scenes queued for removal.
--- @private
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

--- Queues a scene for unloading during the runtime loop.
--- @param scene Scene Scene to unload.
--- @usage CoreRuntime.requestUnload(scene)
function CoreRuntime.requestUnload(scene)
    table.insert(scenesToUnload, scene)
end

------
--- Initializes graphics, audio, time tracking, and the initial scenes.
--- @usage CoreRuntime._start()
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
--- Processes one runtime frame: input, collisions, component updates, and rendering.
--- @usage CoreRuntime._loop()
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