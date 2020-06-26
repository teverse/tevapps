print("client main.lua")

teverse.networking:on("customMessage", function(data1, data2)
    print("MSG from server:", data1, data2)
    teverse.networking:sendToServer("customMessage", "Hi from a client")
end)