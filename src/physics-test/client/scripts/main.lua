teverse.scene.simulate = true

local light = teverse.construct("directionalLight", {
    rotation = quaternion.euler(math.rad(-45), math.rad(20), 0),
    colour = colour(5, 5, 5)
})

local base = teverse.construct("block", {
    position = vector3(0, -10, 0),
    scale = vector3(30, 1, 30),
    colour = colour(1, 1, 1)
})

local offset = false
for y = -9, -3, 0.5 do
    local xo = 0
    offset = not offset
    if offset then
        xo = 0.75
    end
    for x = -7, 7, 1.5 do
        local block = teverse.construct("block", {
            scale = vector3(1.5, 0.5, 0.7),
            position = vector3(x + xo, y, 0),
            colour = colour.random(),
            static = false
        })
    end
end

teverse.input:on("mouseLeftDown", function()
    local block = teverse.construct("block", {
        scale = vector3(1.2, 1.2, 1.2),
        position = teverse.scene.camera.position,
        colour = colour.random(),
        rotation = quaternion.euler(math.random(), math.random(), math.random()),
        static = false
    })
    block:applyImpulse((teverse.scene.camera.position - teverse.scene.camera:screenToWorld(teverse.input.mousePosition)) * -1000)
end)

teverse.scene.camera.position = vector3(0, 1, -20)
teverse.scene.camera.rotation = quaternion.euler(math.rad(25), 0, 0)