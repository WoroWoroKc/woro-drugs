local actionTable = {}

function CreateActionKey(index, coords, distance, config, event, textBox)
    local eventType = "client"
    local args = {}
    local textBoxLabel = "Kliknij ~b~E~s~"
    local inVehicle = false
    local job = {}
    local jobStatus = false

    local markerStatus = false
    local marker = {}

    if index == nil then
        print('"CreateActionKey" empty variable index!')
        return
    elseif coords == nil then
        print('"CreateActionKey" empty variable coords!')
        return
    elseif distance == nil then
        print('"CreateActionKey" empty variable distance!')
        return
    elseif config == nil then
        print('"CreateActionKey" empty table config!')
        return
    elseif event == nil then
        print('"CreateActionKey" empty table event!')
        return
    elseif event.eventName == nil then
        print('"CreateActionKey" empty table event variable eventName!')
        return 
    else

        if event.isServerEvent then
            eventType = "server"
        end

        if event.args ~= nil then
            args = event.args
        end

        if config.inVehicle then
            inVehicle = true
        end

        if config.job ~= nil then
            jobStatus = true
            job = config.job
        end

        if config.marker ~= nil then
            markerStatus = true
            marker = config.marker
        end

        if textBox ~= nil and textBox.label ~= nil then
            exports["bt-polyzone"]:AddBoxZone("woro-base:CreateActionKey:"..index, coords, distance, distance, {
                name = "woro-base:CreateActionKey:"..index,
                heading = 0,
                -- debugPoly = true,
                minZ = coords.z - distance,
                maxZ = coords.z + distance
            })

            textBoxLabel = textBox.label
        end

        for i=1, #actionTable do
            if actionTable[i].index == index then
                print('exports "CreateActionKey" index error')
                return
            end
        end

        if markerStatus then
            CreateThread(function()
                while true do
                    local _wait = 0

                    local PlayerPed = PlayerPedId()
                    local PlayerCoords = GetEntityCoords(PlayerPed)
                    local distance = #(PlayerCoords - coords)

                    if distance <= marker.distance then
                        DrawMarker(marker.type, coords.x, coords.y, coords.z - 0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, marker.scale, marker.scale, marker.scale, marker.color[1], marker.color[2], marker.color[3], marker.color[4])
                    else
                        _wait = 500
                    end

                    Wait(_wait)
                end
            end)
        end

        actionTable[#actionTable + 1] = {
            index = index,
            coords = coords,
            distance = distance,
            eventName = event.eventName,
            eventType = eventType,
            eventArgs = args,
            textBoxLabel = textBoxLabel,
            inVehicle = inVehicle,
            job = {
                status = jobStatus,
                jobs = job,
            },
        }

    end
end


AddEventHandler('bt-polyzone:enter', function(name)
    local ped = PlayerPedId()
    local jobAcces = false
    for i=1, #actionTable do 
        if name == "woro-base:CreateActionKey:"..actionTable[i].index then
            if actionTable[i].job.status then
                for i2=1, #actionTable[i].job.jobs do
                    if GetJobName() == actionTable[i].job.jobs[i2] then
                        jobAcces = true
                    end
                end
                if jobAcces then
                    if actionTable[i].inVehicle then
                        if IsPedInAnyVehicle(ped) then
                            ESX.TextUI(actionTable[i].textBoxLabel, "info")
                        end
                    else
                        ESX.TextUI(actionTable[i].textBoxLabel, "info")
                    end
                end
            else
                if actionTable[i].inVehicle then
                    if IsPedInAnyVehicle(ped) then
                        ESX.TextUI(actionTable[i].textBoxLabel, "info")
                    end
                else
                    ESX.TextUI(actionTable[i].textBoxLabel, "info")
                end
            end

            return
        end
    end 
end)
AddEventHandler('bt-polyzone:exit', function(name)
    for i=1, #actionTable do 
        if name == "woro-base:CreateActionKey:"..actionTable[i].index then
            ESX.HideUI()
            return
        end
    end 
end)


RegisterCommand("KeyActionKey", function()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local jobAcces = false

    for i=1, #actionTable do
        local dist = #(pCoords - actionTable[i].coords)
        if dist < actionTable[i].distance then 
            if actionTable[i].job.status then
                for i2=1, #actionTable[i].job.jobs do
                    if GetJobName() == actionTable[i].job.jobs[i2] then
                        jobAcces = true
                    end
                end
                if jobAcces then
                    if actionTable[i].inVehicle then
                        if IsPedInAnyVehicle(ped) then
                            if actionTable[i].eventType == "client" then
                                TriggerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                            elseif actionTable[i].eventType == "server" then
                                TriggerServerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                            end
                        end
                    else
                        if actionTable[i].eventType == "client" then
                            TriggerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                        elseif actionTable[i].eventType == "server" then
                            TriggerServerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                        end
                    end
                end
            else
                if actionTable[i].inVehicle then
                    if IsPedInAnyVehicle(ped) then
                        if actionTable[i].eventType == "client" then
                            TriggerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                        elseif actionTable[i].eventType == "server" then
                            TriggerServerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                        end
                    end
                else
                    if actionTable[i].eventType == "client" then
                        TriggerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                    elseif actionTable[i].eventType == "server" then
                        TriggerServerEvent(actionTable[i].eventName, actionTable[i].eventArgs)
                    end
                end
            end
        end
    end
end)

RegisterKeyMapping("KeyActionKey", "Przycisk Interakcji", "keyboard", "E")