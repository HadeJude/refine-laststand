local lastStandTrigger = false

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

local function movement(ped, num)
    ClearPedTasks(ped)
    TaskPlayAnimAdvanced(ped, "move_injured_ground", "front_loop", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, num, 1.0, 0, 0)
end

CreateThread(function()
    while true do
        local sleep = 1000
        if lastStandTrigger then
            sleep = 0
            local ped = PlayerPedId()
            local heading = GetEntityHeading(ped)

            if IsDisabledControlPressed(0, 34) then
                SetEntityHeading(ped, GetEntityHeading(ped) + 0.25 )
            elseif IsDisabledControlPressed(0, 35) then
                SetEntityHeading(ped, GetEntityHeading(ped) - 0.25 )
            end
            
            if IsDisabledControlJustPressed(0, 32) then
                movement(ped, 47)
            elseif IsDisabledControlJustReleased(0, 32) then 
                movement(ped, 46)
            end
        end
        end
        Wait(sleep)
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
        if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(victim) then
            if not lastStandTrigger then
                lastStandTrigger = true
            end
        end
    end
end)

loadAnimDict("move_injured_ground")

-- QB or QBox
--[[
AddEventHandler('hospital:client:Revive', function()
    lastStandTrigger = false
end)
]]--

-- ESX Choose One Whic Support Your Script
--[[
AddEventHandler('esx:onPlayerDeath', function(data)
    lastStandTrigger = false
end)

AddEventHandler('playerSpawned', function(spawn)
    lastStandTrigger = false
end)

]]--
