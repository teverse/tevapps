teverse.scene.camera.position = vector3(2, 1, 1)
teverse.scene.camera:lookAt(vector3(0, 0.6, 0))

local rot = teverse.scene.camera.rotation
local light = teverse.construct("directionalLight", {
    rotation = quaternion.euler(math.rad(-140), math.rad(-45), 0),
    colour = colour(5, 5, 5)
})

teverse.construct("block", {
    position = vector3(0, -1, 0),
    scale = vector3(100,0.2,100),
    colour = colour(0, 0, 1)
})

local man = teverse.construct("block", {
    position = vector3(0, 0, 0),
    scale = vector3(1,1,1),
    colour = colour(1, 1, 1),
    mesh = "fs:meshes/ybotdance2.glb",
    scale = vector3(1, 1, 1) 
})

local camera = require("tevgit:core/3d/camera.lua") -- 3D Camera for 3D Environment
man.scale = man.meshScale


local legJoint3 = man:getJoint("mixamorig:Spine2")
local start3 = legJoint3.rotation

while sleep(1) do
    teverse.tween:begin(legJoint3, 0.5, {
        rotation = legJoint3.rotation * quaternion.euler(math.rad(20), math.rad(24), math.rad(-82))
    }, "inOutQuad")


    sleep(1)

    teverse.tween:begin(legJoint3, 0.5, {
        rotation = start3
    }, "inOutQuad")

end