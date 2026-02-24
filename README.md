# 💉 Yeet Injector
A fast, clean, universal DLL injector for Windows. Works with any game or process.
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![.NET](https://img.shields.io/badge/.NET-8.0-purple)
![Architecture](https://img.shields.io/badge/arch-x64-green)
---
## Requirements
- Windows 10 / 11 (64-bit)
- [.NET 8 Desktop Runtime](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) *(only needed if building from source — the .exe is self-contained)*
- Run as **Administrator**
---
## Download & Run
1. Download `YeetInjector.exe` from [Releases](https://github.com/boogiegainz/yeet-injector/releases)
2. Right-click → **Run as Administrator**
3. That's it — no install needed
---
## How to Use
1. **Pick a process** — select your target game/process from the dropdown (auto-refreshes every 2 seconds)
2. **Select your DLL** — click **Browse** and choose your `.dll` file
3. **Click YEET IT** — the DLL gets injected instantly
4. Check the **log** at the bottom for success/error details
### Extra Options
| Option | What it does |
|--------|-------------|
| **Auto Inject** | Watches for the process to launch and injects automatically |
| **Close on Inject** | Closes Yeet Injector after a successful injection |
| **Delay (ms)** | Waits X milliseconds before injecting |
| **Hide to Tray** | Minimizes to system tray — double-click to restore |
---
## Building from Source
```bash
# Clone the repo
git clone https://github.com/boogiegainz/yeet-injector.git
cd yeet-injector
# Build
dotnet build YeetInjector/YeetInjector.csproj -c Release
# Or publish as a single .exe
dotnet publish YeetInjector/YeetInjector.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -o publish
```
Requires [.NET 8 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/8.0).
---
## Injection Method
Uses **CreateRemoteThread + LoadLibraryA** — the most compatible technique across games and processes.
- Supports both **x86** and **x64** target processes
- Shows process architecture in the dropdown `[PID] process.exe (x64)`
- Requires Administrator for protected processes
---
## Disclaimer
For **modding, development, and educational use only**. Do not use in multiplayer games with anti-cheat. You are responsible for how you use this tool.
---
*[github.com/boogiegainz/yeet-injector](https://github.com/boogiegainz/yeet-injector)*
