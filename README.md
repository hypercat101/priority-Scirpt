# FiveM Priority System

A Simple fully configurable Prioirty Scirpt 

## 🌟 Key Features

### Priority Zone Management
- **Multiple Zones:**
  - Los Santos (City)
  - Blaine County (BC)
  - Fort Zancudo (Military Base)
  - *You can add more zones as needed*

- **Real-time Status Updates:** All players can see current priority statuses
- **Automatic Cooldown System:** 10-minute cooldown timer after priorities end
- **Force Cooldown Option:** Staff can manually trigger cooldowns if needed

### Staff Controls
- **Permission-Based Access:** Secure ACE permission system
- **Anti-Spam Protection:** 25-second cooldown between commands *(configurable)*

### Discord Integration
- **Real-time Logging:** All priority actions are logged to Discord via webhook
- **Staff Accountability:** Tracks which staff member performs each action with Discord pings
- **Detailed Webhooks:**
  - Timestamps
  - Staff member information
  - Priority location
  - Action taken

## 📋 Requirements
- FiveM Server
- ox_lib

## ⚙️ Installation

### 1. Download & Setup
1. Install ox_lib
2. Install the Priority Script
3. Place both in your resources folder
4. Configure as shown below

### 2. Server Configuration
Add to your `server.cfg`:


### 3. Discord Setup
1. Create a webhook in your Discord server
2. Copy webhook URL
3. Replace the webhook URL in `server/priority.lua`

## 🎮 Usage Guide

### Commands
- `/priority` - Open priority menu
- `/prioritycd` - Force cooldown
- `/removepriority` - End current priority

## 📝 Additional Notes
- UI position is customizable (default: top right)
- Webhook colors and formatting can be modified
- Cooldown times are configurable

## 📸 Preview
![image](https://github.com/user-attachments/assets/0df89db5-2ea0-4170-9fa8-9c95ed1ffa3f)
![image](https://github.com/user-attachments/assets/bd00e100-21ed-400b-9a73-e049906d5b1b)

## 📜 License
MIT License

## 🤝 Support
For support, please contact  hypercat on discord.




Extra: You can change the color and wher you want default I have It the top right you can change It
