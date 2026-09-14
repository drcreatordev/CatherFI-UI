-- CatherFI v2 Full Ori - Example Premium untuk Roblox
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/drcreatordev/CatherFI-UI/main/CatherFI.lua"))()

local CatherFI = loadstring(game:HttpGet("https://raw.githubusercontent.com/drcreatordev/CatherFI-UI/main/CatherFI.lua"))()

local Hub = CatherFI.New({
    Title = "CatherFI • Roblox Premium",
    Subtitle = "Full Ori • Premium Icons",
    Theme = "Cyber", -- Cyber / Midnight / Glass / Neon
    Blur = true,
    Size = UDim2.new(0,640,0,460)
})

-- TAB 1 COMBAT (premium ImageLabel icons, bukan emoji)
local Combat = Hub:AddTab({Name="Combat", Icon="rbxassetid://6031265976"})
local MainSec = Combat:AddSection("COMBAT MAIN", {Collapsible=false})

MainSec:AddToggle({
    Title="Godmode",
    Desc="Bypass Roblox anti-death",
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
    Desc="Searchable premium",
    Options={"Katana","Gun","Sword","Blox Fruit","Dragon","Yoru"},
    Default="Katana",
    Search=true,
    Callback=function(v) CatherFI:Toast({Title="Weapon", Desc="Pilih: "..v, Type="info"}) end
})

MainSec:AddButton({
    Title="Infinite Yield FE",
    Callback=function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

-- TAB 2 VISUAL
local Visual = Hub:AddTab({Name="Visual", Icon="rbxassetid://6031075938"})
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
local Settings = Hub:AddTab({Name="Settings", Icon="rbxassetid://6031280882"})
local CfgSec = Settings:AddSection("CONFIGURATION")

CfgSec:AddInput({Title="Player Target", Placeholder="Masukkan nama...", Callback=function(t) print(t) end})
CfgSec:AddKeybind({Title="Toggle UI", Default="K", Callback=function(k) print(k) end})
CfgSec:AddDropdown({
    Title="Theme",
    Options={"Cyber","Midnight","Glass","Neon"},
    Default="Cyber",
    Callback=function(v) Hub:SetTheme(v) end
})
CfgSec:AddLabel("CatherFI v2.0 • Roblox Premium Edition")
CfgSec:AddParagraph({Title="Tentang CatherFI", Desc="Full ori premium, ImageLabel icons, glassmorphism, spring animation, 40% lebih ringan. Buatan drcreatordev."})
CfgSec:AddDivider()
CfgSec:AddButton({Title="Destroy UI", Callback=function() Hub:Destroy() end})

-- Toast demo
Hub:Toast({Title="CatherFI Premium", Desc="Roblox ready • 0.9s load", Type="success", Duration=4})
task.wait(1)
Hub:Toast({Title="Tips", Desc="Tekan K untuk toggle UI • search di header", Type="info"})
