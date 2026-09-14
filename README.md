# UI LIB XSAYT - Delta Rayfield-like UI Library

UI Library untuk **Delta Executor** (Roblox) - terinspirasi **Rayfield**.

> `loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XsaytUI.lua"))()`

## Fitur
- Window / Tabs / Sections (ala Rayfield)
- Components: Button, Toggle, Slider, Dropdown, Input, ColorPicker, Keybind, Label, Paragraph
- Notifikasi, KeySystem, Config Saving (writefile/readfile Delta)
- Draggable, Minimize, Toggle UI dengan `K` (RightControl default)
- Tema: Dark modern, Tween animasi smooth, support Mobile (Delta Android)

## Quick Start
```lua
local XsaytUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XsaytUI.lua"))()

local Window = XsaytUI:CreateWindow({
   Name = "XSAYT Hub | Delta",
   LoadingTitle = "XSAYT Loading...",
   LoadingSubtitle = "by myzakonz-gif",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "XsaytUI",
      FileName = "XsaytHub"
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("Main", "rbxassetid://4483345998")
MainTab:CreateSection("Player")

MainTab:CreateToggle({
   Name = "Speed Hack",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value and 50 or 16
   end,
})

MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MainTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
       game:GetService("UserInputService").JumpRequest:Connect(function()
           game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
       end)
   end,
})

XsaytUI:Notify({
   Title = "Loaded!",
   Content = "XSAYT UI Loaded",
   Duration = 3
})
```

## API (Rayfield Compatible)

### XsaytUI:CreateWindow({...})
```lua
{
   Name = "Hub Name",
   LoadingTitle = "...",
   LoadingSubtitle = "...",
   ConfigurationSaving = { Enabled = true, FolderName = "XsaytUI", FileName = "Config" },
   Discord = { Enabled = false, Invite = "", RememberJoins = false },
   KeySystem = false, -- true untuk enable key
   KeySettings = { Title="Key System", Subtitle="...", Note="...", FileName="Key", SaveKey=true, GrabKeyFromSite=false, Key={"XSAYT123"} }
}
```

### Window:CreateTab(Name, IconId)
### Tab:CreateSection(Name)
### Tab:CreateLabel(Text)
### Tab:CreateParagraph({Title, Content})
### Tab:CreateButton({Name, Callback})
### Tab:CreateToggle({Name, CurrentValue, Flag, Callback})
### Tab:CreateSlider({Name, Range, Increment, Suffix, CurrentValue, Flag, Callback})
### Tab:CreateDropdown({Name, Options, CurrentOption, MultipleOptions, Flag, Callback})
### Tab:CreateInput({Name, PlaceholderText, RemoveTextAfterFocusLost, Callback})
### Tab:CreateColorPicker({Name, Color, Flag, Callback})
### Tab:CreateKeybind({Name, CurrentKeybind, HoldToInteract, Flag, Callback})

### Utils
- `XsaytUI:Notify({Title, Content, Duration, Image})`
- `XsaytUI:Destroy()`
- `Window:Destroy()`

## Delta Support
Otomatis deteksi `writefile`, `readfile`, `makefolder`, `isfolder`, `isfile` untuk config & key system. Fallback aman jika tidak ada.

## License
MIT - myzakonz-gif
