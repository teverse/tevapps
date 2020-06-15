-- Main entry point for the app
local container, editor = require("scripts/editor.lua").create()
local theme = require("scripts/theme/default.lua")

local run = teverse.construct("guiTextBox", {
    parent = teverse.interface,
    size = guiCoord(0, 100, 0, 50),
    position = guiCoord(1, -100, 0, 0),
    text = "RUN",
    backgroundColour = theme.highlighted,
    textColour = theme.foreground,
    textSize = 32,
    textFont = "tevurl:fonts/firaCodeBold.otf",
    textAlign = "middle",
    zIndex = 2
})

run:on("mouseLeftUp", function ()
    pcall(loadstring(editor.text))
end)