Config = {}

Config.PoliceJobName = 'police'

Config.Drugs = {
    --Field
    {
        coords = {
            vec3(2224.0031738281, 5577.2075195313, 53.839317321777),
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




    --Field
    {
        coords = {
            vec3(-1519.4946289063, 129.42947387695, 50.05248260498),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('coke')
            if items.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            return xPlayer.addInventoryItem('coke', 1)
        end,
        label = 'Kliknik E aby zbierać koke',
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
            vec3(-1527.018310546, 129.9836730957, 50.05248260498),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('coke')
            local newItems = xPlayer.getInventoryItem('coke_pooch')
            if items.count < 5 then
                return xPlayer.showNotification('Nie masz wystarczająco koki')
            end 
            
            if newItems.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne koki')
            end
            xPlayer.removeInventoryItem('coke', 5)
            return xPlayer.addInventoryItem('coke_pooch', 1)
        end,
        label = 'Kliknik E aby przerobić koke',
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




    --Field
    {
        coords = {
            vec3(-279.17306518555, 2206.1042480469, 129.8472442627),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('coke')
            if items.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            return xPlayer.addInventoryItem('coke', 1)
        end,
        label = 'Kliknik E aby zbierać koke',
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
            vec3(282.00299072266, 6789.0297851563, 15.695042610168),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('coke')
            local newItems = xPlayer.getInventoryItem('coke_pooch')
            if items.count < 5 then
                return xPlayer.showNotification('Nie masz wystarczająco koki')
            end 
            
            if newItems.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            xPlayer.removeInventoryItem('coke', 5)
            return xPlayer.addInventoryItem('coke_pooch', 1)
        end,
        label = 'Kliknik E aby przerobić koke',
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





    --Field
    {
        coords = {
            vec3(899.85192871094, -2536.2065429688, 28.289009094238),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('meth')
            if items.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            return xPlayer.addInventoryItem('meth', 1)
        end,
        label = 'Kliknik E aby zbierać mete',
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
            vec3(720.57141113281, 1291.1990966797, 360.29626464844),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('meth')
            local newItems = xPlayer.getInventoryItem('meth_pooch')
            if items.count < 5 then
                return xPlayer.showNotification('Nie masz wystarczająco mety')
            end 
            
            if newItems.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            xPlayer.removeInventoryItem('meth', 5)
            return xPlayer.addInventoryItem('meth_pooch', 1)
        end,
        label = 'Kliknik E aby przerobić mete',
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





    --Field
    {
        coords = {
            vec3(-1507.2700195313, 104.72926330566, 52.240684509277),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('ketamina')
            if items.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            return xPlayer.addInventoryItem('ketamina', 1)
        end,
        label = 'Kliknik E aby zbierać ketamine',
        marker = {
            type = 23,
            color = {255, 255, 255, 255},
            scale = 3,
            distance = 20,
        },
        size = 5,
        tick = 5000,
        police = 1,
    },
    --Processing
    {
        coords = {
            vec3(-1515.2590332031, 107.30208587646, 52.240684509277),
        },
        giveItemFunction = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            local items = xPlayer.getInventoryItem('ketamina')
            local newItems = xPlayer.getInventoryItem('ketamina_pooch')
            if items.count < 5 then
                return xPlayer.showNotification('Nie masz wystarczająco ketaminy')
            end 
            
            if newItems.count >= 100 then
                return xPlayer.showNotification('Masz juz pełne kieszenie')
            end
            xPlayer.removeInventoryItem('meth', 5)
            return xPlayer.addInventoryItem('ketamina_pooch', 1)
        end,
        label = 'Kliknik E aby przerobić ketamine',
        marker = {
            type = 23,
            color = {255, 255, 255, 255},
            scale = 3,
            distance = 20,
        },
        size = 5,
        tick = 5000,
        police = 1,
    },
}