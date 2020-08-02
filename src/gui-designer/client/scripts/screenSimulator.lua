local screenSimulator = {}

local screen = teverse.interface:child("screen")
local interface = screen:child("interface")
local scale = 1.0

screenSimulator.screens = {
    ["iPhone X"] = {
        screenSize = vector2(375, 812),
        safeAreaSize = vector2(375, 734),
        safeAreaOffset = vector2(0, 44)
    },
    ["iPad Air"] = {
        screenSize = vector2(768, 1024),
        safeAreaSize = vector2(768, 1000),
        safeAreaOffset = vector2(0, 24)
    }
}

local selectorUi = teverse.construct("guiFrame", {
    size = guiCoord(1, 0, 1, 0),
    parent = teverse.interface,
    zIndex = 15,
    backgroundColour = colour.rgb(0, 0, 0),
    backgroundAlpha = 0.8,
    visible = false
})

local modal = teverse.construct("guiFrame", {
    size = guiCoord(0, 300, 0, 200),
    position = guiCoord(0.5, -150, 0.5, -100),
    parent = selectorUi,
    strokeRadius = 3
})

local animating = false
local y = 10

local btn = teverse.construct("guiTextBox", {
    size = guiCoord(1, -20, 0, 20),
    position = guiCoord(0, 10, 0, y),
    parent = modal,
    text = "Default",
    textSize = 18,
    dropShadowAlpha = 0.1
})

y = y + 30

btn:on("mouseLeftUp", function()
    selectorUi.visible = false
    
    teverse.tween:begin(screen, 0.5, {
        size = guiCoord(1, -170, 1, -70),
        position = guiCoord(0, 0, 0, 40)
    }, "inOutQuad")

    teverse.tween:begin(interface, 0.5, {
        size = guiCoord(1, 0, 1, 0),
        position = guiCoord(0, 0, 0, 0),
        backgroundAlpha = 0.2
    }, "inOutQuad")

    sleep(0.6)

    teverse.tween:begin(interface, 0.4, {
        backgroundAlpha = 0
    }, "outQuad")

    sleep(0.4)

    animating = false
end)

for device, v in pairs(screenSimulator.screens) do

    local btn = teverse.construct("guiTextBox", {
        size = guiCoord(1, -20, 0, 20),
        position = guiCoord(0, 10, 0, y),
        parent = modal,
        text = device,
        textSize = 18,
        dropShadowAlpha = 0.1
    })

    btn:on("mouseLeftUp", function()
        selectorUi.visible = false
        
        teverse.tween:begin(screen, 0.5, {
            position = guiCoord(0.5, (-v.screenSize.x * scale * 0.5) - 85, 0.5, -v.screenSize.y * scale * 0.5),
            size = guiCoord(0, v.screenSize.x * scale, 0, v.screenSize.y * scale)
        }, "inOutQuad")

        teverse.tween:begin(interface, 0.5, {
            position = guiCoord(0, v.safeAreaOffset.x * scale, 0, v.safeAreaOffset.y * scale),
            size = guiCoord(0, v.safeAreaSize.x * scale, 0, v.safeAreaSize.y * scale),
            backgroundAlpha = 0.2
        }, "inOutQuad")

        sleep(0.6)

        teverse.tween:begin(interface, 0.4, {
            backgroundAlpha = 0
        }, "outQuad")

        sleep(0.4)

        animating = false
    end)

    y = y + 30
end

screenSimulator.options = function()
    if animating then return end

    require("scripts/manipulator.lua").setActive(nil)
    animating = true
    selectorUi.visible = true
end

teverse.input:on("keyUp", function(key)
    if key == "KEY_SPACE" then
        screenSimulator.options()
    end
end)

return screenSimulator