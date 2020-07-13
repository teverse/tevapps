teverse.scene.camera.position = vector3(0, 6, -6)
teverse.scene.camera.rotation = quaternion.euler(math.rad(35), 0, 0)

-- Load the networking debug UI from the teverse/teverse github
local debugContainer = require("tevgit:utilities/networkDebug.lua")()
debugContainer.parent = teverse.interface