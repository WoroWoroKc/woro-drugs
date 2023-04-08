local Main = {
    Action = false
}

Main.SetupScript = function(data)
    for i=1, #data do
        local drugsData = data[i]
        for i2=1, #drugsData.args.coords do
            local coords = drugsData.args.coords[i2]

            local args = drugsData.args
            args.coords = coords

            CreateActionKey('woro-drugs:'..i..':'..i2, vec3(coords.x, coords.y, coords.z), drugsData.args.size, {
                marker = drugsData.marker,
            }, {
                    eventName = 'woro-drugs:client:startAction',
                    isServerEvent = false,
                    args = args,
            }, {
                label = drugsData.label,
            })
        end
    end
end

Main.StartAction = function(data)
    if Main.Action == true then   
        return
    end
    
    if GlobalState.WoroDrugsPoliceOnline < data.police then
        return ESX.ShowNotification('Nie ma wystarczająco policji')
    end

    Main.Action = true
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, true)
    TaskStartScenarioAtPosition(playerPed, 'PROP_HUMAN_BUM_BIN', playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(playerPed), 0, true, true)
    
    local distance = #(vec3(playerCoords.x, playerCoords.y, playerCoords.z) - data.coords)
    while distance < data.size do
        Wait(data.tick)
        playerCoords = GetEntityCoords(playerPed, true)
        distance = #(playerCoords - data.coords)
        if distance < data.size then
            TriggerServerEvent('woro-drugs:client:giveItem', data)
        end
    end
    Main.Action = false
end

RegisterNetEvent('woro-drugs:client:startAction', Main.StartAction)
RegisterNetEvent('woro-drugs:client:setupScript', Main.SetupScript)