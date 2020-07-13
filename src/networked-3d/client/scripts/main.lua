teverse.scene.camera.position = vector3(0, 2, -6)
teverse.scene.camera.rotation = quaternion.euler(math.rad(0), 0, 0)
teverse.scene.simulate = false

-- Load the networking debug UI from the teverse/teverse github
local debugContainer = require("tevgit:utilities/networkDebug.lua")()
debugContainer.parent = teverse.interface

-- Raycasting marker just for testing
local marker = teverse.construct("block", {
    position = vector3(0, 0, 0),
    scale = vector3(0.2, 0.2, 0.2),
    colour = colour(1, 1, 0),
    simulated = false
})

local camera = teverse.scene.camera
while sleep() do
    local mPos = camera:screenToWorld(teverse.input.mousePosition)
    local obj, pos, normal = teverse.scene:raycastOne(camera.position, camera.position + (mPos * 10000))
    if obj then
        marker.position = pos
    end
end