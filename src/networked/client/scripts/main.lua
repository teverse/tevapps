print("Hello Client!")

local uiController = require("scripts/uiController.lua")
uiController.createInterface()

local function onChat(sender, message)
    local client = teverse.networking:getClient(sender)
    uiController.addMessage(client and client.name or sender, client ~= nil and ("https://cdn.teverse.com/user/" .. client.id) or "test", message)
end

teverse.networking:on("chat", onChat)

teverse.networking:on("_clientConnected", function(client)
    uiController.addClient(client.name)
end)

teverse.networking:on("_clientDisconnected", function(client)
    uiController.removeClient(client.name)
end)

teverse.networking:on("_disconnected", function(client)
    uiController.addMessage("Server", "", "You have lost connection to the server, you won't be able to communicate!")
end)

teverse.networking:on("_connected", function(client)
    uiController.addMessage("Server", "", "You have connected to the server")
end)

-- Keep showing the loading UI until we're connected
while not teverse.networking.isConnected do
    sleep(0.5)
end
uiController.loading:destroy()

local dbg = teverse.construct("guiTextBox", {
    parent = teverse.interface,
    size = guiCoord(0, 200, 0, 250),
    position = guiCoord(1, -210, 1, -260),
    backgroundAlpha = 0,
    textSize = 12,
    textColour = colour(1, 0, 0),
    textWrap = true,
    textFont = "tevurl:fonts/firaCodeRegular.otf",
    textAlign = "topLeft"
})

while sleep(0.7) do
    local stats = teverse.networking:getStats()
    dbg.text = "Packet loss (1s): " .. tonumber(stats.packetlossLastSecond) .. "\n"
        .. "Packet loss (total):" .. tonumber(stats.packetlossTotal) .. "\n"
        .. "Processed (total):" .. tonumber(stats.totalMessageBytesReceivedProcessed) .. "\n"
        .. "Ignored (total):" .. tonumber(stats.totalMessageBytesReceivedIgnored) .. "\n"
        .. "Send buffer:" .. tonumber(stats.bytesInSendBuffer) .. "\n"
end