--- Loads and caches images by path, freeing each image after its last release.
--- @module bank_images
--- @author Sharper Dev

local ImagesBank = {}

local loadedImages = {}

--- Loads an image or increments its reference count if it is already cached.
--- Pair each call with `unloadImage` using the same path.
--- @param path string Path to the image file.
--- @return image_id The loaded image handle.
--- @usage local image = ImagesBank.loadImage("romfs:/images/player.png")
function ImagesBank.loadImage(path)
    local entry = loadedImages[path]
    if entry then
        entry.users = entry.users + 1
        return entry.image
    end

    local image = Graphics.loadImage(path)
    loadedImages[path] = {
        image = image,
        users = 1
    }
    return image
end

--- Releases one reference to the image and frees it when the count reaches zero.
--- Does nothing if the path is not cached.
--- @param path string Path used to load the image.
--- @usage ImagesBank.unloadImage("romfs:/images/player.png")
function ImagesBank.unloadImage(path)
    local entry = loadedImages[path]
    if not entry then return end

    entry.users = entry.users - 1
    if entry.users == 0 then
        Graphics.freeImage(entry.image)
        loadedImages[path] = nil
    end
end

return ImagesBank