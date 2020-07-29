teverse.scene.camera.position = vector3(0, 0, 3)
teverse.scene.camera:lookAt(vector3(0, 0, 0))

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
print(block.scale)


teverse.scene.camera.position = vector3(0, 1.2, 0.3)
teverse.tween:begin(teverse.scene.camera, 1, {
    position = vector3(0, 0.76, 0.3)
}, "inOutQuad")

sleep(1)

teverse.scene.camera.position = vector3(0.68, 0.53, 0.20)
teverse.scene.camera.rotation = teverse.scene.camera.rotation * quaternion.euler(0, 0, math.rad(90))
teverse.tween:begin(teverse.scene.camera, 1, {
    position = vector3(0.88, 0.53, 0.20)
}, "inOutQuad")

sleep(1)

teverse.scene.camera.position = vector3(0, 1.2, 0.3)
teverse.tween:begin(teverse.scene.camera, 1, {
    position = vector3(0, 0.76, 0.3)
}, "inOutQuad")

sleep(1)

teverse.scene.camera.position = vector3(0, 0, 1.5)
teverse.scene.camera.rotation = rot

teverse.tween:begin(teverse.scene.camera, 1, {
    position = vector3(0, 0, 2.0)
}, "inOutQuad")
