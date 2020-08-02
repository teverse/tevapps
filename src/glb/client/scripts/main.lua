teverse.scene.camera.position = vector3(0, -130, 100)
teverse.scene.camera:lookAt(vector3(0, -130, 0))

local rot = teverse.scene.camera.rotation
local light = teverse.construct("directionalLight", {
    rotation = quaternion.euler(math.rad(120), 0, 0),
    colour = colour(5, 5, 5)
})

local block = teverse.construct("block", {
    position = vector3(0, 0, 0),
    scale = vector3(1,1,1),
    colour = colour(1, 1, 1),
    mesh = "fs:meshes/ybotdance2.glb",
    scale = vector3(1, 1, 1) 
})

local camera = require("tevgit:core/3d/camera.lua") -- 3D Camera for 3D Environment
block.scale = block.meshScale
