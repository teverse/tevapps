print("Hello Client!")

local uiController = require("scripts/uiController.lua")
uiController.createInterface()

local function onChat(sender, message)
    uiController.addMessage(sender, "image", message)
end

teverse.networking:on("chat", onChat)

teverse.networking:on("_clientConnected", function(client)
    uiController.addClient(client.name)
end)

teverse.networking:on("_clientDisconnected", function(client)
    uiController.removeClient(client.name)
end)

teverse.networking:on("_disconnected", function(client)
    uiController.addMessage("Server", "image", "You have lost connection to the server")
end)

teverse.networking:on("_connected", function(client)
    uiController.addMessage("Server", "image", "You have connected to the server")
end)

-- Keep showing the loading UI until we're connected
while not teverse.networking.isConnected do
    sleep(0.5)
end
uiController.loading:destroy()