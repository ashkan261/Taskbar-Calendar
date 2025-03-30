# Taskbar-Calendar
Persian Desktop Date Widget 🗓️🇮🇷

 
A minimal and lightweight desktop widget for **Jalali (Persian) date** display, designed specifically for Windows 11.

## ✨ Features

- 📅 Displays the Persian date in format: `Sunday 12 Farvardin 1404`
- 🖼 Clean, text-only widget with no window borders
- 🪟 Always-on-top, docked near the taskbar
- 🎮 Smart detection of Fullscreen apps (games, videos, RDP) and auto-hide
- 🔄 Auto-updates every minute to reflect accurate date at midnight
- ⚡ Ultra-lightweight (uses ~1MB RAM and almost 0% CPU)
- 💻 No install needed — can be compiled as a standalone `.exe` using AutoHotkey

## 🛠 Requirements

- [AutoHotkey v2](https://www.autohotkey.com/) — to run `.ahk` or compile to `.exe`
- Windows 10 or 11

## 🚀 How to Use

### Option 1: Run as Script

1. Open `calendar.ahk` with AutoHotkey.
2. (Optional) Add it to the Windows startup folder:
   - Press `Win + R` → type `shell:startup` → place the `.ahk` or `.exe` there.

### Option 2: Compile to `.exe`

1. Open `Ahk2Exe` (comes with AutoHotkey).
2. Select the `calendar.ahk` file and click **Convert**.
3. Place the compiled `.exe` into your `shell:startup` folder.

## 📂 File Structure

```bash
calendar.ahk        # Main widget script
README.md           # This documentation
