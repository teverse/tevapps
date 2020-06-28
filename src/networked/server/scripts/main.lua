print("server main.lua!!")

teverse.networking:on("chat", function(client, message)
    -- Never 'trust' input from a user, we'll perform some simple validation here:
    if type(message) ~= "string" then
        return
    end

    if string.len(message) < 1 or string.len(message) > 200 then
        return
    end

    teverse.networking:broadcast("chat", client.id, message)
end)

teverse.networking:on("_clientConnected", function(client)
    teverse.networking:broadcast("chat", "Server", client.name .. " joined the chat")
end)

teverse.networking:on("_clientDisconnected", function(client)
    teverse.networking:broadcast("chat", "Server", client.name .. " left the chat")
end)