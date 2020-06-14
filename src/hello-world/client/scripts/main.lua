-- Teverse automatically runs the 'main.lua' file

print("Hello World!")
print("I'm from a tevapp")

teverse.construct("guiGradientFrame", {
    backgroundColour = colour.rgb(84, 209, 117),
    backgroundColourB = colour.rgb(25, 105, 46),
    start = guiCoord(0, 0, 0, 0),
    finish = guiCoord(1, 0, 1, 0),
    parent = teverse.interface,
    position = guiCoord(0.0, 0, 0.0, 0),
    size = guiCoord(1.0, 0, 1.0, 0)
})

teverse.construct("guiTextBox", {
    parent = teverse.interface,
    size = guiCoord(0, 150, 0, 50),
    position = guiCoord(0.5, -75, 0.5, -25),
    text = "Hello, I'm an app!",
    textAlign = "middle",
    strokeRadius = 4,
    zIndex = 2
})