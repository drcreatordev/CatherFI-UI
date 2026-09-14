-- CatherFI UI v2 | Full Original | Roblox Premium Edition
-- Original Design by myzakonz-gif - Professional UI Library
-- Cyber Neon + Glassmorphism + Spring Animations
-- Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/CatherFI-UI/main/CatherFI.lua"))()
-- Docs: https://github.com/myzakonz-gif/CatherFI-UI
-- Size: ~1273 lines, 60fps, Roblox Android Optimized

local CatherFI = {}
CatherFI.Version = "2.1.0-gacor-secure"
CatherFI.Flags = {}
-- Fallback untuk executor yang tidak punya typeof/table.find
local typeof = typeof or type
local tableFind = (rawget(table, "find")) or function(t, v)
    for i,x in ipairs(t) do if x==v then return i end end
    return nil
end

-- Themes - Original CatherFI Premium
CatherFI.Themes = {
    Cyber = {
        Bg = Color3.fromRGB(10,10,15),
        Bg2 = Color3.fromRGB(16,16,22),
        Sidebar = Color3.fromRGB(13,13,18),
        Card = Color3.fromRGB(22,22,28),
        CardHover = Color3.fromRGB(28,28,36),
        Stroke = Color3.fromRGB(40,40,52),
        Text = Color3.fromRGB(245,245,250),
        Sub = Color3.fromRGB(140,140,155),
        Accent = Color3.fromRGB(124,92,255),
        Accent2 = Color3.fromRGB(0,220,255),
        Success = Color3.fromRGB(0,230,130),
        Warn = Color3.fromRGB(255,180,0),
        Error = Color3.fromRGB(255,70,90),
    },
    Midnight = {
        Bg = Color3.fromRGB(0,0,0),
        Bg2 = Color3.fromRGB(10,10,10),
        Sidebar = Color3.fromRGB(6,6,6),
        Card = Color3.fromRGB(18,18,18),
        CardHover = Color3.fromRGB(24,24,24),
        Stroke = Color3.fromRGB(30,30,30),
        Text = Color3.fromRGB(255,255,255),
        Sub = Color3.fromRGB(130,130,130),
        Accent = Color3.fromRGB(255,255,255),
        Accent2 = Color3.fromRGB(160,160,160),
        Success = Color3.fromRGB(0,255,120),
        Warn = Color3.fromRGB(255,200,0),
        Error = Color3.fromRGB(255,50,50),
    },
    Glass = {
        Bg = Color3.fromRGB(18,20,28),
        Bg2 = Color3.fromRGB(22,24,34),
        Sidebar = Color3.fromRGB(16,18,26),
        Card = Color3.fromRGB(30,32,42),
        CardHover = Color3.fromRGB(36,38,50),
        Stroke = Color3.fromRGB(50,52,70),
        Text = Color3.fromRGB(240,242,255),
        Sub = Color3.fromRGB(150,155,180),
        Accent = Color3.fromRGB(90,140,255),
        Accent2 = Color3.fromRGB(140,90,255),
        Success = Color3.fromRGB(60,220,150),
        Warn = Color3.fromRGB(255,190,60),
        Error = Color3.fromRGB(255,90,110),
    },
    Neon = {
        Bg = Color3.fromRGB(8,12,16),
        Bg2 = Color3.fromRGB(12,18,24),
        Sidebar = Color3.fromRGB(10,15,20),
        Card = Color3.fromRGB(18,26,32),
        CardHover = Color3.fromRGB(24,34,42),
        Stroke = Color3.fromRGB(35,50,65),
        Text = Color3.fromRGB(220,255,245),
        Sub = Color3.fromRGB(110,160,150),
        Accent = Color3.fromRGB(0,255,170),
        Accent2 = Color3.fromRGB(0,200,255),
        Success = Color3.fromRGB(0,255,150),
        Warn = Color3.fromRGB(255,230,0),
        Error = Color3.fromRGB(255,60,120),
    }
}

-- Premium Icon Assets (no cheap emoji, all ImageLabel)
CatherFI.Icons = {
    Search      = "rbxassetid://6031158108", -- magnify
    Minimize    = "rbxassetid://6031091003", -- minus
    Close       = "rbxassetid://6031090997", -- x
    ChevronDown = "rbxassetid://6031090997", -- chevron (rotated)
    ChevronRight= "rbxassetid://6031090997",
    ArrowRight  = "rbxassetid://6031090997",
    Combat      = "rbxassetid://6031265976", -- swords
    Visual      = "rbxassetid://6031075938", -- eye
    Settings    = "rbxassetid://6031280882", -- settings
    DefaultTab  = "rbxassetid://4483345998",
}

-- Professional hardening (cloneref, secure, asset, request) - undetectable & robust
local requestsDisabled = false
local customAssetId = nil
local secureMode = false
if getgenv then
    local ok, v = pcall(function() return getgenv().DISABLE_CATHERFI_REQUESTS end)
    if ok and v then requestsDisabled = true end
    local ok2, v2 = pcall(function() return getgenv().CATHERFI_ASSET_ID end)
    if ok2 and typeof(v2)=="number" then customAssetId = v2 end
    local ok3, v3 = pcall(function() return getgenv().CATHERFI_SECURE end)
    if ok3 and v3 then secureMode = true end
    local ok4, v4 = pcall(function() return getgenv().CATHERFI_SECURE_LEGACY end)
    if ok4 and v4 then secureMode = true end
end
if secureMode then
    local _err, _assert = error, assert
    warn = function() end
    print = function() end
    error = function(_, lvl) _err("", lvl) end
    assert = function(v, ...) return _assert(v) end
end

local function getService(name)
    local svc = game:GetService(name)
    return (cloneref and cloneref(svc)) or svc
end
local function loadWithTimeout(url, timeout)
    timeout = timeout or 5
    local done, ok, res = false, false, nil
    local th = task.spawn(function()
        local s, r = pcall(game.HttpGet, game, url)
        if not s or #r==0 then ok,res = false, r or "Empty response"; done=true; return end
        local s2, r2 = pcall(function() return loadstring(r)() end)
        ok,res = s2,r2; done=true
    end)
    local to = task.delay(timeout, function()
        if not done then warn("[CatherFI] Timeout "..url); task.cancel(th); res="Timeout"; done=true end
    end)
    while not done do task.wait() end
    if to and coroutine.status(to) ~= "dead" then pcall(function() task.cancel(to) end) end
    if ok then return res else return nil end
end

local TweenService = getService("TweenService")
local UserInputService = getService("UserInputService")
local Players = getService("Players")
local CoreGui = getService("CoreGui")
local HttpService = getService("HttpService")
local RunService = getService("RunService")
local function GetLocalPlayer()
    local lp = Players.LocalPlayer
    if lp then return lp end
    local ok, plr = pcall(function() return game.Players.LocalPlayer end)
    if ok and plr then return plr end
    -- tunggu jika belum load
    pcall(function()
        if Players.GetPropertyChangedSignal then
            repeat
                task.wait(0.1)
                lp = Players.LocalPlayer
            until lp
            return lp
        end
    end)
    return lp or Players.LocalPlayer
end
local LocalPlayer = GetLocalPlayer()

local function CreateIcon(parent, assetId, size, color)
    local img = Instance.new("ImageLabel", parent)
    img.BackgroundTransparency = 1
    img.Image = assetId
    img.ImageColor3 = color or Color3.fromRGB(255,255,255)
    img.Size = size or UDim2.new(0,16,0,16)
    img.ScaleType = Enum.ScaleType.Fit
    return img
end

local function Tween(o, props, t, s, d)
    local info = TweenInfo.new(t or 0.22, s or Enum.EasingStyle.Quad, d or Enum.EasingDirection.Out)
    local tw = TweenService:Create(o, info, props)
    tw:Play()
    return tw
end
local function Spring(o, props) -- gacor spring
    Tween(o, props, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end
local function Corner(p, r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 12) c.Parent=p return c end
local function Stroke(p, col, th) local s=Instance.new("UIStroke") s.Color=col s.Thickness=th or 1 s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Parent=p return s end
local function Padding(p, l,t,r,b) local pad=Instance.new("UIPadding") pad.PaddingLeft=UDim.new(0,l or 0) pad.PaddingTop=UDim.new(0,t or 0) pad.PaddingRight=UDim.new(0,r or 0) pad.PaddingBottom=UDim.new(0,b or 0) pad.Parent=p return pad end

local function MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true dragStart=input.Position startPos=frame.Position
            input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input==dragInput and dragging then
            local delta=input.Position-dragStart
            Tween(frame,{Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)},0.12)
        end
    end)
end

-- Toast System - Professional Notification, undetectable CoreGui via cloneref
local ToastGui
local function GetToastGui()
    if ToastGui and ToastGui.Parent then return ToastGui end
    local pg
    pcall(function()
        if gethui then pg=gethui()
        elseif get_hidden_gui then pg=get_hidden_gui()
        elseif CoreGui then pg=CoreGui
        elseif game.CoreGui then pg=game.CoreGui end
    end)
    if not pg then pg=LocalPlayer:WaitForChild("PlayerGui") end
    if pg and cloneref then pcall(function() pg = cloneref(pg) end) end
    ToastGui=Instance.new("ScreenGui")
    ToastGui.Name="CatherFI_Toast"
    ToastGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    ToastGui.ResetOnSpawn=false
    ToastGui.IgnoreGuiInset = true
    ToastGui.DisplayOrder = 999
    pcall(function()
        if customAssetId and ToastGui then ToastGui.Name = "CatherFI_"..tostring(customAssetId) end
    end)
    ToastGui.Parent=pg
    if syn and syn.protect_gui then pcall(function() syn.protect_gui(ToastGui) end) end
    return ToastGui
end

function CatherFI:Toast(cfg)
    cfg=cfg or {}
    local gui=GetToastGui()
    local theme = CatherFI.Themes[cfg.Theme or "Cyber"] or CatherFI.Themes.Cyber
    local typeColors = {success=theme.Success, warn=theme.Warn, error=theme.Error, info=theme.Accent}
    local col = typeColors[cfg.Type or "info"] or theme.Accent

    local holder=Instance.new("Frame", gui)
    holder.Size=UDim2.new(0,320,0,70)
    holder.Position=UDim2.new(1,-340,1,20)
    holder.BackgroundColor3=theme.Card
    holder.BackgroundTransparency=0.1
    Corner(holder,14); Stroke(holder, theme.Stroke,1)
    Padding(holder,14,12,14,12)

    -- accent bar
    local bar=Instance.new("Frame", holder)
    bar.Size=UDim2.new(0,4,1,-24)
    bar.Position=UDim2.new(0,0,0,12)
    bar.BackgroundColor3=col
    Corner(bar,99)

    local title=Instance.new("TextLabel", holder)
    title.Text=cfg.Title or "CatherFI"
    title.Font=Enum.Font.GothamBold
    title.TextSize=14
    title.TextColor3=theme.Text
    title.BackgroundTransparency=1
    title.Size=UDim2.new(1,-30,0,16)
    title.Position=UDim2.new(0,16,0,0)
    title.TextXAlignment=Enum.TextXAlignment.Left

    local desc=Instance.new("TextLabel", holder)
    desc.Text=cfg.Desc or cfg.Content or ""
    desc.Font=Enum.Font.Gotham
    desc.TextSize=12
    desc.TextColor3=theme.Sub
    desc.BackgroundTransparency=1
    desc.Size=UDim2.new(1,-30,0,30)
    desc.Position=UDim2.new(0,16,0,20)
    desc.TextXAlignment=Enum.TextXAlignment.Left
    desc.TextYAlignment=Enum.TextYAlignment.Top
    desc.TextWrapped=true

    -- sound
    if cfg.Sound ~= false then
        pcall(function()
            local s=Instance.new("Sound", holder)
            s.SoundId = cfg.Type=="error" and "rbxassetid://12222030" or cfg.Type=="success" and "rbxassetid://12222025" or "rbxassetid://12222016"
            s.Volume=0.6; s.PlayOnRemove=true; s:Destroy()
        end)
    end

    Spring(holder, {Position=UDim2.new(1,-340,1,-90)})
    task.delay(cfg.Duration or 3, function()
        Tween(holder,{Position=UDim2.new(1,10,1,-90)},0.3)
        task.wait(0.35); holder:Destroy()
    end)
end

-- Compatibility alias
CatherFI.Notify = CatherFI.Toast

-- Config helpers (robust, with HttpService, timeout, cloneref safe)
local function SaveConfig(folder, file, flags)
    if requestsDisabled then return end
    if not (writefile and makefolder and isfolder) then return end
    pcall(function()
        if not isfolder(folder) then makefolder(folder) end
        local json = HttpService:JSONEncode(flags)
        writefile(folder.."/"..file..".json", json)
    end)
end
local function LoadConfig(folder, file)
    if requestsDisabled then return nil end
    if not (readfile and isfile) then return nil end
    local ok, data = pcall(function()
        if isfile(folder.."/"..file..".json") then
            return HttpService:JSONDecode(readfile(folder.."/"..file..".json"))
        end
    end)
    if ok then return data end
    return nil
end
function CatherFI:LoadConfiguration(folder, file)
    if not folder then return nil end
    return LoadConfig(folder, file or "config")
end
function CatherFI:SaveConfiguration(folder, file, flags)
    SaveConfig(folder or "CatherFI", file or "config", flags or CatherFI.Flags)
end

function CatherFI.New(a, b)
    -- support both CatherFI.New(cfg) and CatherFI:New(cfg)
    local cfg = b or a
    if a == CatherFI and b then cfg = b end
    if typeof(cfg) ~= "table" then cfg = {} end
    cfg=cfg or {}
    local title=cfg.Title or "CatherFI • Premium"
    local subtitle=cfg.Subtitle or "Roblox Edition • v2.1"
    local themeName=cfg.Theme or "Cyber"
    local theme=CatherFI.Themes[themeName] or CatherFI.Themes.Cyber
    local blurEnabled=cfg.Blur ~= false
    local size=cfg.Size or UDim2.new(0,640,0,460)

    -- Parent (Gen2-grade: cloneref + protect_gui + customAsset) - robust untuk Roblox
    local parent
    pcall(function()
        if gethui then parent=gethui()
        elseif get_hidden_gui then parent=get_hidden_gui()
        elseif CoreGui then parent=CoreGui
        elseif game.CoreGui then parent=game.CoreGui end
    end)
    if not parent then
        local lp = GetLocalPlayer()
        if lp then
            local ok, pg = pcall(function() return lp:WaitForChild("PlayerGui") end)
            if ok and pg then parent = pg else parent = lp:FindFirstChild("PlayerGui") or lp end
        end
    end
    if not parent then
        -- fallback terakhir: coba game.CoreGui
        pcall(function() parent = game:GetService("CoreGui") end)
    end
    if parent and cloneref then pcall(function() parent = cloneref(parent) end) end
    if not parent then
        warn("[CatherFI] Parent tidak ditemukan, fallback ke PlayerGui")
        local lp2 = GetLocalPlayer()
        if lp2 then parent = lp2:FindFirstChildOfClass("PlayerGui") or lp2 end
    end

    local Gui=Instance.new("ScreenGui")
    Gui.Name="CatherFI_"..tostring(math.random(10000,99999))
    if customAssetId then Gui.Name = "CatherFI_"..tostring(customAssetId) end
    Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    Gui.ResetOnSpawn=false
    Gui.IgnoreGuiInset = true
    Gui.DisplayOrder = 10
    -- handle Disable prompts (professional)
    if not secureMode then
        -- keep warn for debugging unless disabled
        if cfg.DisableBuildWarnings then warn = function() end end
    end
    Gui.Parent=parent
    if syn and syn.protect_gui then pcall(function() syn.protect_gui(Gui) end) end
    if gethui then pcall(function() Gui.Parent = cloneref and cloneref(gethui()) or gethui() end) end

    -- Loading (gacor)
    local Loading=Instance.new("Frame", Gui)
    Loading.Size=UDim2.new(0,380,0,180)
    Loading.Position=UDim2.new(0.5,-190,0.5,-90)
    Loading.BackgroundColor3=theme.Bg
    Corner(Loading,16); Stroke(Loading, theme.Stroke,1)
    local loadGrad=Instance.new("UIGradient", Loading)
    loadGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,theme.Accent), ColorSequenceKeypoint.new(1,theme.Accent2)}
    loadGrad.Rotation=35; loadGrad.Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,0.85), NumberSequenceKeypoint.new(1,0.95)}
    -- keep subtle

    local loadTitle=Instance.new("TextLabel", Loading)
    loadTitle.Text=title
    loadTitle.Font=Enum.Font.GothamBold
    loadTitle.TextSize=20
    loadTitle.TextColor3=theme.Text
    loadTitle.BackgroundTransparency=1
    loadTitle.Size=UDim2.new(1,0,0,30)
    loadTitle.Position=UDim2.new(0,0,0,30)

    local loadSub=Instance.new("TextLabel", Loading)
    loadSub.Text=subtitle
    loadSub.Font=Enum.Font.Gotham
    loadSub.TextSize=12
    loadSub.TextColor3=theme.Sub
    loadSub.BackgroundTransparency=1
    loadSub.Size=UDim2.new(1,0,0,20)
    loadSub.Position=UDim2.new(0,0,0,60)

    local barBG=Instance.new("Frame", Loading)
    barBG.Size=UDim2.new(0.7,0,0,6)
    barBG.Position=UDim2.new(0.15,0,0,110)
    barBG.BackgroundColor3=theme.Card
    Corner(barBG,99)
    local bar=Instance.new("Frame", barBG)
    bar.Size=UDim2.new(0,0,1,0)
    bar.BackgroundColor3=theme.Accent
    Corner(bar,99)
    local barGrad=Instance.new("UIGradient", bar)
    barGrad.Color=ColorSequence.new(theme.Accent, theme.Accent2)
    Tween(bar,{Size=UDim2.new(1,0,1,0)},0.9, Enum.EasingStyle.Quad)

    local loadInfo=Instance.new("TextLabel", Loading)
    loadInfo.Text="Loading CatherFI engine..."
    loadInfo.Font=Enum.Font.Gotham
    loadInfo.TextSize=11
    loadInfo.TextColor3=theme.Sub
    loadInfo.BackgroundTransparency=1
    loadInfo.Size=UDim2.new(1,0,0,16)
    loadInfo.Position=UDim2.new(0,0,0,135)
    task.spawn(function()
        local dots={"...", "..", ".", "..", "..."}
        for i=1,6 do loadInfo.Text="Loading CatherFI engine"..dots[(i%#dots)+1]; task.wait(0.15) end
        loadInfo.Text="GACOR ready!"
        loadInfo.TextColor3=theme.Success
    end)

    -- Main Hub
    local Main=Instance.new("Frame", Gui)
    Main.Name="Main"
    Main.Size=UDim2.new(0,620,0,440)
    Main.Position=UDim2.new(0.5,-320,0.5,-220)
    Main.BackgroundColor3=theme.Bg
    Main.Visible=false
    Corner(Main,16); Stroke(Main, theme.Stroke,1)
    MakeDraggable(Main)

    -- Top gradient border
    local TopLine=Instance.new("Frame", Main)
    TopLine.Size=UDim2.new(1,0,0,2)
    TopLine.Position=UDim2.new(0,0,0,0)
    TopLine.BackgroundColor3=theme.Accent
    Corner(TopLine,99)
    local topGrad=Instance.new("UIGradient", TopLine)
    topGrad.Color=ColorSequence.new(theme.Accent, theme.Accent2)
    topGrad.Rotation=0
    -- animate gradient
    task.spawn(function()
        while Main.Parent do
            Tween(topGrad,{Rotation=180},2, Enum.EasingStyle.Linear)
            task.wait(2)
            Tween(topGrad,{Rotation=360},2, Enum.EasingStyle.Linear)
            task.wait(2)
            topGrad.Rotation=0
        end
    end)

    -- Blur background if enabled (fake blur with transparency)
    if blurEnabled then
        Main.BackgroundTransparency=0.05
    end

    -- Header
    local Header=Instance.new("Frame", Main)
    Header.Size=UDim2.new(1,0,0,56)
    Header.BackgroundColor3=theme.Bg2
    Corner(Header,16)
    local hFix=Instance.new("Frame", Header)
    hFix.Size=UDim2.new(1,0,0,16)
    hFix.Position=UDim2.new(0,0,1,-16)
    hFix.BackgroundColor3=theme.Bg2
    hFix.BorderSizePixel=0
    hFix.ZIndex=0

    -- Logo Icon (XS)
    local Logo=Instance.new("Frame", Header)
    Logo.Size=UDim2.new(0,36,0,36)
    Logo.Position=UDim2.new(0,12,0,10)
    Logo.BackgroundColor3=theme.Accent
    Corner(Logo,10)
    local logoGrad=Instance.new("UIGradient", Logo)
    logoGrad.Color=ColorSequence.new(theme.Accent, theme.Accent2)
    logoGrad.Rotation=45
    local logoTxt=Instance.new("TextLabel", Logo)
    logoTxt.Text="X"
    logoTxt.Font=Enum.Font.GothamBlack
    logoTxt.TextSize=18
    logoTxt.TextColor3=Color3.new(1,1,1)
    logoTxt.BackgroundTransparency=1
    logoTxt.Size=UDim2.new(1,0,1,0)

    local TitleLb=Instance.new("TextLabel", Header)
    TitleLb.Text=title
    TitleLb.Font=Enum.Font.GothamBold
    TitleLb.TextSize=15
    TitleLb.TextColor3=theme.Text
    TitleLb.BackgroundTransparency=1
    TitleLb.Size=UDim2.new(0,260,0,20)
    TitleLb.Position=UDim2.new(0,56,0,10)
    TitleLb.TextXAlignment=Enum.TextXAlignment.Left

    local SubLb=Instance.new("TextLabel", Header)
    SubLb.Text=subtitle
    SubLb.Font=Enum.Font.Gotham
    SubLb.TextSize=11
    SubLb.TextColor3=theme.Sub
    SubLb.BackgroundTransparency=1
    SubLb.Size=UDim2.new(0,260,0,14)
    SubLb.Position=UDim2.new(0,56,0,28)
    SubLb.TextXAlignment=Enum.TextXAlignment.Left

    -- Header Actions (premium icons, no emoji)
    local SearchBtn=Instance.new("TextButton", Header)
    SearchBtn.Size=UDim2.new(0,32,0,32)
    SearchBtn.Position=UDim2.new(1,-120,0,12)
    SearchBtn.BackgroundColor3=theme.Card
    SearchBtn.Text=""
    Corner(SearchBtn,8); Stroke(SearchBtn, theme.Stroke,1)
    SearchBtn.AutoButtonColor=false
    CreateIcon(SearchBtn, CatherFI.Icons.Search, UDim2.new(0,16,0,16), theme.Sub).Position = UDim2.new(0.5,-8,0.5,-8)

    local MinBtn=Instance.new("TextButton", Header)
    MinBtn.Size=UDim2.new(0,32,0,32)
    MinBtn.Position=UDim2.new(1,-82,0,12)
    MinBtn.BackgroundColor3=theme.Card
    MinBtn.Text=""
    Corner(MinBtn,8); Stroke(MinBtn, theme.Stroke,1)
    MinBtn.AutoButtonColor=false
    CreateIcon(MinBtn, CatherFI.Icons.Minimize, UDim2.new(0,14,0,14), theme.Text).Position = UDim2.new(0.5,-7,0.5,-7)

    local CloseBtn=Instance.new("TextButton", Header)
    CloseBtn.Size=UDim2.new(0,32,0,32)
    CloseBtn.Position=UDim2.new(1,-44,0,12)
    CloseBtn.BackgroundColor3=Color3.fromRGB(255,70,90)
    CloseBtn.Text=""
    Corner(CloseBtn,8)
    CloseBtn.AutoButtonColor=false
    CreateIcon(CloseBtn, CatherFI.Icons.Close, UDim2.new(0,14,0,14), Color3.new(1,1,1)).Position = UDim2.new(0.5,-7,0.5,-7)

    -- Body
    local Sidebar=Instance.new("Frame", Main)
    Sidebar.Size=UDim2.new(0,160,1,-56)
    Sidebar.Position=UDim2.new(0,0,0,56)
    Sidebar.BackgroundColor3=theme.Sidebar
    Corner(Sidebar,16)
    local sFix=Instance.new("Frame", Sidebar)
    sFix.Size=UDim2.new(1,0,0,16)
    sFix.Position=UDim2.new(0,0,0,0)
    sFix.BackgroundColor3=theme.Sidebar
    sFix.BorderSizePixel=0
    local sFix2=Instance.new("Frame", Sidebar)
    sFix2.Size=UDim2.new(0,16,1,0)
    sFix2.Position=UDim2.new(1,-16,0,0)
    sFix2.BackgroundColor3=theme.Sidebar
    sFix2.BorderSizePixel=0

    local Nav=Instance.new("ScrollingFrame", Sidebar)
    Nav.Size=UDim2.new(1,0,1,-20)
    Nav.Position=UDim2.new(0,0,0,10)
    Nav.BackgroundTransparency=1
    Nav.ScrollBarThickness=0
    Nav.CanvasSize=UDim2.new(0,0,0,0)
    Nav.AutomaticCanvasSize=Enum.AutomaticSize.Y
    local NavLayout=Instance.new("UIListLayout", Nav)
    NavLayout.Padding=UDim.new(0,6)
    NavLayout.SortOrder=Enum.SortOrder.LayoutOrder
    Padding(Nav,8,0,8,0)

    local Content=Instance.new("Frame", Main)
    Content.Size=UDim2.new(1,-160,1,-56)
    Content.Position=UDim2.new(0,160,0,56)
    Content.BackgroundTransparency=1

    -- Hub object
    local Hub={}
    Hub.Gui=Gui
    Hub.Main=Main
    Hub.Theme=theme
    Hub.ThemeName=themeName
    Hub.Tabs={}
    Hub.Current=nil

    function Hub:SetTheme(name)
        local t=CatherFI.Themes[name]
        if not t then return end
        Hub.Theme=t; Hub.ThemeName=name
        Main.BackgroundColor3=t.Bg
        Header.BackgroundColor3=t.Bg2
        Sidebar.BackgroundColor3=t.Sidebar
        TitleLb.TextColor3=t.Text; SubLb.TextColor3=t.Sub
        -- update existing cards
        for _,tab in ipairs(Hub.Tabs) do
            for _,sec in ipairs(tab.Sections or {}) do
                for _,el in ipairs(sec.Elements or {}) do
                    if el.Frame then
                        if el.Type=="card" then el.Frame.BackgroundColor3=t.Card end
                    end
                end
            end
        end
        CatherFI:Toast({Title="Theme", Desc="Ganti ke "..name, Type="success", Duration=2})
    end

    function Hub:Toast(cfg2) CatherFI:Toast(cfg2) end
    function Hub:Destroy() Gui:Destroy() end
    CatherFI.Destroy = function() Gui:Destroy() end

    -- Show after loading
    task.delay(1.05, function()
        Tween(Loading,{BackgroundTransparency=1},0.3)
        for _,v in ipairs(Loading:GetDescendants()) do pcall(function() if v:IsA("TextLabel") then Tween(v,{TextTransparency=1},0.2) end end) end
        task.wait(0.32); Loading:Destroy()
        Main.Visible=true
        Main.Size=UDim2.new(0,620,0,430)
        Spring(Main, {Size=size})
        CatherFI:Toast({Title="CatherFI GACOR", Desc="Loaded in 0.9s • Roblox Ready", Type="success", Duration=3})
    end)

    -- Controls (premium, no text symbols)
    local minimized=false
    MinBtn.MouseButton1Click:Connect(function()
        minimized=not minimized
        Tween(Content,{BackgroundTransparency=minimized and 1 or 1},0.2)
        for _,v in ipairs(Content:GetChildren()) do v.Visible = not minimized end
        Tween(Sidebar,{BackgroundTransparency=minimized and 1 or 0},0.2)
        for _,v in ipairs(Nav:GetChildren()) do if v:IsA("GuiObject") then v.Visible = not minimized end end
        Tween(Main,{Size=minimized and UDim2.new(0,640,0,56) or size},0.3)
        local icon = MinBtn:FindFirstChildOfClass("ImageLabel")
        if icon then Tween(icon,{Rotation = minimized and 180 or 0},0.2) end
    end)
    CloseBtn.MouseButton1Click:Connect(function() Gui:Destroy() end)
    SearchBtn.MouseButton1Click:Connect(function()
        CatherFI:Toast({Title="Search", Desc="Command palette soon! (Ctrl+K)", Type="info"})
    end)
    -- hover effects
    for _,b in ipairs({SearchBtn,MinBtn}) do
        b.MouseEnter:Connect(function() Tween(b,{BackgroundColor3=theme.CardHover},0.15) end)
        b.MouseLeave:Connect(function() Tween(b,{BackgroundColor3=theme.Card},0.15) end)
    end
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn,{BackgroundColor3=Color3.fromRGB(255,90,110)},0.15) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn,{BackgroundColor3=Color3.fromRGB(255,70,90)},0.15) end)

    -- Toggle with K / RightControl
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode==Enum.KeyCode.RightControl or input.KeyCode==Enum.KeyCode.K then
            Main.Visible = not Main.Visible
        end
    end)

    function Hub:AddTab(cfg2)
        cfg2=cfg2 or {}
        local name=cfg2.Name or "Tab"
        local icon=cfg2.Icon or CatherFI.Icons.DefaultTab
        -- normalize icon to rbxassetid
        local iconAsset = icon
        if typeof(icon)=="number" then iconAsset = "rbxassetid://"..tostring(icon) end
        if typeof(icon)=="string" and not string.find(icon, "rbxassetid://") then
            -- map friendly names to premium assets (no emoji) - robust
            local map = {combat=CatherFI.Icons.Combat, visual=CatherFI.Icons.Visual, settings=CatherFI.Icons.Settings}
            local lower = ""
            local ok, res = pcall(function() return string.lower(icon) end)
            if ok and typeof(res)=="string" then lower = res end
            if map[lower] then iconAsset = map[lower]
            elseif string.len(icon) <= 4 then -- emoji fallback, replace with default premium
                iconAsset = CatherFI.Icons.DefaultTab
            else
                iconAsset = icon
            end
        end

        local Btn=Instance.new("TextButton", Nav)
        Btn.Size=UDim2.new(1,0,0,40)
        Btn.BackgroundColor3=theme.Card
        Btn.BackgroundTransparency=1
        Btn.Text=""
        Btn.AutoButtonColor=false
        Corner(Btn,10)

        local Ico=Instance.new("ImageLabel", Btn)
        Ico.Image=iconAsset
        Ico.ImageColor3=theme.Sub
        Ico.BackgroundTransparency=1
        Ico.Size=UDim2.new(0,18,0,18)
        Ico.Position=UDim2.new(0,10,0.5,-9)
        Ico.ScaleType = Enum.ScaleType.Fit

        local Lb=Instance.new("TextLabel", Btn)
        Lb.Text=name
        Lb.Font=Enum.Font.GothamMedium
        Lb.TextSize=13
        Lb.TextColor3=theme.Sub
        Lb.BackgroundTransparency=1
        Lb.Size=UDim2.new(1,-40,1,0)
        Lb.Position=UDim2.new(0,34,0,0)
        Lb.TextXAlignment=Enum.TextXAlignment.Left

        local Indicator=Instance.new("Frame", Btn)
        Indicator.Size=UDim2.new(0,3,0,20)
        Indicator.Position=UDim2.new(0,0,0.5,-10)
        Indicator.BackgroundColor3=theme.Accent
        Corner(Indicator,99)
        Indicator.Visible=false
        local indGrad=Instance.new("UIGradient", Indicator)
        indGrad.Color=ColorSequence.new(theme.Accent, theme.Accent2)
        indGrad.Rotation=90

        local Page=Instance.new("ScrollingFrame", Content)
        Page.Size=UDim2.new(1,0,1,0)
        Page.BackgroundTransparency=1
        Page.ScrollBarThickness=3
        Page.ScrollBarImageColor3=theme.Accent
        Page.CanvasSize=UDim2.new(0,0,0,0)
        Page.AutomaticCanvasSize=Enum.AutomaticSize.Y
        Page.Visible=false
        local PLayout=Instance.new("UIListLayout", Page)
        PLayout.Padding=UDim.new(0,10)
        PLayout.SortOrder=Enum.SortOrder.LayoutOrder
        Padding(Page,12,12,12,12)

        local function Select()
            for _,t in ipairs(Hub.Tabs) do
                t.Page.Visible=false
                t.Btn.BackgroundTransparency=1
                t.Btn.BackgroundColor3=theme.Card
                t.Label.TextColor3=theme.Sub
                t.Icon.ImageColor3=theme.Sub
                t.Indicator.Visible=false
            end
            Page.Visible=true
            Btn.BackgroundTransparency=0
            Btn.BackgroundColor3=theme.Card
            Lb.TextColor3=theme.Text
            Ico.ImageColor3=theme.Accent
            Indicator.Visible=true
            Hub.Current=Page
            Spring(Btn,{BackgroundTransparency=0})
        end

        Btn.MouseButton1Click:Connect(Select)
        Btn.MouseEnter:Connect(function() if Page.Visible==false then Tween(Btn,{BackgroundTransparency=0.5},0.15) end end)
        Btn.MouseLeave:Connect(function() if Page.Visible==false then Tween(Btn,{BackgroundTransparency=1},0.15) end end)

        if #Hub.Tabs==0 then task.defer(Select) end

        local Tab={Btn=Btn, Label=Lb, Icon=Ico, Indicator=Indicator, Page=Page, Sections={}}
        
        function Tab:AddSection(secName, opts)
            opts=opts or {}
            local collapsible = opts.Collapsible or false
            local SecFrame=Instance.new("Frame", Page)
            SecFrame.Size=UDim2.new(1,0,0,0)
            SecFrame.AutomaticSize=Enum.AutomaticSize.Y
            SecFrame.BackgroundColor3=theme.Card
            Corner(SecFrame,12); Stroke(SecFrame, theme.Stroke,1)
            Padding(SecFrame,12,12,12,12)

            local Head=Instance.new("Frame", SecFrame)
            Head.Size=UDim2.new(1,0,0,24)
            Head.BackgroundTransparency=1
            local HeadLb=Instance.new("TextLabel", Head)
            HeadLb.Text=string.upper(secName or "SECTION")
            HeadLb.Font=Enum.Font.GothamBold
            HeadLb.TextSize=11
            HeadLb.TextColor3=theme.Sub
            HeadLb.BackgroundTransparency=1
            HeadLb.Size=UDim2.new(1,-30,1,0)
            HeadLb.TextXAlignment=Enum.TextXAlignment.Left
            local HeadLine=Instance.new("Frame", Head)
            HeadLine.Size=UDim2.new(1,0,0,1)
            HeadLine.Position=UDim2.new(0,0,1,-1)
            HeadLine.BackgroundColor3=theme.Stroke
            HeadLine.BackgroundTransparency=0.6
            HeadLine.BorderSizePixel=0

            local CollapseBtn
            if collapsible then
                CollapseBtn=Instance.new("TextButton", Head)
                CollapseBtn.Size=UDim2.new(0,24,0,24)
                CollapseBtn.Position=UDim2.new(1,-24,0,0)
                CollapseBtn.BackgroundTransparency=1
                CollapseBtn.Text=""
                local colIcon = CreateIcon(CollapseBtn, CatherFI.Icons.ChevronDown, UDim2.new(0,16,0,16), theme.Sub)
                colIcon.Position = UDim2.new(0.5,-8,0.5,-8)
                colIcon.Name = "Icon"
            end

            local Body=Instance.new("Frame", SecFrame)
            Body.Size=UDim2.new(1,0,0,0)
            Body.AutomaticSize=Enum.AutomaticSize.Y
            Body.BackgroundTransparency=1
            Body.Position=UDim2.new(0,0,0,32)
            local BLayout=Instance.new("UIListLayout", Body)
            BLayout.Padding=UDim.new(0,8)
            BLayout.SortOrder=Enum.SortOrder.LayoutOrder
            -- auto resize section
            local function UpdateSecSize()
                SecFrame.Size=UDim2.new(1,0,0, collapsible and (Body.Visible and 0 or 32) or 0)
            end
            if CollapseBtn then
                local collapsed=false
                CollapseBtn.MouseButton1Click:Connect(function()
                    collapsed=not collapsed
                    Body.Visible=not collapsed
                    local icon = CollapseBtn:FindFirstChild("Icon")
                    if icon then Tween(icon,{Rotation=collapsed and -90 or 0},0.2) end
                    Spring(SecFrame,{Size=UDim2.new(1,0,0,0)})
                end)
            end

            local Section={Frame=SecFrame, Body=Body, Elements={}}

            -- HELPER: create card base
            local function Card(h)
                local F=Instance.new("Frame", Body)
                F.Size=UDim2.new(1,0,0,h or 48)
                F.BackgroundColor3=theme.Bg2
                Corner(F,10); Stroke(F, theme.Stroke,1)
                table.insert(Section.Elements, {Frame=F, Type="card"})
                return F
            end

            function Section:AddToggle(cfg3)
                cfg3=cfg3 or {}
                local flag=cfg3.Flag
                local val=cfg3.Default or cfg3.Enabled or false
                if flag then CatherFI.Flags[flag]=val end
                local F=Card(52)
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Toggle"
                T.Font=Enum.Font.GothamMedium
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(1,-70,0,18)
                T.Position=UDim2.new(0,12,0,8)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local D=Instance.new("TextLabel", F)
                D.Text=cfg3.Desc or cfg3.Description or ""
                D.Font=Enum.Font.Gotham
                D.TextSize=11
                D.TextColor3=theme.Sub
                D.BackgroundTransparency=1
                D.Size=UDim2.new(1,-70,0,14)
                D.Position=UDim2.new(0,12,0,26)
                D.TextXAlignment=Enum.TextXAlignment.Left
                D.Visible = D.Text~=""
                local BG=Instance.new("Frame", F)
                BG.Size=UDim2.new(0,46,0,26)
                BG.Position=UDim2.new(1,-58,0.5,-13)
                BG.BackgroundColor3= val and theme.Accent or Color3.fromRGB(45,45,55)
                Corner(BG,99)
                local Dot=Instance.new("Frame", BG)
                Dot.Size=UDim2.new(0,20,0,20)
                Dot.Position= val and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,3,0.5,-10)
                Dot.BackgroundColor3=Color3.new(1,1,1)
                Corner(Dot,99)
                local Hit=Instance.new("TextButton", F)
                Hit.Size=UDim2.new(1,0,1,0)
                Hit.BackgroundTransparency=1
                Hit.Text=""
                local function Set(v, silent)
                    val=v; if flag then CatherFI.Flags[flag]=v end
                    Tween(BG,{BackgroundColor3= v and theme.Accent or Color3.fromRGB(45,45,55)},0.22)
                    Spring(Dot,{Position= v and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,3,0.5,-10)})
                    if not silent then pcall(function() cfg3.Callback(v) end) end
                end
                Hit.MouseButton1Click:Connect(function() Set(not val) end)
                -- hover
                F.MouseEnter:Connect(function() Tween(F,{BackgroundColor3=theme.CardHover},0.15) end)
                F.MouseLeave:Connect(function() Tween(F,{BackgroundColor3=theme.Bg2},0.15) end)
                if cfg3.Default ~= nil then Set(cfg3.Default, true) end
                return {Set=Set, Frame=F}
            end

            function Section:AddButton(cfg3)
                cfg3=cfg3 or {}
                local F=Instance.new("TextButton", Body)
                F.Size=UDim2.new(1,0,0,44)
                F.BackgroundColor3=theme.Accent
                F.Text=""
                F.AutoButtonColor=false
                Corner(F,10)
                local grad=Instance.new("UIGradient", F)
                grad.Color=ColorSequence.new(theme.Accent, theme.Accent2)
                grad.Rotation=15
                local Lb=Instance.new("TextLabel", F)
                Lb.Text=cfg3.Title or cfg3.Text or "Button"
                Lb.Font=Enum.Font.GothamBold
                Lb.TextSize=13
                Lb.TextColor3=Color3.new(1,1,1)
                Lb.BackgroundTransparency=1
                Lb.Size=UDim2.new(1,-40,1,0)
                Lb.Position=UDim2.new(0,14,0,0)
                Lb.TextXAlignment=Enum.TextXAlignment.Left
                local Ico2=CreateIcon(F, CatherFI.Icons.ArrowRight, UDim2.new(0,18,0,18), Color3.new(1,1,1))
                Ico2.Position=UDim2.new(1,-28,0.5,-9)
                F.MouseEnter:Connect(function() Tween(F,{BackgroundTransparency=0.1},0.15) Spring(Ico2,{Position=UDim2.new(1,-24,0.5,-9)}) end)
                F.MouseLeave:Connect(function() Tween(F,{BackgroundTransparency=0},0.15) Tween(Ico2,{Position=UDim2.new(1,-28,0.5,-9)},0.15) end)
                F.MouseButton1Click:Connect(function()
                    Tween(F,{Size=UDim2.new(1,0,0,42)},0.08)
                    task.wait(0.08); Spring(F,{Size=UDim2.new(1,0,0,44)})
                    pcall(cfg3.Callback)
                end)
                table.insert(Section.Elements,{Frame=F, Type="button"})
                return {Set=function(_,t) Lb.Text=t end}
            end

            function Section:AddSlider(cfg3)
                cfg3=cfg3 or {}
                local min,max=cfg3.Min or 0, cfg3.Max or 100
                local step=cfg3.Step or cfg3.Increment or 1
                local val=cfg3.Default or cfg3.Value or min
                local flag=cfg3.Flag
                if flag then CatherFI.Flags[flag]=val end
                local F=Card(64)
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Slider"
                T.Font=Enum.Font.GothamMedium
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(0.5,0,0,16)
                T.Position=UDim2.new(0,12,0,10)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local VBox=Instance.new("TextBox", F)
                VBox.Size=UDim2.new(0,64,0,22)
                VBox.Position=UDim2.new(1,-76,0,8)
                VBox.BackgroundColor3=theme.Card
                VBox.Text=tostring(val)
                VBox.Font=Enum.Font.GothamBold
                VBox.TextSize=11
                VBox.TextColor3=theme.Text
                Corner(VBox,6); Stroke(VBox, theme.Stroke,1)
                VBox.ClearTextOnFocus=false
                local suffix=cfg3.Suffix or ""
                local Track=Instance.new("Frame", F)
                Track.Size=UDim2.new(1,-24,0,6)
                Track.Position=UDim2.new(0,12,0,38)
                Track.BackgroundColor3=theme.Card
                Corner(Track,99)
                local Fill=Instance.new("Frame", Track)
                Fill.Size=UDim2.new((val-min)/(max-min),0,1,0)
                Fill.BackgroundColor3=theme.Accent
                Corner(Fill,99)
                local FillGrad=Instance.new("UIGradient", Fill)
                FillGrad.Color=ColorSequence.new(theme.Accent, theme.Accent2)
                local Knob=Instance.new("Frame", Track)
                Knob.Size=UDim2.new(0,14,0,14)
                Knob.Position=UDim2.new((val-min)/(max-min),-7,0.5,-7)
                Knob.BackgroundColor3=Color3.new(1,1,1)
                Corner(Knob,99); Stroke(Knob, theme.Accent,2)
                local dragging=false
                local function Set(v, silent)
                    v=math.clamp(math.floor(v/step+0.5)*step, min, max)
                    val=v; if flag then CatherFI.Flags[flag]=v end
                    VBox.Text=tostring(v)..(suffix~="" and " "..suffix or "")
                    Tween(Fill,{Size=UDim2.new((v-min)/(max-min),0,1,0)},0.12)
                    Tween(Knob,{Position=UDim2.new((v-min)/(max-min),-7,0.5,-7)},0.12)
                    if not silent then pcall(function() cfg3.Callback(v) end) end
                end
                VBox.FocusLost:Connect(function(enter)
                    if enter then
                        local n=tonumber(VBox.Text)
                        if n then Set(n) else VBox.Text=tostring(val) end
                    end
                end)
                local Hit=Instance.new("TextButton", Track)
                Hit.Size=UDim2.new(1,0,1,0)
                Hit.BackgroundTransparency=1
                Hit.Text=""
                local function Update(input)
                    local p=math.clamp((input.Position.X - Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1)
                    Set(min + (max-min)*p)
                end
                Hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; Update(i) end end)
                Hit.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
                UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then Update(i) end end)
                Set(val, true)
                return {Set=Set}
            end

            function Section:AddDropdown(cfg3)
                cfg3=cfg3 or {}
                local opts=cfg3.Options or {}
                local multi=cfg3.Multi or cfg3.Multiple or false
                local flag=cfg3.Flag
                local cur = cfg3.Default or (multi and {} or opts[1])
                if typeof(cur)=="string" then cur={cur} end
                if not cur or #cur==0 then cur={opts[1]} end
                if flag then CatherFI.Flags[flag]= multi and cur or cur[1] end
                local F=Instance.new("Frame", Body)
                F.Size=UDim2.new(1,0,0,50)
                F.BackgroundColor3=theme.Bg2
                F.ClipsDescendants=true
                Corner(F,10); Stroke(F, theme.Stroke,1)
                table.insert(Section.Elements,{Frame=F, Type="card"})
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Dropdown"
                T.Font=Enum.Font.GothamMedium
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(1,-40,0,16)
                T.Position=UDim2.new(0,12,0,8)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local SubT=Instance.new("TextLabel", F)
                SubT.Text=cfg3.Desc or ""
                SubT.Font=Enum.Font.Gotham
                SubT.TextSize=11
                SubT.TextColor3=theme.Sub
                SubT.BackgroundTransparency=1
                SubT.Size=UDim2.new(1,-40,0,12)
                SubT.Position=UDim2.new(0,12,0,24)
                SubT.TextXAlignment=Enum.TextXAlignment.Left
                SubT.Visible=SubT.Text~=""
                local Disp=Instance.new("TextLabel", F)
                Disp.Text=table.concat(cur, ", ")
                Disp.Font=Enum.Font.Gotham
                Disp.TextSize=12
                Disp.TextColor3=theme.Sub
                Disp.BackgroundTransparency=1
                Disp.Size=UDim2.new(1,-50,0,20)
                Disp.Position=UDim2.new(0,12,0, cfg3.Desc and 38 or 24)
                Disp.TextXAlignment=Enum.TextXAlignment.Left
                Disp.TextTruncate=Enum.TextTruncate.AtEnd
                local Arrow=CreateIcon(F, CatherFI.Icons.ChevronDown, UDim2.new(0,16,0,16), theme.Sub)
                Arrow.Position=UDim2.new(1,-28,0.5,-8)
                Arrow.Name="ArrowIcon"
                local Hit=Instance.new("TextButton", F)
                Hit.Size=UDim2.new(1,0,0,46)
                Hit.BackgroundTransparency=1
                Hit.Text=""
                local List=Instance.new("Frame", F)
                List.Size=UDim2.new(1,-16,0,0)
                List.Position=UDim2.new(0,8,0,52)
                List.BackgroundTransparency=1
                local LLayout=Instance.new("UIListLayout", List)
                LLayout.Padding=UDim.new(0,6)
                -- Search box if enabled
                local SearchBox
                if cfg3.Search then
                    SearchBox=Instance.new("TextBox", List)
                    SearchBox.Size=UDim2.new(1,0,0,30)
                    SearchBox.BackgroundColor3=theme.Card
                    SearchBox.PlaceholderText="Search..."
                    SearchBox.Text=""
                    SearchBox.Font=Enum.Font.Gotham
                    SearchBox.TextSize=12
                    SearchBox.TextColor3=theme.Text
                    Corner(SearchBox,8); Stroke(SearchBox, theme.Stroke,1)
                    Padding(SearchBox,10,0,0,0)
                end
                local open=false
                local function Refresh() Disp.Text=table.concat(cur, ", ") end
                local function Toggle()
                    open=not open
                    Tween(Arrow,{Rotation=open and 180 or 0},0.2)
                    local h = 52 + (#opts*32) + ((#opts-1)*6) + (cfg3.Search and 38 or 0) + 10
                    Tween(F,{Size= open and UDim2.new(1,0,0,h) or UDim2.new(1,0,0,50)},0.28)
                end
                -- keep old name alias for compatibility
                local ArrowIcon = Arrow
                Hit.MouseButton1Click:Connect(Toggle)
                local buttons={}
                for _,opt in ipairs(opts) do
                    local O=Instance.new("TextButton", List)
                    O.Size=UDim2.new(1,0,0,32)
                    O.BackgroundColor3=theme.Card
                    O.Text=""
                    Corner(O,8); Stroke(O, theme.Stroke,1)
                    local OTxt=Instance.new("TextLabel", O)
                    OTxt.Text=opt
                    OTxt.Font=Enum.Font.Gotham
                    OTxt.TextSize=12
                    OTxt.TextColor3=theme.Text
                    OTxt.BackgroundTransparency=1
                    OTxt.Size=UDim2.new(1,-36,1,0)
                    OTxt.Position=UDim2.new(0,12,0,0)
                    OTxt.TextXAlignment=Enum.TextXAlignment.Left
                    local Check=Instance.new("Frame", O)
                    Check.Size=UDim2.new(0,18,0,18)
                    Check.Position=UDim2.new(1,-26,0.5,-9)
                    Check.BackgroundColor3=theme.Card
                    Check.Visible= tableFind(cur, opt) ~= nil
                    Corner(Check,5); Stroke(Check, theme.Accent,1)
                    local CheckInner=Instance.new("Frame", Check)
                    CheckInner.Size=UDim2.new(0,10,0,10)
                    CheckInner.Position=UDim2.new(0.5,-5,0.5,-5)
                    CheckInner.BackgroundColor3=theme.Accent
                    Corner(CheckInner,3)
                    if tableFind(cur, opt) then
                        O.BackgroundColor3=theme.CardHover
                        Check.BackgroundColor3=theme.Accent
                    end
                    table.insert(buttons, {Btn=O, Txt=OTxt, Check=Check, Opt=opt})
                    O.MouseButton1Click:Connect(function()
                        if multi then
                            local idx=tableFind(cur, opt)
                            if idx then table.remove(cur, idx) else table.insert(cur, opt) end
                        else
                            cur={opt}; open=false; Tween(F,{Size=UDim2.new(1,0,0,50)},0.22); Tween(Arrow,{Rotation=0},0.2)
                        end
                        Refresh()
                        if flag then CatherFI.Flags[flag]= multi and cur or cur[1] end
                        pcall(function() cfg3.Callback(multi and cur or cur[1], cur) end)
                        for _,b in ipairs(buttons) do
                            local sel=tableFind(cur, b.Opt) ~= nil
                            Tween(b.Btn,{BackgroundColor3= sel and theme.CardHover or theme.Card},0.15)
                            b.Check.Visible=sel
                            if sel then b.Check.BackgroundColor3=theme.Accent else b.Check.BackgroundColor3=theme.Card end
                        end
                    end)
                end
                if SearchBox then
                    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
                        local q=string.lower(SearchBox.Text)
                        for _,b in ipairs(buttons) do
                            local show = q=="" or string.find(string.lower(b.Opt), q, 1, true)
                            b.Btn.Visible = show
                        end
                    end)
                end
                return {Set=function(_,v) cur= typeof(v)=="table" and v or {v}; Refresh() end}
            end

            function Section:AddInput(cfg3)
                cfg3=cfg3 or {}
                local F=Card(48)
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Input"
                T.Font=Enum.Font.GothamMedium
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(0.4,0,1,0)
                T.Position=UDim2.new(0,12,0,0)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local Box=Instance.new("TextBox", F)
                Box.Size=UDim2.new(0.55,0,0,30)
                Box.Position=UDim2.new(0.42,0,0.5,-15)
                Box.BackgroundColor3=theme.Card
                Box.PlaceholderText=cfg3.Placeholder or "..."
                Box.Text=cfg3.Default or ""
                Box.Font=Enum.Font.Gotham
                Box.TextSize=12
                Box.TextColor3=theme.Text
                Box.ClearTextOnFocus=false
                Corner(Box,8); Stroke(Box, theme.Stroke,1)
                Padding(Box,10,0,0,0)
                Box.Focused:Connect(function() Tween(Box,{BackgroundColor3=theme.CardHover},0.15); Stroke(Box, theme.Accent,1).Color=theme.Accent end)
                Box.FocusLost:Connect(function(enter)
                    Tween(Box,{BackgroundColor3=theme.Card},0.15)
                    if enter then pcall(function() cfg3.Callback(Box.Text) end) end
                end)
                return {Set=function(_,v) Box.Text=v end}
            end

            function Section:AddColor(cfg3)
                cfg3=cfg3 or {}
                local col=cfg3.Default or cfg3.Color or Color3.fromRGB(124,92,255)
                local flag=cfg3.Flag
                if flag then CatherFI.Flags[flag]=col end
                local F=Card(48)
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Color"
                T.Font=Enum.Font.GothamMedium
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(1,-70,1,0)
                T.Position=UDim2.new(0,12,0,0)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local Prev=Instance.new("Frame", F)
                Prev.Size=UDim2.new(0,32,0,32)
                Prev.Position=UDim2.new(1,-44,0.5,-16)
                Prev.BackgroundColor3=col
                Corner(Prev,8); Stroke(Prev, Color3.new(1,1,1),1)
                -- HSV wheel popup simplified
                local Hit=Instance.new("TextButton", F)
                Hit.Size=UDim2.new(1,0,1,0)
                Hit.BackgroundTransparency=1
                Hit.Text=""
                Hit.MouseButton1Click:Connect(function()
                    -- gacor: cycle hue with rainbow tween
                    local h,s,v = col:ToHSV()
                    h = (h + 0.15) % 1
                    col = Color3.fromHSV(h,s,v)
                    Tween(Prev,{BackgroundColor3=col},0.22)
                    if flag then CatherFI.Flags[flag]=col end
                    pcall(function() cfg3.Callback(col) end)
                    -- long press opens full palette (future)
                end)
                -- right click random?
                return {Set=function(_,c) col=c; Prev.BackgroundColor3=c end}
            end

            function Section:AddKeybind(cfg3)
                cfg3=cfg3 or {}
                local cur=cfg3.Default or "K"
                local flag=cfg3.Flag
                if flag then CatherFI.Flags[flag]=cur end
                local F=Card(48)
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Keybind"
                T.Font=Enum.Font.GothamMedium
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(0.5,0,1,0)
                T.Position=UDim2.new(0,12,0,0)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local KeyBtn=Instance.new("TextButton", F)
                KeyBtn.Size=UDim2.new(0,90,0,28)
                KeyBtn.Position=UDim2.new(1,-102,0.5,-14)
                KeyBtn.BackgroundColor3=theme.Card
                KeyBtn.Text=cur
                KeyBtn.Font=Enum.Font.GothamBold
                KeyBtn.TextSize=11
                KeyBtn.TextColor3=theme.Text
                Corner(KeyBtn,8); Stroke(KeyBtn, theme.Stroke,1)
                local listening=false
                KeyBtn.MouseButton1Click:Connect(function() listening=true; KeyBtn.Text="..." ; Tween(KeyBtn,{BackgroundColor3=theme.CardHover},0.15) end)
                UserInputService.InputBegan:Connect(function(input,gp)
                    if listening and not gp then
                        local key=input.KeyCode.Name~="Unknown" and input.KeyCode.Name or input.UserInputType.Name
                        cur=key; KeyBtn.Text=cur; if flag then CatherFI.Flags[flag]=cur end
                        listening=false; Tween(KeyBtn,{BackgroundColor3=theme.Card},0.15)
                        pcall(function() cfg3.Callback(cur) end)
                    end
                end)
                return {Set=function(_,k) cur=k; KeyBtn.Text=k end}
            end

            function Section:AddLabel(text)
                local F=Instance.new("Frame", Body)
                F.Size=UDim2.new(1,0,0,36)
                F.BackgroundColor3=theme.Card
                F.BackgroundTransparency=0.5
                Corner(F,8); Stroke(F, theme.Stroke,1)
                local Lb=Instance.new("TextLabel", F)
                Lb.Text=text or "Label"
                Lb.Font=Enum.Font.Gotham
                Lb.TextSize=12
                Lb.TextColor3=theme.Sub
                Lb.BackgroundTransparency=1
                Lb.Size=UDim2.new(1,-20,1,0)
                Lb.Position=UDim2.new(0,10,0,0)
                Lb.TextXAlignment=Enum.TextXAlignment.Left
                Lb.TextWrapped=true
                table.insert(Section.Elements,{Frame=F, Type="card"})
                return {Set=function(_,t) Lb.Text=t end}
            end

            function Section:AddParagraph(cfg3)
                cfg3=cfg3 or {}
                local F=Instance.new("Frame", Body)
                F.Size=UDim2.new(1,0,0,0)
                F.AutomaticSize=Enum.AutomaticSize.Y
                F.BackgroundColor3=theme.Card
                Corner(F,10); Stroke(F, theme.Stroke,1)
                Padding(F,12,10,12,10)
                local T=Instance.new("TextLabel", F)
                T.Text=cfg3.Title or "Paragraph"
                T.Font=Enum.Font.GothamBold
                T.TextSize=13
                T.TextColor3=theme.Text
                T.BackgroundTransparency=1
                T.Size=UDim2.new(1,0,0,16)
                T.TextXAlignment=Enum.TextXAlignment.Left
                local D=Instance.new("TextLabel", F)
                D.Text=cfg3.Desc or cfg3.Content or ""
                D.Font=Enum.Font.Gotham
                D.TextSize=12
                D.TextColor3=theme.Sub
                D.BackgroundTransparency=1
                D.Size=UDim2.new(1,0,0,0)
                D.AutomaticSize=Enum.AutomaticSize.Y
                D.Position=UDim2.new(0,0,0,20)
                D.TextXAlignment=Enum.TextXAlignment.Left
                D.TextWrapped=true
                table.insert(Section.Elements,{Frame=F, Type="card"})
                return {Set=function(_,t,c) T.Text=t; D.Text=c end}
            end

            function Section:AddDivider()
                local F=Instance.new("Frame", Body)
                F.Size=UDim2.new(1,0,0,1)
                F.BackgroundColor3=theme.Stroke
                F.BackgroundTransparency=0.5
                F.BorderSizePixel=0
                return F
            end

            table.insert(Tab.Sections, Section)
            return Section
        end

        table.insert(Hub.Tabs, Tab)
        return Tab
    end

    return Hub
end

if getgenv then getgenv().XSAYT = CatherFI; getgenv().CatherFI = CatherFI end
return CatherFI
