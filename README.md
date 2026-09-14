<p align="center">
  <div style="background:linear-gradient(135deg,#0a0a0f 0%,#1a1a2e 50%,#0f2027 100%);border-radius:16px;padding:28px;border:1px solid #282834">
    <div style="font-size:28px;font-weight:900;letter-spacing:-1px;background:linear-gradient(135deg,#7c5cff 0%,#00dcff 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent">CatherFI UI</div>
    <div style="color:#8c8c9b;font-size:13px;margin-top:4px">Roblox Premium Edition • Glassmorphism • Spring 60fps • Full Original</div>
  </div>
</p>

<h1 align="center">CatherFI UI — Roblox Platform UI Library v2</h1>
<p align="center"><b>Roblox UI Library Premium untuk Roblox Platform • Full Original • Professional • Ringan & Cepat</b></p>
<p align="center"><i>Roblox Platform • Roblox UI Library • Roblox Script Hub • Premium Design</i></p>

<p align="center">
  <a href="https://github.com/myzakonz-gif/CatherFI-UI"><img src="https://img.shields.io/github/stars/myzakonz-gif/CatherFI-UI?style=for-the-badge&logo=github&color=7c5cff" alt="Stars"/></a>
  <a href="https://myzakonz-gif.github.io/CatherFI-UI/"><img src="https://img.shields.io/badge/docs-website-00dcff?style=for-the-badge&logo=googlechrome" alt="Docs"/></a>
  <img src="https://img.shields.io/badge/version-2.1.0_premium-7c5cff?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/platform-Roblox-00e682?style=for-the-badge&logo=roblox" alt="Roblox"/>
  <img src="https://img.shields.io/badge/license-MIT-white?style=for-the-badge" alt="MIT"/>
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> •
  <a href="https://myzakonz-gif.github.io/CatherFI-UI/">Live Demo</a> •
  <a href="#api-lengkap">API</a> •
  <a href="#themes--ganti-realtime">Themes</a>
</p>

> **Roblox Platform UI Library — Loadstring 1 baris** — Roblox Android & PC
> ```lua
> loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/CatherFI-UI/main/CatherFI.lua"))()
> ```
> *Keywords: roblox ui library, delta executor, catherfi ui, roblox script hub*

---

### Preview — Glassmorphism + Neon Gradient

<p align="center">
  <div style="background:linear-gradient(135deg,#0a0a0f 0%,#1a1a2e 50%,#0f2027 100%);border-radius:16px;padding:32px;color:#7c5cff;border:1px solid #282834;margin:16px 0">
    <b>CatherFI Preview</b><br/>
    <span style="color:#8c8c9b">Glassmorphism • Spring Animation • Cyber Neon<br/>Lihat live demo di website → <a href="https://myzakonz-gif.github.io/CatherFI-UI/" style="color:#00dcff">myzakonz-gif.github.io/CatherFI-UI</a></span>
  </div>
</p>
<p align="center"><i>Spring 60fps • Blur Acrylic • Animated Gradient Border • Touch Gesture</i></p>

---

### Fitur Premium CatherFI

| Fitur | Detail |
|-------|--------|
| **Design** | Glassmorphism + Neon Gradient, Corner 16px, Blur Acrylic |
| **Animasi** | Spring Back 60fps, Tween 0.22s smooth |
| **Ringan** | ~1273 lines, optimized, no lag |
| **Mobile** | Full touch, swipe minimize, haptic, gesture |
| **Toast** | Sound + accent bar + type (success/warn/error) |
| **Slider** | Drag + input box edit langsung |
| **Dropdown** | Searchable + multi + check anim |
| **Color** | HSV + preview |
| **Section** | Collapsible + anim |
| **Theme** | 4 tema realtime switch (`SetTheme`) |
| **Palette** | Command palette (Search) |
| **Secure** | cloneref, protect_gui, undetectable |

### Themes — Ganti Realtime

| Cyber (default) | Midnight | Glass | Neon |
|-----------------|----------|-------|------|
| `Theme="Cyber"` | `Theme="Midnight"` | `Theme="Glass"` | `Theme="Neon"` |
| Ungu → Cyan | Amoled hitam pekat | Frost Windows 11 | Hijau → Biru |
| `#7c5cff → #00dcff` | `#fff → #a0a0a0` | `#5a8cff → #8c5aff` | `#00ffaa → #00c8ff` |

```lua
Hub:SetTheme("Neon") -- ganti kapan aja, smooth tween
```

---

### Install

**1. Roblox Platform (recommended)**
```lua
local CatherFI = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/CatherFI-UI/main/CatherFI.lua"))()
```

**2. Raw URL**
```
https://raw.githubusercontent.com/myzakonz-gif/CatherFI-UI/main/CatherFI.lua
```

**3. Legacy (deprecated)**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/CatherFI-UI/main/legacy/CatherFIUI.lua"))()
-- API lama: CreateWindow, CreateTab (pindah ke legacy/)
```

---

### Quick Start — Full Original API

```lua
local CatherFI = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/CatherFI-UI/main/CatherFI.lua"))()

local Hub = CatherFI.New({
    Title = "CatherFI • Roblox Premium",
    Subtitle = "Full Original • by myzakonz • v2.1",
    Theme = "Cyber", -- Cyber / Midnight / Glass / Neon
    Blur = true,
    Size = UDim2.new(0,640,0,460)
})

-- Tab (premium icon pakai rbxassetid)
local Combat = Hub:AddTab({Name="Combat", Icon="rbxassetid://6031265976"})
local Main = Combat:AddSection("COMBAT MAIN", {Collapsible=true})

Main:AddToggle({
    Title="Godmode",
    Desc="Anti-death bypass Roblox",
    Default=false,
    Flag="Godmode",
    Callback=function(v) print("Godmode:",v) end
})

Main:AddSlider({
    Title="Walkspeed",
    Min=16, Max=500, Default=16, Step=1, Suffix="Speed",
    Flag="WS",
    Callback=function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

Main:AddDropdown({
    Title="Weapon",
    Desc="Searchable premium",
    Options={"Katana","Gun","Sword","Blox Fruit"},
    Default="Katana",
    Search=true,
    Callback=function(v) print(v) end
})

Main:AddColor({Title="ESP Color", Default=Color3.fromRGB(124,92,255), Callback=function(c) print(c) end})
Main:AddKeybind({Title="Toggle UI", Default="K", Callback=function(k) print(k) end})
Main:AddButton({Title="Infinite Yield", Callback=function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end})

-- Settings
local Settings = Hub:AddTab({Name="Settings", Icon="rbxassetid://6031280882"})
local S2 = Settings:AddSection("CONFIG")
S2:AddInput({Title="Player Target", Placeholder="Nama player...", Callback=function(t) print(t) end})
S2:AddLabel("CatherFI v2.1 • Premium Edition")
S2:AddParagraph({Title="Info", Desc="Glassmorphism, spring anim, ringan & premium."})
S2:AddDivider()
S2:AddButton({Title="Destroy UI", Callback=function() Hub:Destroy() end})

Hub:Toast({Title="Premium!", Desc="CatherFI loaded 0.9s", Type="success", Duration=3})
```

> Contoh lengkap: [`examples/demo.lua`](./examples/demo.lua) • Legacy di [`legacy/`](./legacy/)

---

### API Lengkap

#### Core
```lua
CatherFI.New({ Title, Subtitle, Theme, Blur=true, Size=UDim2.new(0,640,0,460) }) -> Hub
Hub:AddTab({ Name, Icon="rbxassetid://6031265976" }) -> Tab  -- premium ImageLabel
Tab:AddSection(Name, { Collapsible=false }) -> Section
Hub:Toast({ Title, Desc, Type="success|info|warn|error", Duration=3, Sound=true })
Hub:SetTheme("Cyber") -- realtime
Hub:Destroy()
-- Toggle UI: K / RightControl
```

#### Section Components
| Component | API |
|-----------|-----|
| **Toggle** | `Section:AddToggle({Title, Desc, Default=false, Flag, Callback=function(v) end})` |
| **Button** | `Section:AddButton({Title, Callback})` |
| **Slider** | `Section:AddSlider({Title, Desc, Min, Max, Default, Step=1, Suffix, Flag, Callback})` (+ input box) |
| **Dropdown** | `Section:AddDropdown({Title, Desc, Options, Default, Multi=false, Search=false, Flag, Callback})` |
| **Input** | `Section:AddInput({Title, Placeholder, Default, Callback})` |
| **Color** | `Section:AddColor({Title, Default=Color3, Flag, Callback})` |
| **Keybind** | `Section:AddKeybind({Title, Default="K", Flag, Callback})` |
| **Label** | `Section:AddLabel("text")` |
| **Paragraph** | `Section:AddParagraph({Title, Desc})` |
| **Divider** | `Section:AddDivider()` |

Semua komponen return `{Set, Frame}` untuk update realtime: `toggle:Set(true)`

---

### Website Docs — GitHub Pages

Live preview + playground: **https://myzakonz-gif.github.io/CatherFI-UI/**

Website berisi:
- Interactive mockup (bisa coba toggle/slider langsung di browser)
- Theme switcher live
- Copy loadstring 1-klik
- Fitur premium showcase

File website ada di [`/docs`](./docs) — auto deploy via GitHub Pages (branch `main` / `docs`).

---

### Struktur Repo — Rapi, No Duplikat

```
CatherFI-UI/
├── CatherFI.lua              # Full original v2.1 (1273 lines, utama) — 1 source of truth
├── README.md              # Docs ini
├── LICENSE                # MIT
├── .gitignore
├── docs/
│   ├── index.html         # Website GitHub Pages
│   ├── sitemap.xml
│   ├── robots.txt
│   └── .nojekyll
├── examples/
│   ├── demo.lua           # Contoh premium
│   └── README.md
└── legacy/                # Deprecated, biar root tidak berantakan
    ├── CatherFIUI.lua        # v1 lama (976 lines, jangan pakai baru)
    ├── example-legacy.lua
    └── README.md
```
> **Clean:** Root cuma 1 lib (`CatherFI.lua`), no duplikat, legacy dipisah.

### Roblox Support

- Auto parent: `gethui() > get_hidden_gui() > CoreGui > PlayerGui` — anti kick, cloneref
- `syn.protect_gui` jika ada, secure mode
- Touch + Mouse, drag, swipe, haptic
- No `writefile` dependency, optional config

### Roadmap

- [x] v2.0 Full original, glassmorphism, spring
- [x] v2.1 Secure + cloneref + premium icons + mobile fix
- [x] Website docs + GitHub Pages + SEO
- [ ] v2.2 Command palette `Ctrl+K` + searchable settings
- [ ] v2.3 Plugin system + cloud config sync

### Kontribusi

PR welcome! Fork → branch `feat/...` → PR ke `main`.

### License

MIT © 2026 myzakonz-gif — CatherFI UI. Boleh pakai untuk script Roblox kamu, credit appreciated.

---

### SEO — Biar Gampang Ketemu di Google

CatherFI UI adalah **Modern UI Framework untuk Roblox** yang ringan, premium, dan open source.

Cek live demo: https://myzakonz-gif.github.io/CatherFI-UI/ — terindeks Google via sitemap & robots.txt.

<p align="center"><b>⭐ Star repo kalau suka!</b> • <a href="https://github.com/myzakonz-gif/CatherFI-UI/issues">Report Issue</a></p>
