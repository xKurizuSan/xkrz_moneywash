local ESX = exports['es_extended']:getSharedObject()

exports.qtarget:AddBoxZone("MoneyWash", vector3(1135.53, -989.52, 45.51), 6.6, 1.2, {
    name="MoneyWash",
    heading=8,
    debugPoly=Config.Debug,
    minZ=25,
    maxZ=27,
    }, {
    options = {
        {
            event = "moneywash:wash",
            icon = "fa-solid fa-dollar-sign",
            label = "Geld waschen",
        },
    },
distance = 3.5
})

RegisterNetEvent('moneywash:wash')
AddEventHandler('moneywash:wash', function()
    local hasItem = exports.ox_inventory:Search('count', Config.WashMoney)
    if hasItem >= 1 then
        openmenu()
    else
        lib.notify({
            title = 'Error',
            description = Config.Locale[1],
            position = 'top',
            type = 'error'
        })
    end
end)

function openmenu() 
    local input = lib.inputDialog('Geld waschen', {
        {type = 'number', label = 'Wie viel möchtest du waschen?', description = Config.Locale[4], min = 1}
    })
    if not input then 
        return 
    else
        local count = exports.ox_inventory:Search('count', Config.WashMoney)
        if count >= input[1] then
            local alert = lib.alertDialog({
                content = 'Bist du dir sicher?  \n Du wäscht ' .. input[1] .. '$ Schwarzgeld und bekommst ' .. math.floor(input[1] / Config.Prozent) .. '$!',
                centered = true,
                cancel = true
            })
            if alert == 'confirm' then
                local count = exports.ox_inventory:Search('count', Config.WashMoney)
                if count >= input[1] then 
                    lib.progressCircle({
                        duration = Config.Duration,
                        label = Config.Locale[3],
                        useWhileDead = false,
                        canCancel = false,
                        position = "bottom",
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                            mouse = false
                        },
                        anim = {dict = 'amb@world_human_stand_fire@male@idle_a', clip = 'idle_a'},
                    }) 
                    lib.callback('moneywash:washing', source, cb, input)
                else
                    lib.notify({
                        title = 'Error',
                        description = Config.Locale[5],
                        position = 'top',
                        type = 'error'
                    })
                    return
                end
            else
                lib.notify({
                    title = 'Error',
                    description = Config.Locale[2],
                    position = 'top',
                    type = 'error'
                })
                return
            end
        else 
            lib.notify({
                title = 'Error',
                description = Config.Locale[5],
                position = 'top',
                type = 'error'
            })
        end
    end       
end