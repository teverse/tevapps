local uiController = require("scripts/uiController.lua")
uiController.createInterface()

local function onChat(sender, message)
    print("onchat", sender, message)
    uiController.addMessage(sender, "image", message)
end

teverse.networking:on("chat", onChat)

teverse.networking:on("_clientConnected", function(client)
    uiController.addClient(client.name)
end)

teverse.networking:on("_clientDisconnected", function(client)
    uiController.removeClient(client.name)
end)