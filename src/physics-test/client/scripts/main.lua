teverse.scene.simulate = true
teverse.scene.camera.position = vector3(0, 1, -10)
teverse.scene.camera.rotation = quaternion.euler(math.rad(25), 0, 0)

local light = teverse.construct("directionalLight", {
    rotation = quaternion.euler(math.rad(-45), math.rad(20), 0),
    colour = colour(5, 5, 5)
})

local base = teverse.construct("block", {
    position = vector3(0, -10, 0),
    scale = vector3(30, 1, 30),
    colour = colour(1, 1, 1),
    linearFactor = vector3(0, 0, 0),
    angularFactor = vector3(0, 1, 0),
    static = false
})
spawn(function()
    while sleep(1) do
        base:applyTorqueImpulse(vector3(0, 1000, 0))
    end
end)
local offset = false
for y = -9, -4, 0.5 do
    local xo = 0
    offset = not offset
    if offset then
        xo = 0.75
    end

    for x = -7, 7, 1.5 do
        local rnd = math.random()/4
        local block = teverse.construct("block", {
            name = "brick",
            scale = vector3(1.5, 0.5, 0.9),
            position = vector3(x + xo, y-0.25, 0),
            colour = colour(rnd + 0.3, rnd + 0.7, rnd + 0.3),
            static = false
        })
    end
    sleep()

    for z = -7, 0, 1.5 do
        local rnd = math.random()/4
        local block = teverse.construct("block", {
            name = "brick",
            scale = vector3(1.5, 0.5, 0.9),
            rotation = quaternion.euler(0, math.rad(90), 0),
            position = vector3(-7.5, y-0.25, 8.15 + z - xo),
            colour = colour(rnd + 0.3, rnd + 0.7, rnd + 0.3),
            static = false
        })
    end

    sleep()
end

local reset = teverse.construct("guiTextBox", {
    parent = teverse.interface,
    size = guiCoord(0, 120, 0, 24),
    position = guiCoord(0, 10, 0, 10),
    backgroundAlpha = 0,
    text = "Reset Wall [R]",
    textSize = 20,
    textColour = colour(1, 1, 1)
})


local function resetWall()
    if not reset.visible then return end
    reset.visible = false

    local bricks = {}
    for _,v in pairs(teverse.scene.children) do
        if v.name == "brick" then
            table.insert(bricks, v)
            if v.position.y > -10 then
                v:applyImpulse(vector3(math.random(-1, 1),math.random(5, 15),math.random(-1,1)))
                sleep()
            end
        end
    end
    
    local brickI = 0
    for y = -9, -4, 0.5 do
        local xo = 0
        offset = not offset
        if offset then
            xo = 0.75
        end
    
        for x = -7, 7, 1.5 do
            brickI = brickI + 1
            local brick = bricks[brickI]
            brick.static = true
            brick.colour = brick.colour * 0.5
            teverse.tween:begin(brick, .6, {
                position = vector3(x + xo, y-0.25, 0),
                -- scale = vector3(1.5, 0.5, 0.9),
                rotation=quaternion(0,0,0,1)
            }, "inOutQuad")
        end
    
        for z = -7, 0, 1.5 do
            brickI = brickI + 1
            local brick = bricks[brickI]
            brick.static = true
            brick.colour = brick.colour * 0.5
            teverse.tween:begin(brick, .6, {
                --scale = vector3(0.9, 0.5, 1.5),
                position = vector3(-7.5, y-0.25, 8.15 + z - xo),
                rotation=quaternion.euler(0, math.rad(90), 0)
            }, "inOutQuad")
        end
        sleep()
    end
    sleep(0.5)
    base.angularVelocity = vector3(0, 0, 0)
    for _,v in pairs(bricks) do
        v.static = false
        v.colour = v.colour * 2
        sleep()
    end
    sleep(1)
    reset.visible = true
end

local dbg = teverse.construct("guiTextBox", {
    parent = teverse.interface,
    size = guiCoord(0, 200, 0, 50),
    position = guiCoord(0, 10, 0, 40),
    backgroundAlpha = 0,
    text = "",
    textSize = 20,
    textColour = colour(1, 1, 1)
})

teverse.input:on("mouseLeftDown", function()
    dbg.text = tostring(os.clock())
    local block = teverse.construct("block", {
        name = "projectile",
        scale = vector3(1.2, 1.2, 1.2),
        position = teverse.scene.camera.position,
        colour = colour.random(),
        rotation = quaternion.euler(math.random(), math.random(), math.random()),
        mesh = "tevurl:3d/sphere2.glb",
        static = false
    })
    block:applyImpulse(teverse.scene.camera:screenToWorld(teverse.input.mousePosition) * 1000)
end)

reset:on("mouseLeftDown", function ()
    resetWall()
end)

teverse.input:on("keyUp", function(key)
    if key == "KEY_R" then
        resetWall()
    end
end)