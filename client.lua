local notifications = {}
local notifId = 0

local notifTypes = {
    ['success'] = {
        icon = 'fa-circle-check',
        color = '#10b981'
    },
    ['error'] = {
        icon = 'fa-circle-xmark',
        color = '#ef4444'
    },
    ['info'] = {
        icon = 'fa-circle-info',
        color = '#3b82f6'
    },
    ['warning'] = {
        icon = 'fa-triangle-exclamation',
        color = '#f59e0b'
    },
    ['police'] = {
        icon = 'fa-shield-halved',
        color = '#3b82f6'
    },
    ['ems'] = {
        icon = 'fa-briefcase-medical',
        color = '#ef4444'
    },
    ['fire'] = {
        icon = 'fa-fire-extinguisher',
        color = '#ef4444'
    },
    ['bank'] = {
        icon = 'fa-building-columns',
        color = '#14b8a6'
    },
    ['mechanic'] = {
        icon = 'fa-wrench',
        color = '#f59e0b'
    }
}

function ShowAdvancedNotification(data)
    notifId = notifId + 1
    local id = notifId
    
    local notifType = notifTypes[data.type] or notifTypes['info']
    
    SendNUIMessage({
        action = 'showNotification',
        id = id,
        title = data.title or 'Benachrichtigung',
        message = data.message or '',
        type = data.type or 'info',
        icon = notifType.icon,
        color = notifType.color,
        duration = data.duration or 5000,
        sound = data.sound ~= false
    })
    
    notifications[id] = true
    
    Citizen.SetTimeout(data.duration or 5000, function()
        notifications[id] = nil
    end)
end

exports('ShowNotification', ShowAdvancedNotification)

RegisterNetEvent('nexure_notify:showNotification')
AddEventHandler('nexure_notify:showNotification', function(msg, type, duration)
    ShowAdvancedNotification({
        message = msg,
        type = type or 'info',
        duration = duration or 5000
    })
end)

RegisterNetEvent('nexure_notify:showNotification')
AddEventHandler('nexure_notify:showNotification', function(data)
    ShowAdvancedNotification(data)
end)

RegisterCommand('testnotify', function()
    ShowAdvancedNotification({
        title = 'Erfolg!',
        message = 'Das ist eine Test-Benachrichtigung',
        type = 'success',
        duration = 5000
    })
end)

RegisterCommand('testerror', function()
    ShowAdvancedNotification({
        title = 'Fehler!',
        message = 'Etwas ist schiefgelaufen',
        type = 'error',
        duration = 5000
    })
end)

RegisterCommand('testwarning', function()
    ShowAdvancedNotification({
        title = 'Warnung',
        message = 'Bitte sei vorsichtig',
        type = 'warning',
        duration = 5000
    })
end)

RegisterCommand('testpolice', function()
    ShowAdvancedNotification({
        title = 'Polizei',
        message = 'Du wurdest von der Polizei durchsucht',
        type = 'police',
        duration = 5000
    })
end)

RegisterCommand('testems', function()
    ShowAdvancedNotification({
        title = 'EMS',
        message = 'Du wurdest erfolgreich behandelt',
        type = 'ems',
        duration = 5000
    })
end)

RegisterCommand('testfire', function()
    ShowAdvancedNotification({
        title = 'Feuerwehr',
        message = 'Die Feuerwehr ist auf dem Weg',
        type = 'fire',
        duration = 5000
    })
end)

RegisterCommand('testmech', function()
    ShowAdvancedNotification({
        title = 'Mechaniker',
        message = 'Die Feuerwehr ist auf dem Weg',
        type = 'mechanic',
        duration = 5000
    })
end)