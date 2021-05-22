local uiController = {}

uiController.createInterface = function ()

    -- Create right sidebar:
    uiController.playerList = teverse.construct("guiFrame", {
        parent = teverse.interface,
        size = guiCoord(0, 250, 1, 0),
        position = guiCoord(1, -250, 0, 0),
        backgroundColour = colour(0.96, 0.96, 0.96),
        strokeAlpha = 0.2
    })

    local main = teverse.construct("guiFrame", {
        parent = teverse.interface,
        size = guiCoord(1, -250, 1, 0),
        position = guiCoord(0, 0, 0, 0),
        backgroundColour = colour(1, 1, 1)
    })

    uiController.loading = teverse.construct("guiFrame", {
        parent = main,
        zIndex = 10,
        size = guiCoord(1, 0, 1, 0),
        backgroundColour = colour(0, 0, 0),
        backgroundAlpha = 0.8,
        zIndex = 10,
        name = "connectingInterface"
    })

    teverse.construct("guiTextBox", {
        parent = uiController.loading,
        size = guiCoord(0.5, 0, 0.5, 0),
        position = guiCoord(0.25, 0, 0.25, 0),
        text = "Waiting for a connection to the app",
        textAlign = "middle",
        textSize = 24,
        textColour = colour(1, 1, 1),
        textShadowSize = 2,
        backgroundAlpha = 0
    })

    -- Main Title
    teverse.construct("guiTextBox", {
        parent = main,
        size = guiCoord(1, -20, 0, 42),
        position = guiCoord(0, 10, 0, 10),
        text = "Chat",
        textSize = 42,
        textColour = colour(0, 0, 0)
    })

    uiController.scrollview = teverse.construct("guiScrollView", {
        parent = main,
        size = guiCoord(1, -20, 1, -122),
        position = guiCoord(0, 10, 0, 52),
        backgroundAlpha = 0,
        clip = true
    })

    local inputContainer = teverse.construct("guiFrame", {
        parent = main,
        size = guiCoord(1, -85, 0, 34),
        position = guiCoord(0, 20, 1, -62),
        strokeAlpha = 0.2,
        strokeRadius = 5,
        dropShadowAlpha = 0.1,
        dropShadowColour = colour(1, 0, 0)
    })

    local startText = "Type your message here..."
    local textInput = teverse.construct("guiTextBox", {
        parent = inputContainer,
        size = guiCoord(1, -20, 1, -10),
        position = guiCoord(0, 10, 0, 5),
        text = startText,
        textSize = 18,
        textColour = colour(0, 0, 0),
        textEditable = true
    })

    textInput:on("mouseLeftUp", function()
        if textInput.text == startText then
            textInput.text = ""
        end
    end)

    local submitBtn = teverse.construct("guiFrame", {
        parent = main,
        size = guiCoord(0, 34, 0, 34),
        position = guiCoord(1, -54, 1, -62),
        strokeRadius = 5,
        backgroundColour = colour.rgb(35, 145, 86),
        strokeAlpha = 0.2,
        strokeRadius = 5,
        dropShadowAlpha = 0.1,
        dropShadowColour = colour(1, 0, 0)
    })

    submitBtn:on("mouseEnter", function ()
        submitBtn.backgroundColour = colour.rgb(55, 165, 96)
    end)

    submitBtn:on("mouseExit", function ()
        submitBtn.backgroundColour = colour.rgb(35, 145, 86)
    end)

    teverse.construct("guiIcon", {
        parent = submitBtn,
        size = guiCoord(1, 0, 1, 0),
        iconType = "faSolid",
        iconId = "paper-plane",
        iconMax = 14,
        active = false
    })

    local function send()
        teverse.networking:sendToServer("chat", textInput.text)
        textInput.text = ""
    end

    submitBtn:on("mouseLeftUp", send)
    textInput:on("keyUp", function (keycode)
        if keycode == "KEY_RETURN" then
            send()
        end
    end)
end

local currentY = 10
uiController.addMessage = function(user, image, text, mentioned)
    local children = uiController.scrollview.children
    if #children >= 15 then
        local toKill = uiController.scrollview.children[1]
        local sizeY = toKill.absoluteSize.y
        for _,v in pairs(children) do
            v.position = v.position - guiCoord(0, 0, 0, sizeY + 10)
        end
        currentY = currentY - sizeY - 10
        toKill:destroy()
    end

    local message = teverse.construct("guiFrame", {
        parent = uiController.scrollview,
        size = guiCoord(1, -20, 0, 0),
        position = guiCoord(0, 10, 0, currentY),
        strokeAlpha = 0.2,
        strokeRadius = 5,
        dropShadowAlpha = 0.1,
        dropShadowColour = colour(1, 0, 0),
        backgroundColour = colour(1, 165/255, 0)
    })

    teverse.construct("guiTextBox", {
        parent = message,
        size = guiCoord(1, -60, 0, 22),
        position = guiCoord(0, 50, 0, 2),
        text = user,
        textSize = 18,
        textFont = "tevurl:fonts/openSansBold.ttf",
        textColour = colour(0, 0, 0),
        backgroundAlpha = 0;
    })

    local txt = teverse.construct("guiTextBox", {
        parent = message,
        size = guiCoord(1, -60, 1, -24),
        position = guiCoord(0, 50, 0, 20),
        text = text,
        textSize = 16,
        textColour = colour(0, 0, 0)
        backgroundAlpha = 0;
    })

    teverse.construct("guiImage", {
        parent = message,
        size = guiCoord(0, 40, 0, 40),
        position = guiCoord(0, 5, 0, 5),
        backgroundColour = colour(0.97, 0.97, 0.97),
        backgroundAlpha = 0,
        strokeRadius = 5,
        image = image
    })

    local height = math.max(50, txt.textDimensions.y + 24)
    message.size = guiCoord(1, -20, 0, height)
    currentY = currentY + height + 10
    uiController.scrollview.canvasOffset = vector2(0, currentY - uiController.scrollview.absoluteSize.y)
    uiController.scrollview.canvasSize = guiCoord(1, 0, 0, currentY)
end

uiController.addClient = function(clientName)
    local clientBtn = teverse.construct("guiTextBox", {
        parent = uiController.playerList,
        size = guiCoord(1, -20, 0, 22),
        textSize = 18,
        text = clientName,
        position = guiCoord(0, 10, 0, 0),
        name = clientName,
        backgroundAlpha = 0
    })
    
    for i,v in pairs(uiController.playerList.children) do
        v.position = guiCoord(0, 0, 0, i * 22)
    end
end

uiController.removeClient = function(clientName)
    local ui = uiController.playerList:child(clientName)
    if ui then
        ui:destroy()
    end
    
    for i,v in pairs(uiController.playerList.children) do
        v.position = guiCoord(0, 0, 0, i*22)
    end
end

return uiController
