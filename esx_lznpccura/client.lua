local ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    SpawnNPC("s_m_m_scientist_01", Config.NpcPosRevive)
    while true do
        local _s = 1000
        local ped = PlayerPedId()
        local pedpos = GetEntityCoords(ped)

        if #(pedpos - Config.CuandoTeAcercasApareceRevive) < 2 then
            _s = 0
            DrawText3D(Config.TextRevivePos, Config.TextoRevive)
            if IsControlJustPressed(1, 38) and IsEntityDead(ped) then
                TriggerServerEvent('esx_lznpccura:quitardinerorevive')
            elseif IsControlJustPressed(1, 38) and not IsEntityDead(ped) then
                ESX.ShowNotification("~r~No estas muerto")
            end
        end
        Citizen.Wait(_s)
    end
end)

Citizen.CreateThread(function()
    SpawnNPC("s_m_m_scientist_01", Config.NpcPosCura)
    while true do
        local _s = 1000
        local ped = PlayerPedId()
        local pedpos = GetEntityCoords(ped)

        if #(pedpos - Config.CuandoTeAcercasApareceCura) < 2 then
            _s = 0
            DrawText3D(Config.TextCuraPos, Config.TextoCura)
            if IsControlJustPressed(1, 38) then
                TriggerServerEvent('esx_lznpccura:quitardinerocura')
            end
        end
        Citizen.Wait(_s)
    end
end)

RegisterNetEvent('esx_lznpccura:revivefunction')
AddEventHandler('esx_lznpccura:revivefunction', function()
    TreatPlayer()
end)

RegisterNetEvent('esx_lznpccura:curafunction')
AddEventHandler('esx_lznpccura:curafunction', function()
    SetEntityHealth(PlayerPedId(), 200)
end)

TreatPlayer = function()
    StopScreenEffect("DeathFailOut")
    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.985), 180.0, true, false)
    SetPlayerInvincible(PlayerId(), false)
    ClearPedBloodDamage(PlayerPedId())

	TriggerServerEvent("esx:onPlayerSpawn")
	TriggerEvent("esx:onPlayerSpawn")
	TriggerEvent("playerSpawned")
end

DrawText3D = function(coords, texto)
    local x, y, z = table.unpack(coords)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(texto)
        DrawText(_x, _y)
    end
end

SpawnNPC = function(modelo, x,y,z,h)
    hash = GetHashKey(modelo)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    crearNPC = CreatePed(5, hash, x,y,z, h, false, false)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
    TaskStartScenarioInPlace(crearNPC, 0, true)
end