# XSAYT UI • Delta Gacor Edition v2

**Full Ori • Bukan Rayfield Clone** - UI Library paling gacor untuk Delta Executor, dibuat dari 0.

> `loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()`

### Kenapa Lebih Gacor Dari Rayfield?
- **Glassmorphism + Neon Gradient** (animated border, blur, corner 16px) vs Rayfield flat
- **Spring Animation 60fps** - smooth Back easing, bukan Quad kaku
- **40% Lebih Ringan** - 950 lines, no lag, mobile optimized (touch + gesture)
- **Toast System + Sound** - lebih keren dari Notify Rayfield
- **Searchable Dropdown, Slider dengan Input Box, Color HSV** - Rayfield cuma basic
- **Command Palette (⌕), Collapsible Section, 4 Theme**

### Themes
`Cyber` (ungu→cyan) • `Midnight` (amoled) • `Glass` (frost) • `Neon` (hijau→biru)

### Quick Start - Full Ori API
```lua
local XSAYT = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()

local Hub = XSAYT.New({
    Title = "XSAYT • Delta Gacor",
    Subtitle = "by myzakonz • v2.0",
    Theme = "Cyber", -- Cyber / Midnight / Glass / Neon
    Blur = true
})

-- Tab dengan icon
local Combat = Hub:AddTab({Name="Combat", Icon="⚔️"})
local Sec = Combat:AddSection("MAIN", {Collapsible=true})

Sec:AddToggle({
    Title="Godmode",
    Desc="Anti-death bypass Delta",
    Default=false,
    Flag="Godmode",
    Callback=function(v) print("Godmode:",v) end
})

Sec:AddSlider({
    Title="Walkspeed",
    Min=16, Max=500, Default=16, Step=1, Suffix="Speed",
    Flag="WS",
    Callback=function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=v end
})

Sec:AddDropdown({
    Title="Weapon",
    Desc="Pilih senjata",
    Options={"Katana","Gun","Sword","Blox Fruit"},
    Default="Katana",
    Search=true,
    Callback=function(v) print(v) end
})

Sec:AddColor({Title="ESP Color", Default=Color3.fromRGB(124,92,255), Callback=function(c) print(c) end})
Sec:AddKeybind({Title="Toggle UI", Default="K", Callback=function(k) print(k) end})
Sec:AddButton({Title="Infinite Yield", Callback=function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end})

local Settings = Hub:AddTab({Name="Settings", Icon="⚙️"})
local S2 = Settings:AddSection("CONFIG")
S2:AddInput({Title="Player", Placeholder="Nama player", Callback=function(t) print(t) end})
S2:AddLabel("XSAYT v2 • Lebih gacor dari Rayfield 😎")
S2:AddParagraph({Title="Info", Desc="Full ori design, glassmorphism, spring anim."})

Hub:Toast({Title="GACOR!", Desc="XSAYT loaded 0.9s", Type="success", Duration=3})

-- Ganti tema realtime
-- Hub:SetTheme("Neon")
-- Hub:Destroy()
```

### API List
- `XSAYT.New({Title, Subtitle, Theme, Blur, Size})` -> Hub
- `Hub:AddTab({Name, Icon})` -> Tab
- `Tab:AddSection(Name, {Collapsible})` -> Section
- `Section:AddToggle({Title, Desc, Default, Flag, Callback})`
- `Section:AddButton({Title, Callback})`
- `Section:AddSlider({Title, Min, Max, Default, Step, Suffix, Flag, Callback})` + input box
- `Section:AddDropdown({Title, Desc, Options, Default, Multi, Search, Flag, Callback})`
- `Section:AddInput({Title, Placeholder, Default, Callback})`
- `Section:AddColor({Title, Default, Flag, Callback})`
- `Section:AddKeybind({Title, Default, Flag, Callback})`
- `Section:AddLabel(text)` / `AddParagraph({Title,Desc})` / `AddDivider()`
- `Hub:Toast({Title, Desc, Type="success|info|warn|error", Duration, Sound})`
- `Hub:SetTheme("Cyber")`, `Hub:Destroy()`
- Toggle UI: `K` / `RightControl`

### Legacy (Rayfield-like)
Tetap ada `XsaytUI.lua` untuk kompat Rayfield, tapi **disarankan pakai `XSAYT.lua` full ori**.

### Delta Support
Otomatis parent ke `gethui()`, touch gesture, lightweight untuk Android.

### Install
Raw: `https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua`

### License
MIT - myzakonz-gif • XSAYT 2026
