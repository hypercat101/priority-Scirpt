local priorities = {
    blaine = { status = 'Available', cooldown = 0 },
    ls = { status = 'Available', cooldown = 0 },
    fz = { status = 'Available', cooldown = 0 }
}

local playerCooldowns = {}

-- Configuration
local webhookUrl = 'YOUR_WEBHOOK_URL'

-- Add your Discord user IDs here (can add multiple)
local discordIDs = {
    ['license:1234567890abcdef'] = '123456789012345678' -- Outdated Not needed anymore
}

local function checkPlayerCooldown(source)
    local currentTime = os.time()
    if playerCooldowns[source] and currentTime - playerCooldowns[source] < 25 then
        -- Player is still in cooldown
        local remainingTime = 25 - (currentTime - playerCooldowns[source])
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Command Cooldown',
            description = string.format('Please wait %d seconds', remainingTime),
            type = 'error'
        })
        return false
    end
    
    -- Set new cooldown
    playerCooldowns[source] = currentTime
    return true
end

local function updatePriorityStatus(location, status, cooldown)
    if not priorities[location] then return end
    
    priorities[location].status = status
    priorities[location].cooldown = cooldown
    TriggerClientEvent('priority:updateStatus', -1, location, status, cooldown)
end

local function startCooldown(location)
    if not priorities[location] then return end

    priorities[location].status = 'Cooldown'
    priorities[location].cooldown = 10
    
    TriggerClientEvent('priority:updateStatus', -1, location, 'Cooldown', 10)
    
    CreateThread(function()
        local timer = 10
        while timer > 0 do
            Wait(60000)
            timer = timer - 1
            priorities[location].cooldown = timer
            
            TriggerClientEvent('priority:updateStatus', -1, location, 'Cooldown', timer)
            
            if timer <= 0 then
                priorities[location].status = 'Available'
                priorities[location].cooldown = 0
                TriggerClientEvent('priority:updateStatus', -1, location, 'Available', 0)
            end
        end
    end)
end

local function sendToDiscord(player, action, location)
    print('Attempting to send webhook:', player, action, location)
    
    print('Webhook URL:', webhookUrl)
    
    if webhookUrl == '' then 
        print('Webhook URL not set!')
        return 
    end
    
    -- Get player identifiers
    local identifiers = GetPlayerIdentifiers(source)
    local discordPing = ''
    
    -- Debug print identifiers
    print('Player identifiers:', json.encode(identifiers))
    
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "discord:") then
            discordPing = string.format('<@%s>', string.gsub(identifier, "discord:", ""))
            print('Found Discord ID:', discordPing)
            break
        end
    end
    
    local message = {
        content = discordPing, -- This will ping the user
        embeds = {
            {
                title = '🚨 Priority System',
                description = string.format('**Player:** %s\n**Action:** %s\n**Location:** %s', player, action, location),
                color = 3447003, -- Blue color
                footer = {
                    text = os.date('%Y-%m-%d %H:%M:%S')
                },
                fields = {
                    {
                        name = 'Location',
                        value = location:upper(),
                        inline = true
                    },
                    {
                        name = 'Action',
                        value = action,
                        inline = true
                    }
                }
            }
        },
        username = "Priority System",
        avatar_url = "https://i.imgur.com/tC8k4f4.png"
    }
    
    -- Debug print the message
    print('Sending webhook message:', json.encode(message))
    
    PerformHttpRequest(webhookUrl, function(err, text, headers)
        if err then
            print('Webhook Error:', err)
        else
            print('Webhook sent successfully!')
        end
    end, 'POST', json.encode(message), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('priority:start')
AddEventHandler('priority:start', function(location)
    local source = source
    if not IsPlayerAceAllowed(source, 'ace.priority') then return end
    
    -- Check if location is valid
    if not priorities[location] then return end
    
    -- Check if priority is already active or in cooldown
    if priorities[location].status ~= 'Available' then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'ERROR',
            description = 'This area is currently unavailable',
            type = 'error'
        })
        return
    end
    
    -- Start the priority
    updatePriorityStatus(location, 'In Progress', 0)
    
    -- Send Discord webhook
    sendToDiscord(GetPlayerName(source), "Started Priority", location)
end)

RegisterNetEvent('priority:remove')
AddEventHandler('priority:remove', function(location)
    local source = source
    if not IsPlayerAceAllowed(source, 'ace.priority') then return end
    
    if not priorities[location] then return end
    
    if priorities[location].status == 'Available' then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'ERROR',
            description = 'No active priority in this area',
            type = 'error'
        })
        return
    end
    
    startCooldown(location)
    
    sendToDiscord(GetPlayerName(source), "Ended Priority", location)
end)

RegisterNetEvent('priority:checkPermission')
AddEventHandler('priority:checkPermission', function(action)
    local source = source
    if not IsPlayerAceAllowed(source, 'ace.priority') then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'ERROR',
            description = 'You do not have permission to use this command',
            type = 'error'
        })
        return
    end

    if not checkPlayerCooldown(source) then
        return
    end

    TriggerClientEvent('priority:showDialog', source, action)
end)

RegisterNetEvent('priority:forceCooldown')
AddEventHandler('priority:forceCooldown', function(location)
    local source = source
    if not IsPlayerAceAllowed(source, 'ace.priority') then return end
    
    if not priorities[location] then return end
    
    startCooldown(location)
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Priority System',
        description = string.format('Forced cooldown for %s', location),
        type = 'inform'
    })
    
    sendToDiscord(GetPlayerName(source), "Forced Cooldown", location)
end)