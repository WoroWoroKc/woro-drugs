local actionTable = {}
local CurrentZone = nil

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
        return print('"CreateActionKey" empty variable index!')
    elseif coords == nil then
        return print('"CreateActionKey" empty variable coords!')
    elseif distance == nil then
        return print('"CreateActionKey" empty variable distance!')
    elseif config == nil then
        return print('"CreateActionKey" empty table config!')
    elseif event == nil then
        return print('"CreateActionKey" empty table event!')
    elseif event.eventName == nil then
        return print('"CreateActionKey" empty table event variable eventName!')
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
            textBoxLabel = textBox.label
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

        local zone = BoxZone:Create(coords, distance, distance, {
            name = 'woro-base:'..index,
            offset = {0.0, 0.0, 0.0},
            scale = {1.0, 1.0, 1.0},
            debugPoly = true
        })

        actionTable['woro-base:'..index] = {
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

        CreateThread(function()
            zone:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    CurrentZone = 'woro-base:'..index

                    local actionTable = actionTable[CurrentZone]
                    if actionTable.job.status then
                        for i2=1, #actionTable.job.jobs do
                            if ESX.PlayerData.job.name == actionTable.job.jobs[i2] then
                                jobAcces = true
                            end
                        end
                        if jobAcces then
                            if actionTable.inVehicle then
                                if IsPedInAnyVehicle(ped) then
                                    ESX.TextUI(actionTable.textBoxLabel, "info")
                                end
                            else
                                ESX.TextUI(actionTable.textBoxLabel, "info")
                            end
                        end
                    else
                        if actionTable.inVehicle then
                            if IsPedInAnyVehicle(ped) then
                                ESX.TextUI(actionTable.textBoxLabel, "info")
                            end
                        else
                            ESX.TextUI(actionTable.textBoxLabel, "info")
                        end
                    end


                else
                    CurrentZone = nil
                    ESX.HideUI()
                end
            end)
        end)

    end
end




RegisterCommand("KeyActionKey", function()
    if CurrentZone == nil then
        return
    end

    local playerPed = PlayerPedId()
    local pCoords = GetEntityCoords(playerPed)


    local actionTable = actionTable[CurrentZone]
    
    local dist = #(pCoords - actionTable.coords)
    if dist < actionTable.distance then 
        if actionTable.job.status then
            for i2=1, #actionTable.job.jobs do
                if ESX.PlayerData.job.name == actionTable.job.jobs[i2] then
                    jobAcces = true
                end
            end
            if jobAcces then
                if actionTable.inVehicle then
                    if IsPedInAnyVehicle(playerPed) then
                        if actionTable.eventType == "client" then
                            TriggerEvent(actionTable.eventName, actionTable.eventArgs)
                        elseif actionTable.eventType == "server" then
                            TriggerServerEvent(actionTable.eventName, actionTable.eventArgs)
                        end
                    end
                else
                    if actionTable.eventType == "client" then
                        TriggerEvent(actionTable.eventName, actionTable.eventArgs)
                    elseif actionTable.eventType == "server" then
                        TriggerServerEvent(actionTable.eventName, actionTable.eventArgs)
                    end
                end
            end
        else
            if actionTable.inVehicle then
                if IsPedInAnyVehicle(playerPed) then
                    if actionTable.eventType == "client" then
                        TriggerEvent(actionTable.eventName, actionTable.eventArgs)
                    elseif actionTable.eventType == "server" then
                        TriggerServerEvent(actionTable.eventName, actionTable.eventArgs)
                    end
                end
            else
                if actionTable.eventType == "client" then
                    TriggerEvent(actionTable.eventName, actionTable.eventArgs)
                elseif actionTable.eventType == "server" then
                    TriggerServerEvent(actionTable.eventName, actionTable.eventArgs)
                end
            end
        end
    end
end)

RegisterKeyMapping("KeyActionKey", "Przycisk Interakcji", "keyboard", "E")

local function Main()
    ESX.PlayerData = ESX.GetPlayerData()
end

RegisterNetEvent('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
CreateThread(Main)
