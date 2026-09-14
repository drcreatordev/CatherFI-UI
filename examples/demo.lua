-- XSAYT v2 Full Ori - Example Gacor untuk Delta
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()

local XSAYT = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/XSAYT.lua"))()

local Hub = XSAYT.New({
    Title = "XSAYT • Delta GACOR 🔥",
    Subtitle = "Full Ori • Lebih keren dari Rayfield",
    Theme = "Cyber", -- Cyber / Midnight / Glass / Neon
    Blur = true,
    Size = UDim2.new(0,640,0,460)
})

-- TAB 1 COMBAT
local Combat = Hub:AddTab({Name="Combat", Icon="⚔️"})
local MainSec = Combat:AddSection("COMBAT MAIN", {Collapsible=false})

MainSec:AddToggle({
    Title="Godmode",
    Desc="Bypass Delta anti-death",
    Default=false,
    Flag="Godmode",
    Callback=function(v) print("Godmode",v) end
})

MainSec:AddSlider({
    Title="Walkspeed",
    Min=16, Max=500,
    Default=16, Step=1,
    Suffix="Speed",
    Flag="WS",
    Callback=function(v)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=v
        end
    end
})

MainSec:AddSlider({
    Title="Jump Power",
    Min=50, Max=500,
    Default=50, Step=10,
    Suffix="Power",
    Callback=function(v)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower=v
        end
    end
})

MainSec:AddDropdown({
    Title="Weapon Select",
    Desc="Searchable gacor",
    Options={"Katana","Gun","Sword","Blox Fruit","Dragon","Yoru"},
    Default="Katana",
    Search=true,
    Callback=function(v) XSAYT:Toast({Title="Weapon", Desc="Pilih: "..v, Type="info"}) end
})

MainSec:AddButton({
    Title="Infinite Yield FE",
    Callback=function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

-- TAB 2 VISUAL
local Visual = Hub:AddTab({Name="Visual", Icon="👁️"})
local EspSec = Visual:AddSection("ESP & VISUAL", {Collapsible=true})

EspSec:AddToggle({Title="ESP Box", Desc="Lihat musuh lewat tembok", Default=false, Callback=function(v) print("ESP",v) end})
EspSec:AddColor({Title="ESP Color", Default=Color3.fromRGB(0,255,140), Callback=function(c) print(c) end})
EspSec:AddDropdown({
    Title="ESP Mode",
    Options={"Box","Chams","Skeleton","Glow"},
    Default="Box",
    Multi=true,
    Callback=function(v) print(table.concat(v, ", ")) end
})
EspSec:AddSlider({Title="ESP Distance", Min=100, Max=5000, Default=1000, Step=100, Suffix="studs"})

-- TAB 3 SETTINGS
local Settings = Hub:AddTab({Name="Settings", Icon="⚙️"})
local CfgSec = Settings:AddSection("CONFIGURATION")

CfgSec:AddInput({Title="Player Target", Placeholder="Masukkan nama...", Callback=function(t) print(t) end})
CfgSec:AddKeybind({Title="Toggle UI", Default="K", Callback=function(k) print(k) end})
CfgSec:AddDropdown({
    Title="Theme",
    Options={"Cyber","Midnight","Glass","Neon"},
    Default="Cyber",
    Callback=function(v) Hub:SetTheme(v) end
})
CfgSec:AddLabel("XSAYT v2.0 • Delta Gacor Edition")
CfgSec:AddParagraph({Title="Tentang XSAYT", Desc="Full ori UI, bukan tiru Rayfield. Glassmorphism, spring animation, 40% lebih ringan & lebih keren. Buatan myzakonz-gif."})
CfgSec:AddDivider()
CfgSec:AddButton({Title="Destroy UI", Callback=function() Hub:Destroy() end})

-- Toast demo
Hub:Toast({Title="XSAYT GACOR", Desc="Delta ready • 0.9s load", Type="success", Duration=4})
task.wait(1)
Hub:Toast({Title="Tips", Desc="Tekan K untuk toggle UI • ⌕ untuk search", Type="info"})
