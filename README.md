# FiveM Priority System

A sophisticated priority management system designed for FiveM roleplay servers. This resource provides staff with powerful tools to manage and track priority situations (such as robberies, shootouts, or major events) across different zones, ensuring organized roleplay and preventing situation overlap.

## 🌟 Key Features

### Priority Zone Management
- **Multiple Zones**: 
  - Los Santos (City)
  - Blaine County (County)
  - Fort Zancudo (Military Base)

**You can add more this is just what I have added** ^


- **Real-time Status Updates**: All players can see current priority statuses
- **Automatic Cooldown System**: 10-minute cooldown timer after priorities end
- **Force Cooldown Option**: Staff can manually trigger cooldowns if needed

### Staff Controls
- **Permission-Based Access**: Secure ACE permission system
- **Anti-Spam Protection**: 25-second cooldown between commands [You can change the cooldown to what ever you choose]

### Discord Integration
- **Real-time Logging**: All priority actions are logged to Discord aka Simple  Webhook
- **Staff Accountability**: Tracks which staff member performs each action In the webhook It pings them
- **Detailed Webhooks**: 
  - Timestamps
  - Staff member information
  - Priority location
  - Action taken

## 📋 Requirements
- FiveM Server
- ox_lib

## ⚙️ Installation

1. **Download & Setup**
   ```bash
Install ox_lib
Install the PrioScirpt
Put both In your resources folder
Server Config It below 
   ```

2. **Server Configuration**
   Add to your `server.cfg`:
   ```cfg
   ensure ox_lib
   ensure priority-system
   
   # Permission Setup
   add_ace group.admin ace.priority allow    # Change and add groups as you like by simply duping the line and adding your group
   ```

3. **Discord Setup**
   - Create a webhook in your Discord server
   - Copy webhook URL
   - Add URL to `server/priority.lua`

## 🎮 Usage Guide
/priority
/prioritycd
/removepriority


Extra: You can change the color and wher you want default I have It the top right you can change It
