print("Hello Server!")
teverse.scene.simulate = true

local baseplate = teverse.construct("block", {
    position = vector3(0, 0, 0),
    scale = vector3(6, 0.1, 6),
    colour = colour(1, 1, 1)
})

local block = teverse.construct("block", {
    position = vector3(0, 5, 0),
    scale = vector3(1, 1, 1),
    colour = colour(1, 0, 1),
    static = false
})

while sleep(4) do
    block.position = vector3(0, 5, 0)
end