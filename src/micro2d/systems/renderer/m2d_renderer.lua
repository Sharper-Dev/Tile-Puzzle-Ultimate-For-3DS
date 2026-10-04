--- Queues and draws render tasks by screen, coordinate space, and layer.
--- @module systems_renderer
--- @author Sharper Dev

local Renderer = {}
Renderer.SPACES = {
    WORLD = 1,
    SCREEN = 2
}

local worldTopTasks = {}
local screenTopTasks = {}

local worldBottomTasks = {}
local screenBottomTasks = {}

local tasksPointer = {
    [TOP_SCREEN] = {
        [Renderer.SPACES.WORLD] = worldTopTasks,
        [Renderer.SPACES.SCREEN] = screenTopTasks
    },
    [BOTTOM_SCREEN] = {
        [Renderer.SPACES.WORLD] = worldBottomTasks,
        [Renderer.SPACES.SCREEN] = screenBottomTasks
    }
}

--- Sorts one render queue by layer.
--- @param screen integer Screen whose queue is sorted.
--- @param space integer Render space whose queue is sorted.
--- @private
local function sortTasks(screen, space)
    local tasksTable = tasksPointer[screen][space]

    table.sort(tasksTable, function(a, b) return a.layer < b.layer end)
end

--- Resorts a queue when a task's layer has changed.
--- @param screen integer Screen whose queue is checked.
--- @param space integer Render space whose queue is checked.
--- @private
local function checkLayers(screen, space)
    local tasksTable = tasksPointer[screen][space]
    local hasToSort = false
    for i = 1, #tasksTable do
        if tasksTable[i].previousLayer ~= tasksTable[i].layer then
            tasksTable[i].previousLayer = tasksTable[i].layer
            hasToSort = true
        end
    end
    if hasToSort then
        sortTasks(screen, space)
    end
end
--- Adds a render task to the given screen's task queue.
--- @param task table Render task with `layer` and `execute` fields.
--- @param screen integer Screen constant (`TOP_SCREEN` or `BOTTOM_SCREEN`).
--- @param space integer Coordinate space: `Renderer.SPACES.WORLD` or `Renderer.SPACES.SCREEN`.
--- @usage Renderer.registerRenderTask(task, TOP_SCREEN, Renderer.SPACES.WORLD)
function Renderer.registerRenderTask(task, screen, space)
    local tasksTable = tasksPointer[screen][space]
    for i = 1, #tasksTable do
        if tasksTable[i].layer > task.layer then
            table.insert(tasksTable, i, task)
            return
        end
    end

    table.insert(tasksTable, task)
end

--- Removes a render task from the given screen's task queue.
--- @param task table Render task to remove.
--- @param screen integer Screen constant (`TOP_SCREEN` or `BOTTOM_SCREEN`).
--- @param space integer Coordinate space: `Renderer.SPACES.WORLD` or `Renderer.SPACES.SCREEN`.
--- @usage Renderer.unregisterRenderTask(task, TOP_SCREEN, Renderer.SPACES.WORLD)
function Renderer.unregisterRenderTask(task, screen, space)
    local tasksTable = tasksPointer[screen][space]
    for i = #tasksTable, 1, -1 do
        if tasksTable[i] == task then
            table.remove(tasksTable, i)
            return
        end
    end
end

--- Draws the top screen's world-space tasks, then screen-space tasks.
--- The core runtime calls this function automatically.
function Renderer.drawTop()
    checkLayers(TOP_SCREEN, Renderer.SPACES.WORLD)
    checkLayers(TOP_SCREEN, Renderer.SPACES.SCREEN)

    local topTasks = tasksPointer[TOP_SCREEN][Renderer.SPACES.WORLD]

    Graphics.initBlend(TOP_SCREEN)

    for i = 1, #topTasks do
        topTasks[i].execute()
    end

    topTasks = tasksPointer[TOP_SCREEN][Renderer.SPACES.SCREEN]

    for i = 1, #topTasks do
        topTasks[i].execute()
    end 

    Graphics.termBlend()
end

--- Draws the bottom screen's world-space tasks, then screen-space tasks.
--- The core runtime calls this function automatically.
function Renderer.drawBottom()
    checkLayers(BOTTOM_SCREEN, Renderer.SPACES.WORLD)
    checkLayers(BOTTOM_SCREEN, Renderer.SPACES.SCREEN)

    local bottomTasks = tasksPointer[BOTTOM_SCREEN][Renderer.SPACES.WORLD]

    Graphics.initBlend(BOTTOM_SCREEN)

    for i = 1, #bottomTasks do
        bottomTasks[i].execute()
    end

    bottomTasks = tasksPointer[BOTTOM_SCREEN][Renderer.SPACES.SCREEN]

    for i = 1, #bottomTasks do
        bottomTasks[i].execute()
    end

    Graphics.termBlend()
end

return Renderer