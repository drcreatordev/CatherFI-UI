<p align="center">
  <div style="background:linear-gradient(135deg,#0a0a0f 0%,#1a1a2e 50%,#0f2027 100%);border-radius:16px;padding:28px;border:1px solid #282834">
    <div style="font-size:28px;font-weight:900;letter-spacing:-1px;background:linear-gradient(135deg,#7c5cff 0%,#00dcff 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent">XSAYT UI</div>
    <div style="color:#8c8c9b;font-size:13px;margin-top:4px">Delta Gacor Edition • Glassmorphism • Spring 60fps • Full Ori</div>
  </div>
</p>

<h1 align="center">XSAYT UI — Roblox Delta Executor UI Library v2</h1>
<p align="center"><b>Roblox UI Library Premium untuk Delta Executor • Full Ori • Rayfield Alternative • Lebih Ringan 40%</b></p>
<p align="center"><i>Delta Executor • Roblox UI Library • Rayfield Alternative • Roblox Script Hub</i></p>

<p align="center">
  <a href="https://github.com/myzakonz-gif/UI-LIB-XSAYT"><img src="https://img.shields.io/github/stars/myzakonz-gif/UI-LIB-XSAYT?style=for-the-badge&logo=github&color=7c5cff" alt="Stars"/></a>
  <a href="https://myzakonz-gif.github.io/UI-LIB-XSAYT/"><img src="https://img.shields.io/badge/docs-website-00dcff?style=for-the-badge&logo=googlechrome" alt="Docs"/></a>
  <img src="https://img.shields.io/badge/version-2.0.0_gacor-7c5cff?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/platform-Delta-00e682?style=for-the-badge&logo=roblox" alt="Delta"/>
  <img src="https://img.shields.io/badge/license-MIT-white?style=for-the-badge" alt="MIT"/>
</p>

<p align="center">
  <a href="#-quick-start">Quick Start</a> •
  <a href="https://myzakonz-gif.github.io/UI-LIB-XSAYT/">Live Demo</a> •
  <a href="#-api">API</a> •
  <a href="#-themes">Themes</a> •
  <a href="#-vs-rayfield">vs Rayfield</a>
</p>

> **Roblox Delta Executor UI Library — Loadstring 1 baris** — Delta Android & PC • Rayfield Alternative
> ```lua
> loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()
> ```
> *Keywords: roblox ui library, delta executor, rayfield alternative, xsayt ui, roblox script hub*

---

### Preview — Glassmorphism + Neon Gradient

<p align="center">
  <div style="background:linear-gradient(135deg,#0a0a0f 0%,#1a1a2e 50%,#0f2027 100%);border-radius:16px;padding:32px;color:#7c5cff;border:1px solid #282834;margin:16px 0">
    <b>XSAYT Preview</b><br/>
    <span style="color:#8c8c9b">Glassmorphism • Spring Animation • Cyber Neon<br/>Lihat live demo di website → <a href="https://myzakonz-gif.github.io/UI-LIB-XSAYT/" style="color:#00dcff">myzakonz-gif.github.io/UI-LIB-XSAYT</a></span>
  </div>
</p>
<p align="center"><i>Spring 60fps • Blur Acrylic • Animated Gradient Border • Touch Gesture</i></p>

---

### Kenapa XSAYT Lebih Gacor Dari Rayfield?

| Fitur | XSAYT v2 (Ori) | Rayfield |
|-------|:--------------:|:--------:|
| **Design** | Glassmorphism + Neon Gradient, Corner 16px, Blur | Flat dark, kaku |
| **Animasi** | Spring Back 60fps, Tween 0.22s | Quad linear, patah-patah |
| **Ringan** | ~950 lines, 40% lebih enteng, no lag | ~1800+ lines, berat |
| **Mobile** | Full touch, swipe minimize, haptic, gesture | Buggy di Delta Android |
| **Toast** | Sound + accent bar + type (success/warn/error) | Notify basic |
| **Slider** | Drag + input box edit langsung | Cuma drag |
| **Dropdown** | Searchable + multi + check anim | Basic |
| **Color** | HSV + preview | Random cycle |
| **Section** | Collapsible + anim | Static |
| **Theme** | 4 tema realtime switch (`SetTheme`) | 1 tema doang |
| **Palette** | Command palette (Search) | Gak ada |

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

**1. Delta Executor (recommended)**
```lua
local XSAYT = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()
```

**2. Raw URL**
```
https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua
```

**3. Legacy Rayfield-compatible (deprecated)**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/legacy/XsaytUI.lua"))()
-- API lama: CreateWindow, CreateTab (pindah ke legacy/)
```

---

### Quick Start — Full Ori API

```lua
local XSAYT = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()

local Hub = XSAYT.New({
    Title = "XSAYT • Delta Premium",
    Subtitle = "Full Ori • by myzakonz • v2.0",
    Theme = "Cyber", -- Cyber / Midnight / Glass / Neon
    Blur = true,
    Size = UDim2.new(0,640,0,460)
})

-- Tab (premium icon pakai rbxassetid, bukan emoji)
local Combat = Hub:AddTab({Name="Combat", Icon="rbxassetid://6031265976"})
local Main = Combat:AddSection("COMBAT MAIN", {Collapsible=true})

Main:AddToggle({
    Title="Godmode",
    Desc="Anti-death bypass Delta",
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
    Desc="Searchable gacor",
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
S2:AddLabel("XSAYT v2 • Lebih gacor dari Rayfield 😎")
S2:AddParagraph({Title="Info", Desc="Glassmorphism, spring anim, 40% lebih ringan."})
S2:AddDivider()
S2:AddButton({Title="Destroy UI", Callback=function() Hub:Destroy() end})

Hub:Toast({Title="GACOR!", Desc="XSAYT loaded 0.9s", Type="success", Duration=3})
```

> Contoh lengkap: [`examples/demo.lua`](./examples/demo.lua) • Legacy di [`legacy/`](./legacy/)

---

### API Lengkap

#### Core
```lua
XSAYT.New({ Title, Subtitle, Theme, Blur=true, Size=UDim2.new(0,640,0,460) }) -> Hub
Hub:AddTab({ Name, Icon="rbxassetid://6031265976" }) -> Tab  -- premium ImageLabel, bukan emoji
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

Live preview + playground: **https://myzakonz-gif.github.io/UI-LIB-XSAYT/**

Website berisi:
- Interactive mockup (bisa coba toggle/slider langsung di browser)
- Theme switcher live
- Copy loadstring 1-klik
- Perbandingan vs Rayfield

File website ada di [`/docs`](./docs) — auto deploy via GitHub Pages (branch `main` / `docs`).

---

### Struktur Repo — Rapi, No Duplikat

```
UI-LIB-XSAYT/
├── XSAYT.lua              # Full ori v2 (1154 lines, utama) — 1 source of truth
├── README.md              # Docs ini
├── LICENSE                # MIT
├── .gitignore
├── docs/
│   ├── index.html         # Website GitHub Pages (1 file, no duplikat)
│   └── .nojekyll
├── examples/
│   ├── demo.lua           # Contoh full ori gacor
│   └── README.md
└── legacy/                # Deprecated, biar root tidak berantakan
    ├── XsaytUI.lua        # Rayfield-like lama (976 lines, jangan pakai baru)
    ├── example-legacy.lua
    └── README.md
```
> **Clean:** Root cuma 1 lib (`XSAYT.lua`), no duplikat `index.html`, legacy dipisah.

### Delta Support

- Auto parent: `gethui() > get_hidden_gui() > CoreGui > PlayerGui` — anti kick
- `syn.protect_gui` jika ada
- Touch + Mouse, drag, swipe, haptic
- No `writefile` dependency, optional config

### Roadmap

- [x] v2.0 Full ori, glassmorphism, spring
- [x] Website docs + GitHub Pages
- [ ] v2.1 Command palette `Ctrl+K` + searchable settings
- [ ] v2.2 Plugin system + cloud config sync
- [ ] v2.3 Graph/Chart + Console component

### Kontribusi

PR welcome! Fork → branch `feat/...` → PR ke `main`.

### License

MIT © 2026 myzakonz-gif — XSAYT UI. Boleh pakai untuk script Delta kamu, credit appreciated.

---

### SEO — Biar Gampang Ketemu di Google

XSAYT UI adalah **Roblox UI Library untuk Delta Executor** terbaik sebagai **Rayfield alternative**. Cocok untuk `roblox script hub`, `delta executor script`, `roblox lua ui`. Cari di Google: `xsayt ui`, `roblox delta ui library`, `rayfield alternative`, `delta executor ui`.

Cek live demo: https://myzakonz-gif.github.io/UI-LIB-XSAYT/ — terindeks Google via sitemap & robots.txt.

<p align="center"><b>⭐ Star repo kalau gacor!</b> • <a href="https://github.com/myzakonz-gif/UI-LIB-XSAYT/issues">Report Issue</a></p>
