teverse.scene.camera.position = vector3(6.65, 3.33, 2.90)
teverse.scene.camera:lookAt(vector3(0, 0, 0))

local light = teverse.construct("directionalLight", {
    rotation = quaternion.euler(math.rad(-45), math.rad(20), 0),
    colour = colour(5, 5, 5)
})

local block = teverse.construct("block", {
    position = vector3(4, 0, 0),
    scale = vector3(1,1,1),
    colour = colour(1, 1, 1),
    mesh = "fs:meshes/ybotdance2.glb",
    rotation = quaternion.euler(0, math.rad(90), 0),
    scale = vector3(1, 1, 1) 
})
local camera = require("tevgit:core/3d/camera.lua") -- 3D Camera for 3D Environment
block.scale = block.meshScale * 0.2
print(block.scale)
