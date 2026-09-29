--- Manages images for the Micro2D engine.
--
--- The ImagesBank stores loaded images and provides methods to load and unload them. Preventing duplicate loading of the same image.
--- @module bank_images
--- @author Sharper Dev

local ImagesBank = {}

local loadedImages = {}

--- Loads an image from the given path, caching it and tracking its users.
--- Each call must be paired with an unloadImage call.
--- @param path string The path to the image file.
--- @return image_id The loaded image.
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

--- Releases one user's reference to the image at the given path.
--- Frees the image when its last user unloads it.
--- @param path string The path to the image file.
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