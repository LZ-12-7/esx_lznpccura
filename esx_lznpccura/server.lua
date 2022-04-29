local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_lznpccura:quitardinerorevive')
AddEventHandler('esx_lznpccura:quitardinerorevive', function()
    local src = source
    local dinero = Config.DineroRevive
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getMoney() >= Config.DineroRevive then
        TriggerClientEvent('esx_lznpccura:revivefunction', src)
        xPlayer.removeMoney(dinero)
        TriggerClientEvent('esx:showNotification', src, 'Has reanimado a tu personaje por ' .. dinero .. '$')
    elseif xPlayer.getMoney() < Config.DineroRevive then
        TriggerClientEvent('esx:showNotification', src, 'No tienes suficiente dinero')
    end
end)

RegisterServerEvent('esx_lznpccura:quitardinerocura')
AddEventHandler('esx_lznpccura:quitardinerocura', function()
    local src = source
    local dinero = Config.DineroCura
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getMoney() >= Config.DineroCura then
        TriggerClientEvent('esx_lznpccura:curafunction', src)
        xPlayer.removeMoney(dinero)
        TriggerClientEvent('esx:showNotification', src, 'Has curado a tu personaje por ' .. dinero .. '$')
    elseif xPlayer.getMoney() < Config.DineroCura then
        TriggerClientEvent('esx:showNotification', src, 'No tienes suficiente dinero')
    end
end)