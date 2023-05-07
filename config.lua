Config = {}

Config.PoliceJobName = 'police'

Config.Drugs = {
    --Field
    {
        coords = {
            vec3(2224.4372558594, 5577.0673828125, 53.848117828369),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('weed')
            if items.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            return xPlayer.addInventoryItem('weed', 1)
        end,
        label = 'Kliknik E aby zbierać zioło',
        marker = {
            type = 23,
            color = {255, 255, 255, 255},
            scale = 10,
            distance = 50,
        },
        size = 5,
        tick = 5000,
        police = 1,
    },
    --Processing
    {
        coords = {
            vec3(739.341796875, 2579.3723144531, 75.471168518066),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('weed')
            local newItems = xPlayer.getInventoryItem('weed_pooch')
            if items.count < 5 then
                return xPlayer.showNotification('Nie masz wystarczająco ziola')
            end 
            
            if newItems.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            xPlayer.removeInventoryItem('weed', 5)
            return xPlayer.addInventoryItem('weed_pooch', 1)
        end,
        label = 'Kliknik E aby przerobić zioło',
        marker = {
            type = 23,
            color = {255, 255, 255, 255},
            scale = 10,
            distance = 50,
        },
        size = 5,
        tick = 5000,
        police = 1,
    },
}