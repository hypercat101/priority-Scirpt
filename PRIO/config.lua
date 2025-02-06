Config = {}

-- Priority Zones

-- Example
-- ['zoneName'] = { 
--     label = 'Zone Label',
--     defaultStatus = 'Available',
--     defaultCooldown = 0
-- }

Config.Zones = {
    ['ls'] = {
        label = 'Los Santos',
        defaultStatus = 'Available',
        defaultCooldown = 0
    },
    ['blaine'] = {
        label = 'Blaine County',
        defaultStatus = 'Available',
        defaultCooldown = 0
    },
    ['fz'] = {
        label = 'Fort Zancudo',
        defaultStatus = 'Available',
        defaultCooldown = 0
    },
    -- Example: How to add a new zone
    -- ['NAME OF ZONE'] = {
    --     label = 'NAME OF ZONE',
    --     defaultStatus = 'Available',
    --     defaultCooldown = 0
    -- }, Remove the comma if you are not adding anymore zones for the last one
}

-- Simply to add more copy the example and paste it below the last one 

-- Cooldown Settings
Config.PriorityCooldownTime = 10 -- Minutes
Config.CommandCooldownTime = 25 -- Seconds

-- Discord Webhook Settings
Config.Webhook = {
    url = '',  -- Add your webhook URL here
    botName = "Priority System",
    avatarUrl = "", -- Paste what you want webhook bot to be I suggest Imgur
    embedColor = 3447003 -- Blue color (can use hex or decimal)
}


-- Notification Settings
Config.Notifications = {
    position = 'top-right', -- 'top-right', 'top-left', 'bottom-right', 'bottom-left'
    duration = 5000, -- milliseconds 5000 is 5 seconds
}

-- Permission Settings
Config.AcePermission = 'ace.priority' -- ace.priority is the permission to use the priority command You can change it to what you want

-- Custom Messages
Config.Messages = {
    noPermission = 'You do not have permission to use this command',
    cooldownActive = 'Please wait %d seconds',
    areaUnavailable = 'This area is currently unavailable',
    noPriorityActive = 'No active priority in this area',
    forcedCooldown = 'Forced cooldown for %s'
} 
