local Main = {
    Data = {},
    Cooldown = {},
}

Main.SetupScript = function()
    Wait(1000)

    local xPlayers = ESX.GetExtendedPlayers('job', Config.PoliceJobName)
    GlobalState.WoroDrugsPoliceOnline = #xPlayers

    for i=1, #Config.Drugs do
        local drugsData = Config.Drugs[i]
        Main.Data[#Main.Data + 1] = {
            label = drugsData.label,
            action = drugsData.giveItemFunction,
            marker = drugsData.marker,
            args = {
                coords = drugsData.coords,
                size = drugsData.size,
                tick = drugsData.tick,
                id = #Main.Data + 1,
                police = drugsData.police,
            },
        } 
    end

    TriggerClientEvent('woro-drugs:client:setupScript', -1, Main.Data)
end

Main.GiveItem = function(data)
    local _source = source

    if Main.Cooldown[_source] == true then
        return
    end

    Main.Cooldown[_source] = true 


    local ServerData = Main.Data[data.id]

    local xPlayer = ESX.GetPlayerFromId(source)
    local playerCoords = xPlayer.getCoords(true)
    local inMarker = false

    for i=1, #ServerData.args.coords do
        local coords = ServerData.args.coords[i]
        local distance = #(vec3(playerCoords.x, playerCoords.y, playerCoords.z) - vec3(coords.x, coords.y, coords.z))

        if distance <= ServerData.args.size then
            inMarker = true
            break
        end
    end

    if inMarker == false then 
        return
    end

    SetTimeout(ServerData.args.tick - 100, function()
        Main.Cooldown[_source] = false 
    end)

    ServerData.action(_source)
end

Main.PlayerLoad = function(player, xPlayer, isNew)
    xPlayer.triggerEvent('woro-drugs:client:setupScript', Main.Data)

    if xPlayer.getJob().name == Config.PoliceJobName then
        GlobalState.WoroDrugsPoliceOnline = GlobalState.WoroDrugsPoliceOnline + 1
    end
end

Main.UpdatePolice = function(player, job, lastJob)
    if job.name == Config.PoliceJobName then
        GlobalState.WoroDrugsPoliceOnline = GlobalState.WoroDrugsPoliceOnline + 1
    elseif lastJob.name == Config.PoliceJobName then
        GlobalState.WoroDrugsPoliceOnline = GlobalState.WoroDrugsPoliceOnline - 1
    end
end

Main.PlayerDrop = function()
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
        local playerJob = xPlayer.getJob()
        if playerJob.name == Config.PoliceJobName then
            GlobalState.WoroDrugsPoliceOnline = GlobalState.WoroDrugsPoliceOnline - 1
        end
	end
end


CreateThread(Main.SetupScript)
RegisterNetEvent('woro-drugs:client:giveItem', Main.GiveItem)

RegisterNetEvent('esx:setJob', Main.UpdatePolice)
AddEventHandler('playerDropped', Main.PlayerDrop)
RegisterNetEvent('esx:playerLoaded', Main.PlayerLoad)
