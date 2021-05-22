print("Hello Server!")

local function getListsOfMentions(message)
    local listOfMentions = {}
    
    for _, name in string.gmatch(message, "@(%w)") do
        local client = teverse.networking:getClient(name)
        if client then
            listOfMentions[client] = true
        end
    end
    
    return listOfMentions
end

teverse.networking:on("chat", function(client, message)
    -- Never 'trust' input from a user, we'll perform some simple validation here:
    if type(message) ~= "string" then
        return
    end

    if string.len(message) < 1 or string.len(message) > 200 then
        return
    end
  
    --The message has been filtered so, we can do things now.
    local mentions = getListOfMentions(message)
    
    teverse.networking:broadcast("chat", client.id, message, mentions)
end)

teverse.networking:on("_clientConnected", function(client)
    teverse.networking:broadcast("chat", "Server", client.name .. " joined the chat", {})
end)

teverse.networking:on("_clientDisconnected", function(client)
    teverse.networking:broadcast("chat", "Server", client.name .. " left the chat", {})
end)
