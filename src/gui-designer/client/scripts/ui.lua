local manipulator = require("scripts/manipulator.lua")
local screenSimulator = require("scripts/screenSimulator.lua")

local actions = {
    "guiFrame",
    "guiTextBox"
}

local function insert()
    manipulator.insert(self.name)
end

local topbar = teverse.construct("guiFrame", {
    parent = teverse.interface,
    size = guiCoord(1.0, 0, 0.0, 40),
    position = guiCoord(0.0, 0, 0.0, 0), 
    backgroundColour = colour.rgb(205, 205, 210),
    zIndex = 3
})

local x = 10
local function addBtn(name, icon, onClick)
    local button = teverse.construct("guiFrame", {
        size = guiCoord(0, 80, 0, 20),
        position = guiCoord(0, x, 0, 10),
        parent = topbar,
        backgroundColour = colour.rgb(52, 58, 64),
        backgroundAlpha = 1.0,
        name = name
    })

    button:on("mouseLeftUp", onClick)

    local icon = teverse.construct("guiIcon", {
        parent = button,
        size = guiCoord(0, 20, 0, 20),
        iconId = icon,
        iconType = "faSolid",
        iconMax = 12,
        backgroundAlpha = 0.15,
        backgroundColour = colour.rgb(255, 255, 255),
        active = false
    })

    local text = teverse.construct("guiTextBox", {
        parent = button,
        size = guiCoord(1, -20, 1, 0),
        position = guiCoord(0, 20, 0, 0),
        backgroundAlpha = 0,
        text = name,
        textAlign = "middle",
        textColour = colour.rgb(255, 255, 255),
        textSize = 16,
        textFont = "tevurl:fonts/openSansBold.ttf",
        active = false
    })

    button.size = guiCoord(0, text.textDimensions.x + 30, 0, 20)
    x = x + button.size.offset.x + 10
end

addBtn("Screen Size", "cogs", screenSimulator.options)

for i, v in pairs(actions) do
    addBtn(v, "plus-circle", insert)
end

local sidebar = teverse.construct("guiFrame", {
    parent = teverse.interface,
    size = guiCoord(0, 200, 1, -40),
    position = guiCoord(1, -200, 0, 40), 
    backgroundColour = colour.rgb(195, 195, 200),
    zIndex = 3
})
