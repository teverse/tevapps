print("server main.lua!!")

teverse.networking:on("customMessage", function(client, data1, data2)
    print("MSG from client:", client, data1, data2)
end)

while sleep(1) do
    teverse.networking:broadcast("customMessage", 10, 20)
end