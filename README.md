<p align="center">
  <img src="https://img.shields.io/github/stars/drcreatordev/CatherFI-UI?style=for-the-badge&logo=github&color=7c5cff" alt="Stars"/>
  <a href="https://drcreatordev.github.io/CatherFI-UI/"><img src="https://img.shields.io/badge/docs-website-00dcff?style=for-the-badge&logo=googlechrome" alt="Docs"/></a>
  <img src="https://img.shields.io/badge/version-2.1-7c5cff?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/license-MIT-white?style=for-the-badge" alt="MIT"/>
</p>

<h1 align="center">CatherFI UI</h1>
<p align="center"><b>UI Library Roblox yang clean, ringan, dan premium — lebih rapi dari Rayfield</b></p>
<p align="center">Coba langsung di browser → <a href="https://drcreatordev.github.io/CatherFI-UI/"><b>drcreatordev.github.io/CatherFI-UI</b></a></p>

---

### 🚀 Install — 1 baris

Copy, paste di executor, langsung jalan:

```lua
local CatherFI = loadstring(game:HttpGet("https://raw.githubusercontent.com/drcreatordev/CatherFI-UI/main/CatherFI.lua"))()
```

> Tidak perlu download. Jalan di HP & PC.

---

### ⚡ Quick Start — 30 detik

```lua
-- 1. Load
local CatherFI = loadstring(game:HttpGet("https://raw.githubusercontent.com/drcreatordev/CatherFI-UI/main/CatherFI.lua"))()

-- 2. Buat window
local Hub = CatherFI.New({
    Title = "Game Hub",
    Subtitle = "CatherFI • v2.1",
    Theme = "Cyber" -- Cyber / Midnight / Glass / Neon
})

-- 3. Buat tab + section
local Tab = Hub:AddTab({Name="Main", Icon="rbxassetid://6031265976"})
local Sec = Tab:AddSection("PLAYER")

-- 4. Tambah komponen
Sec:AddToggle({Title="Godmode", Desc="Kebal damage", Default=false, Callback=function(v) print(v) end})
Sec:AddSlider({Title="Speed", Min=16, Max=200, Default=16, Callback=function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=v end})
Sec:AddDropdown({Title="Weapon", Options={"Sword","Gun"}, Search=true, Callback=function(v) print(v) end})
Sec:AddButton({Title="Hapus UI", Callback=function() Hub:Destroy() end})

Hub:Toast({Title="Loaded!", Desc="CatherFI siap", Type="success"})
```

**Contoh lengkap:** `examples/demo.lua`

---

### ✨ Kenapa CatherFI?

* **Clean & Rapi** — corner 8px, spacing 8px, font Gotham, tidak berlebihan (lebih clean dari Rayfield)
* **Ringan** — ~1300 lines, tidak lag di HP
* **Mobile ready** — otomatis kecil di HP (360x420), drag, touch, minimize rapi tidak melebihi header
* **Lengkap** — Toggle, Slider (ketik angka), Dropdown (search+multi), Color, Keybind, Input, Toast
* **4 Tema** — `Hub:SetTheme("Midnight")` ganti langsung tanpa reload

| Tema | Cocok untuk |
|------|-------------|
| **Cyber** (default) | Modern ungu |
| **Midnight** | Hitam pekat clean |
| **Glass** | Abu-abu profesional |
| **Neon** | Hijau terang |

```lua
Hub:SetTheme("Midnight")
```

---

### 📚 API Singkat

```lua
CatherFI.New({Title, Subtitle, Theme, Size}) -> Hub
Hub:AddTab({Name, Icon}) -> Tab
Tab:AddSection("NAMA") -> Section

Section:AddToggle({Title, Desc, Default, Callback})
Section:AddSlider({Title, Min, Max, Default, Callback})
Section:AddDropdown({Title, Options, Search, Callback})
Section:AddButton({Title, Callback})
Section:AddInput({Title, Placeholder, Callback})
Section:AddColor({Title, Callback})
Section:AddKeybind({Title, Default="K", Callback})
Section:AddLabel("Teks")
Section:AddParagraph({Title, Desc})
Section:AddDivider()

Hub:Toast({Title, Desc, Type="success"}) -- notifikasi
Hub:SetTheme("Cyber") -- ganti tema
Hub:Destroy() -- tutup UI
-- Toggle UI: tekan K / RightControl
```

Detail + video: **https://drcreatordev.github.io/CatherFI-UI/**

---

### 📂 Struktur

```
CatherFI-UI/
├── CatherFI.lua      # 1 file utama, copy saja
├── examples/demo.lua # contoh lengkap
└── docs/index.html   # website
```

---

### ❓ Bantuan

* Error / ide? Buka **Issues** → https://github.com/drcreatordev/CatherFI-UI/issues
* Star repo kalau membantu ⭐

### License

MIT — bebas pakai, credit dihargai.
