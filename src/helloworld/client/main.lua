-- Teverse automatically runs the 'main.lua' file

print("Hello World!")
print("I'm from a tevapp!")

teverse.construct("guiTextBox", {
    size = guiCoord(0, 100, 0, 50),
    position = guiCoord(0.5, -50, 0.5, -25),
    text = "Hello, I'm an app!"
})