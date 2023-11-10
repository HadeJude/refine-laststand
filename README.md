# refine-laststand
A [Standalone/QB Ready] for last stand to allow a chance player can move, get up by chance and ask for offer help.
## Free Version
- [Preview](https://streamable.com/uil3q6)
## Paid Version
- [refined-laststand](https://refined.tebex.io/package/5891340)
- [Preview](https://youtu.be/WrHqh-kDY7M)

## Need Unique Script Experience?
- [Tebex](https://refined.tebex.io/)

## Need Assistance?
- [Discord](https://discord.gg/Va9YArM6uW)

### Features
- Ability to move
- Smooth Animation
- Sync Movement
- Great for Immersive Expirience
- Easy to Install

## Installation

* Open `qb-ambulancejob>client>dead.lua`
* Add this [line](#Line) at the end of `dead.lua`
* Look for `if not isEscorted then`
* Add `DeadMovement()` before `loadAnimDict(lastStandDict)`
* Here's the [example](#Example)

## Line
Function
```lua
    function DeadMovement()
        local ped = PlayerPedId()
        loadAnimDict("move_injured_ground")
        if IsDisabledControlPressed(0, 34) then
            SetEntityHeading(ped, GetEntityHeading(ped)+0.25 )
        elseif IsDisabledControlPressed(0, 35) then
            SetEntityHeading(ped, GetEntityHeading(ped)-0.25 )
        end
        
        if IsDisabledControlJustPressed(0, 32) then
            Wait(1000)
            ClearPedTasks(ped)
            TaskPlayAnimAdvanced(ped, "move_injured_ground", "front_loop", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
        elseif IsDisabledControlJustReleased(0, 32) then 
            TaskPlayAnimAdvanced(ped, "move_injured_ground", "front_loop", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
        end
    end

    exports('LastStand', function()
        return InLaststand
    end)
```

## Example

```lua
    if not isEscorted then
        if IsPedInAnyVehicle(ped, false) then
            loadAnimDict("veh@low@front_ps@idle_duck")
            if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
            end
        else
            DeadMovement() --This is the Example 
            loadAnimDict(lastStandDict)
            if not IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                TaskPlayAnim(ped, lastStandDict, lastStandAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
            end
        end
    else
        if IsPedInAnyVehicle(ped, false) then
            loadAnimDict("veh@low@front_ps@idle_duck")
            if IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                StopAnimTask(ped, "veh@low@front_ps@idle_duck", "sit", 3)
            end
        else
            loadAnimDict(lastStandDict)
            if IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                StopAnimTask(ped, lastStandDict, lastStandAnim, 3)
            end
        end
    end
    -- IF you want to add the Export Check 
    RegisterCommand(Config.HandsUp.command, function()
        local ped = PlayerPedId()
        if exports['qb-ambulancejob']:LastStand() then return end <-- this is the example to not trigger you can use it on any other script you want to cancel the animation
        if not HasAnimDictLoaded('missminuteman_1ig_2') then
            RequestAnimDict('missminuteman_1ig_2')
            while not HasAnimDictLoaded('missminuteman_1ig_2') do
                Wait(10)
            end
        end
        handsUp = not handsUp
        if exports['qb-policejob']:IsHandcuffed() then return end
        if handsUp then
            TaskPlayAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 8.0, 8.0, -1, 50, 0, false, false, false)
            exports['qb-smallresources']:addDisableControls(Config.HandsUp.controls)
        else
            ClearPedTasks(ped)
            exports['qb-smallresources']:removeDisableControls(Config.HandsUp.controls)
        end
    end, false)
```
