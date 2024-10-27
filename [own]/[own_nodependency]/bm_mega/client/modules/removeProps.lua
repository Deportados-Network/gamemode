local props = {
    [73386408] = true,
    [-44941044] = true,
    [-1152174184] = true,
    [-1425071302] = true,
    [1104171198] = true,
    [-1881825907] = true,
    [-1045015371] = true,
    [-1679881977] = true,
    [-495720969] = true,
    [-222270721] = true,
    [746855201] = true,
    [1215477734] = true,
    [2121050683] = true,
    [-1591004109] = true,
    [-131754413] = true,
    [852936996] = true,
    [1347919902] = true,
    [1585070778] = true,
    [-1738361206] = true,
    [1834101966] = true,
    [-1071525272] = true
}

CreateThread(function()
    while true do

        for i,v in pairs(GetGamePool("CObject")) do
            if (props[GetEntityModel(v)]) then
                SetEntityAsMissionEntity(v, true, true)
                DeleteEntity(v)
            end
        end

        Wait(2000)
    end
end)