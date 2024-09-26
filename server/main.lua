local webhookURL = 'https://discord.com/api/webhooks/1284349336179703828/MjHRcV_tlc5QnxK6CwxZYxzAcUg5antf6fuuINDr-2a9qNngYzCSyleXpmnuDdoqqmd5'
local serverName = "GGWPx"
local logoURL = "https://i1.sndcdn.com/avatars-000624930687-7tlzbq-t240x240.jpg"
local connectURL = "**connect 123.2334.234:3476**"
local lastPlayerCount = -1
local lastServerStatus = "🟢 **Online**"
local serverStartTime = os.time() -- Use timestamp to calculate uptime

-- Function to send message to Discord
local function sendToDiscord(title, description, color)
    local embeds = {
        {
            ["title"] = title,
            ["description"] = description .. "\n\nCommand: " .. connectURL,
            ["color"] = color,
            ["footer"] = {
                ["text"] = "Server: " .. serverName,
            },
            ["thumbnail"] = {
                ["url"] = logoURL
            }
        }
    }
    PerformHttpRequest(webhookURL, function(err, text, headers)
        if err then print("Error sending Discord message: " .. err) end
    end, 'POST', json.encode({
        username = serverName, 
        embeds = embeds,
    }), { ['Content-Type'] = 'application/json' })
end

-- Function to get the number of online players
local function getPlayerCount()
    return GetNumPlayerIndices() -- Ensure this correctly reflects online players
end

-- Function to get server uptime in a readable format
local function getServerUptime()
    local uptimeSeconds = os.time() - serverStartTime
    local hours = math.floor(uptimeSeconds / 3600)
    local minutes = math.floor((uptimeSeconds % 3600) / 60)
    return string.format("%02d hours %02d minutes", hours, minutes)
end

-- Notify on server shutdown or resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local playerCount = getPlayerCount()
        local uptime = getServerUptime()

        local title = "🚨 **SHUTDOWN!**"
        local description = string.format("**Server %s has been shut down!**\n\nStatus: 🔴 **Offline**\nPlayer Count:** %d**\nServer Uptime:** %s**", serverName, playerCount, uptime)
        local color = 15158332 -- Red
        sendToDiscord(title, description, color)
    end
end)

-- Notify on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local title = "✅ **ONLINE!**"
        local description = string.format("**Server %s is now online!**\n\nStatus: 🟢 **Online**\nServer Uptime:** %s**", serverName, getServerUptime())
        local color = 3066993 -- Green
        sendToDiscord(title, description, color)
    end
end)

-- Check for status changes
local function checkStatus()
    local playerCount = getPlayerCount()
    local serverStatus = "🟢 **Online**"
    local uptime = getServerUptime()

    if playerCount ~= lastPlayerCount or serverStatus ~= lastServerStatus then
        local title = "ℹ️ **UPDATE!**"
        local description = string.format("Status: %s\nPlayer Count:** %d**\nServer Uptime:** %s**", serverStatus, playerCount, uptime)
        local color = 3447003 -- Blue

        sendToDiscord(title, description, color)

        lastPlayerCount = playerCount
        lastServerStatus = serverStatus
    end
end

-- Check status every 1 minute
CreateThread(function()
    while true do
        Wait(60000) -- Check every 60 seconds
        checkStatus()
    end
end)
