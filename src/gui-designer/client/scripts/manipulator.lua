local manipulator = {}
local extensions = require("scripts/extensions.lua")

manipulator.active = nil
manipulator.stepSize = 5
manipulator.useRelative = false

local screen = teverse.construct("guiFrame", {
    parent = teverse.interface,
    size = guiCoord(1, -170, 1, -70),
    position = guiCoord(0, 0, 0, 40),
    backgroundAlpha = 0,
    strokeAlpha = 0.4,
    strokeColour = colour.rgb(255, 0, 0),
    clip = true,
    strokeColour = colour(1, 0, 1),
    strokeWidth = 2,
    name = "screen"
})

local interface = teverse.construct("guiFrame", {
    parent = screen,
    name = "interface",
    size = guiCoord(1, 0, 1, 0),
    position = guiCoord(0, 0, 0, 0),
    backgroundAlpha = 0,
    backgroundColour = colour.rgb(255, 0, 0)
})

local bottomBar = teverse.construct("guiFrame", {
    parent = teverse.interface,
    size = guiCoord(1, 0, 0, 18),
    position = guiCoord(0, 0, 1, -18),
    backgroundColour = colour.rgb(0, 0, 0)
})

local bottomText = teverse.construct("guiTextBox", {
    parent = bottomBar,
    size = guiCoord(1, -20, 1, 0),
    position = guiCoord(0, 10, 0, 0),
    backgroundAlpha = 0,
    textSize = 14,
    text = "",
    textColour = colour.rgb(255, 255, 255)
})

local handles = teverse.construct("guiFrame", {
    parent = teverse.interface,
    zIndex = 2,
    visible = false,
    backgroundAlpha = 0
})

teverse.construct("guiFrame", {
    parent = handles,
    backgroundAlpha = 0,
    strokeColour = colour.rgb(255, 0, 255),
    strokeAlpha = 1.0,
    size = guiCoord(1.0, -10, 1.0, -10),
    position = guiCoord(0, 5, 0, 5),
    active = false
})

local function updateHandles()
    if manipulator.active and manipulator.active.alive then
        handles.visible = true
        handles.size = guiCoord(0, manipulator.active.absoluteSize.x + 10, 0, manipulator.active.absoluteSize.y + 10)

        handles.position = guiCoord(0, manipulator.active.absolutePosition.x - 5, 0, manipulator.active.absolutePosition.y - 5)

        bottomText.text = "position = " .. tostring(manipulator.active.position) .. ", size = " .. tostring(manipulator.active.size)
    else
        handles.visible = false
        bottomText.text = "Nothing selected"
    end
end

handles:on("mouseLeftDown", function()
    local start = teverse.input.mousePosition
    local startPos = manipulator.active.position

    while teverse.input:isMouseButtonDown(1) do
        local offset = (teverse.input.mousePosition-start)

        offset = extensions.nearest(offset, manipulator.stepSize)

        manipulator.active.position = startPos + guiCoord(0, offset.x, 0, offset.y)

        updateHandles()
        sleep()
    end
end)

for x = 0, 1, 0.5 do
    for y = 0, 1, 0.5 do
        if not (x == 0.5 and y == 0.5) then
            local xo = -5
            local yo = -5
            if x == 0 then xo = 0 end
            if x == 1 then xo = -10 end
            if y == 0 then yo = 0 end
            if y == 1 then yo = -10 end

            local handle = teverse.construct("guiFrame", {
                parent = handles,
                strokeAlpha = 1.0,
                size = guiCoord(0, 10, 0, 10),
                position = guiCoord(x, xo, y, yo)
            })

            local mouseDown = false
            handle:on("mouseEnter", function()
                handle.backgroundColour = colour(1, 0, 0)
            end)

            handle:on("mouseExit", function()
                if not mouseDown then
                    handle.backgroundColour = colour(1, 1, 1)
                end
            end)

            handle:on("mouseLeftDown", function()
                mouseDown = true
                handle.backgroundColour = colour(1, 0, 0)
                local start = teverse.input.mousePosition
                local startSize = manipulator.active.size
                local startPos = manipulator.active.position
                local xFactor, yFactor = (xo + 5)/-5, (yo + 5)/-5

                while teverse.input:isMouseButtonDown(1) do
                    local offset = (teverse.input.mousePosition-start) * vector2(xFactor, yFactor)

                    offset = extensions.nearest(offset, manipulator.stepSize)

                    manipulator.active.size = startSize + guiCoord(0, offset.x, 0, offset.y)

                    manipulator.active.position = startPos + 
                    guiCoord(0, 
                        xFactor < 0 and -offset.x or 0, 
                        0, 
                        yFactor < 0 and -offset.y or 0)

                    updateHandles()
                    sleep()
                end
                mouseDown = false
                bottomText.text = ""
                handle.backgroundColour = colour(1, 1, 1)
            end)
        end
    end
end

manipulator.setActive = function(new)
    manipulator.active = new

    updateHandles()
end

local guiClicked = function()
    manipulator.setActive(self)
end

manipulator.insert = function(className)
    local new = teverse.construct(className, { 
        parent = interface
    })
    
    manipulator.setActive(new)
    new:on("mouseLeftUp", guiClicked)
end

return manipulator