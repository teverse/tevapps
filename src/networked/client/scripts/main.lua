print("Hello Client!")

local uiController = require("scripts/uiController.lua")
uiController.createInterface()

local function onChat(sender, message, mentions)
    mentions = mentions or {}
    local mentioned = mentions[teverse.localClient] == true
    
    local client = teverse.networking:getClient(sender)
    uiController.addMessage(client and client.name or sender, client ~= nil and ("https://cdn.teverse.com/user/" .. client.id) or "tevurl:img/info.png", message, mentioned)
end

teverse.networking:on("chat", onChat)

teverse.networking:on("_clientConnected", function(client)
    uiController.addClient(client.name)
end)

teverse.networking:on("_clientDisconnected", function(client)
    uiController.removeClient(client.name)
end)

teverse.networking:on("_disconnected", function(client)
    uiController.addMessage("Server", "tevurl:img/info.png", "You have lost connection to the server, you won't be able to communicate!")
end)

teverse.networking:on("_connected", function(client)
    uiController.addMessage("Server", "tevurl:img/info.png", "You have connected to the server")
end)

-- Load the networking debug UI from the teverse/teverse github
local debugContainer = require("tevgit:utilities/networkDebug.lua")()
debugContainer.parent = teverse.interface

-- Keep showing the loading UI until we're connected
while not teverse.networking.isConnected do
    sleep(0.5)
end
uiController.loading:destroy()
