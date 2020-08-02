local extensions = {}

function extensions.round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function extensions.nearest(num, multipleOf)
    if type(num) == "number" then
        return extensions.round(num / multipleOf) * multipleOf
    elseif type(num, true) == "vector2" then
        return vector2(extensions.round(num.x / multipleOf) * multipleOf, extensions.round(num.y / multipleOf) * multipleOf)
    end
end

return extensions