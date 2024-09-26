# GGWPx Server Status Notification

This script sends status updates of your FiveM server to a Discord channel via a webhook. It notifies when the server starts, shuts down, or when there are changes in the player count or server status.

## Features

- Sends notifications to Discord on server start and shutdown.
- Updates status every minute with current player count and server uptime.
- Configurable with your own Discord webhook URL, server name, and other details.

## Configuration

1. **Webhook URL**: Set `webhookURL` to your Discord webhook URL.
2. **Server Name**: Update `serverName` with the name of your server.
3. **Logo URL**: Change `logoURL` to the URL of your server logo.
4. **Connect URL**: Modify `connectURL` to your server's connection information.

```lua
local webhookURL = 'YOUR_DISCORD_WEBHOOK_URL'
local serverName = "YOUR_SERVER_NAME"
local logoURL = "YOUR_SERVER_LOGO_URL"
local connectURL = "**connect YOUR_SERVER_IP:PORT**"
