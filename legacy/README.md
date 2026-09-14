# Legacy — Rayfield-compatible (Deprecated)

Folder ini berisi versi lama **XsaytUI.lua** yang API-nya mirip Rayfield (`CreateWindow`/`CreateTab`).

**Status:** `DEPRECATED` — dipindah kesini biar root rapi & gak duplikat dengan `XSAYT.lua` full ori.

- `XsaytUI.lua` — 976 lines, Rayfield-like, jangan pakai untuk project baru
- `example-legacy.lua` — contoh legacy

**Gunakan yang baru:**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()
-- XSAYT.New({Title, Theme}) -> Hub:AddTab -> Section:AddToggle
```

File ini tetap ada biar link lama tidak 404, tapi tidak direkomendasikan.
