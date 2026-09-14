-- XSAYT UI Library | Delta Edition | Legacy v1 API
-- Github: https://github.com/myzakonz-gif/UI-LIB-XSAYT
-- Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/legacy/XsaytUI.lua"))()
-- Version: 1.0.0 Deprecated

local XsaytUI = {}
XsaytUI.Flags = {}
XsaytUI.Theme = {
    Background = Color3.fromRGB(15, 15, 18),
    Topbar = Color3.fromRGB(18, 18, 22),
    Sidebar = Color3.fromRGB(20, 20, 24),
    Element = Color3.fromRGB(28, 28, 33),
    ElementStroke = Color3.fromRGB(38, 38, 45),
    Accent = Color3.fromRGB(115, 95, 255),
    Accent2 = Color3.fromRGB(140, 120, 255),
    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(150, 150, 160),
    Success = Color3.fromRGB(60, 220, 120),
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function Tween(obj, props, time, style, dir)
    local info = TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function Corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or XsaytUI.Theme.ElementStroke
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Tween(frame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.1)
        end
    end)
end

-- Notification System
local NotifGui
local function GetNotifGui()
    if NotifGui then return NotifGui end
    local pg
    pcall(function()
        if gethui then pg = gethui()
        elseif get_hidden_gui then pg = get_hidden_gui()
        elseif game.CoreGui then pg = game.CoreGui
        end
    end)
    if not pg then pg = LocalPlayer:WaitForChild("PlayerGui") end
    NotifGui = Instance.new("ScreenGui")
    NotifGui.Name = "Xsayt_Notif"
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifGui.ResetOnSpawn = false
    NotifGui.Parent = pg
    return NotifGui
end

function XsaytUI:Notify(cfg)
    cfg = cfg or {}
    local title = cfg.Title or "Notification"
    local content = cfg.Content or ""
    local duration = cfg.Duration or 3
    local image = cfg.Image or 4483345998

    local gui = GetNotifGui()
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0, 300, 0, 0)
    holder.AutomaticSize = Enum.AutomaticSize.Y
    holder.BackgroundColor3 = XsaytUI.Theme.Element
    holder.Position = UDim2.new(1, -320, 1, -20)
    holder.AnchorPoint = Vector2.new(0,1)
    holder.Parent = gui
    Corner(holder, 10)
    Stroke(holder, XsaytUI.Theme.ElementStroke, 1)
    holder.BackgroundTransparency = 0.05
    holder.ClipsDescendants = true
    holder.Size = UDim2.new(0, 300, 0, 70)

    local pad = Instance.new("UIPadding", holder)
    pad.PaddingTop = UDim.new(0,12); pad.PaddingBottom = UDim.new(0,12); pad.PaddingLeft = UDim.new(0,12); pad.PaddingRight = UDim.new(0,12)

    local icon = Instance.new("ImageLabel", holder)
    icon.Size = UDim2.new(0, 32, 0, 32)
    icon.Position = UDim2.new(0,0,0,0)
    icon.BackgroundTransparency = 1
    icon.Image = typeof(image)=="string" and image or "rbxassetid://"..tostring(image)

    local tLabel = Instance.new("TextLabel", holder)
    tLabel.Text = title
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextSize = 14
    tLabel.TextColor3 = XsaytUI.Theme.Text
    tLabel.BackgroundTransparency = 1
    tLabel.Position = UDim2.new(0, 42, 0, 0)
    tLabel.Size = UDim2.new(1, -50, 0, 16)
    tLabel.TextXAlignment = Enum.TextXAlignment.Left

    local cLabel = Instance.new("TextLabel", holder)
    cLabel.Text = content
    cLabel.Font = Enum.Font.Gotham
    cLabel.TextSize = 12
    cLabel.TextColor3 = XsaytUI.Theme.SubText
    cLabel.BackgroundTransparency = 1
    cLabel.Position = UDim2.new(0, 42, 0, 18)
    cLabel.Size = UDim2.new(1, -50, 0, 40)
    cLabel.TextXAlignment = Enum.TextXAlignment.Left
    cLabel.TextYAlignment = Enum.TextYAlignment.Top
    cLabel.TextWrapped = true

    holder.Position = UDim2.new(1, 10, 1, -20)
    Tween(holder, {Position = UDim2.new(1, -320, 1, -20)}, 0.4, Enum.EasingStyle.Back)
    task.delay(duration, function()
        Tween(holder, {Position = UDim2.new(1, 10, 1, -20)}, 0.3)
        task.wait(0.35)
        holder:Destroy()
    end)

    if cfg.Actions then
        -- support Actions (placeholder)
    end
end

-- Config Saving (Delta file system)
local function SaveConfig(folder, file, flags)
    if not (writefile and makefolder and isfolder) then return end
    pcall(function()
        if not isfolder(folder) then makefolder(folder) end
        writefile(folder.."/"..file..".json", game:GetService("HttpService"):JSONEncode(flags))
    end)
end
local function LoadConfig(folder, file)
    if not (readfile and isfile) then return nil end
    local ok, data = pcall(function()
        if isfile(folder.."/"..file..".json") then
            return game:GetService("HttpService"):JSONDecode(readfile(folder.."/"..file..".json"))
        end
    end)
    if ok then return data end
end

function XsaytUI:CreateWindow(settings)
    settings = settings or {}
    local winName = settings.Name or "XSAYT Hub"
    local loadingTitle = settings.LoadingTitle or "XSAYT UI"
    local loadingSub = settings.LoadingSubtitle or "Loading..."
    local configSaving = settings.ConfigurationSaving or {Enabled=false}
    local keySystem = settings.KeySystem or false
    local keySettings = settings.KeySettings or {Key={"XSAYT"}, FileName="XsaytKey", SaveKey=false}

    -- Parent Gui
    local parent
    pcall(function()
        if gethui then parent = gethui()
        elseif get_hidden_gui then parent = get_hidden_gui()
        elseif game.CoreGui then parent = game.CoreGui
        end
    end)
    if not parent then parent = LocalPlayer:WaitForChild("PlayerGui") end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XsaytUI_"..tostring(math.random(1000,9999))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = parent
    if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
    if gethui then pcall(function() ScreenGui.Parent = gethui() end) end

    -- Loading Screen (quick)
    local LoadingFrame = Instance.new("Frame", ScreenGui)
    LoadingFrame.Size = UDim2.new(0, 350, 0, 150)
    LoadingFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
    LoadingFrame.BackgroundColor3 = XsaytUI.Theme.Background
    Corner(LoadingFrame, 12)
    Stroke(LoadingFrame, XsaytUI.Theme.ElementStroke,1)
    local lTitle = Instance.new("TextLabel", LoadingFrame)
    lTitle.Text = loadingTitle
    lTitle.Font = Enum.Font.GothamBold
    lTitle.TextSize = 18
    lTitle.TextColor3 = XsaytUI.Theme.Text
    lTitle.BackgroundTransparency = 1
    lTitle.Size = UDim2.new(1,0,0,30)
    lTitle.Position = UDim2.new(0,0,0,25)
    local lSub = Instance.new("TextLabel", LoadingFrame)
    lSub.Text = loadingSub
    lSub.Font = Enum.Font.Gotham
    lSub.TextSize = 13
    lSub.TextColor3 = XsaytUI.Theme.SubText
    lSub.BackgroundTransparency = 1
    lSub.Size = UDim2.new(1,0,0,20)
    lSub.Position = UDim2.new(0,0,0,55)
    local barBG = Instance.new("Frame", LoadingFrame)
    barBG.Size = UDim2.new(0.8,0,0,4)
    barBG.Position = UDim2.new(0.1,0,0,100)
    barBG.BackgroundColor3 = XsaytUI.Theme.Element
    Corner(barBG, 99)
    local bar = Instance.new("Frame", barBG)
    bar.Size = UDim2.new(0,0,1,0)
    bar.BackgroundColor3 = XsaytUI.Theme.Accent
    Corner(bar, 99)
    Tween(bar, {Size = UDim2.new(1,0,1,0)}, 0.8, Enum.EasingStyle.Quad)

    -- MainFrame
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 580, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
    MainFrame.BackgroundColor3 = XsaytUI.Theme.Background
    MainFrame.Visible = false
    Corner(MainFrame, 12)
    Stroke(MainFrame, XsaytUI.Theme.ElementStroke, 1)
    MakeDraggable(MainFrame)

    -- Shadows / Accent line top
    local AccentLine = Instance.new("Frame", MainFrame)
    AccentLine.Size = UDim2.new(1,0,0,2)
    AccentLine.Position = UDim2.new(0,0,0,0)
    AccentLine.BackgroundColor3 = XsaytUI.Theme.Accent
    Corner(AccentLine, 99)
    local grad = Instance.new("UIGradient", AccentLine)
    grad.Color = ColorSequence.new{XsaytUI.Theme.Accent, XsaytUI.Theme.Accent2}
    grad.Rotation = 90

    -- Topbar
    local Topbar = Instance.new("Frame", MainFrame)
    Topbar.Size = UDim2.new(1,0,0,45)
    Topbar.BackgroundColor3 = XsaytUI.Theme.Topbar
    Corner(Topbar, 12)
    local fix = Instance.new("Frame", Topbar)
    fix.Size = UDim2.new(1,0,0,12)
    fix.Position = UDim2.new(0,0,1,-12)
    fix.BackgroundColor3 = XsaytUI.Theme.Topbar
    fix.BorderSizePixel = 0
    fix.ZIndex = 0

    local Title = Instance.new("TextLabel", Topbar)
    Title.Text = winName
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.TextColor3 = XsaytUI.Theme.Text
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0,300,1,0)
    Title.Position = UDim2.new(0,15,0,0)
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", Topbar)
    CloseBtn.Size = UDim2.new(0,32,0,32)
    CloseBtn.Position = UDim2.new(1,-40,0,6)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.Text = "×"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
    Corner(CloseBtn, 8)

    local MinBtn = Instance.new("TextButton", Topbar)
    MinBtn.Size = UDim2.new(0,32,0,32)
    MinBtn.Position = UDim2.new(1,-78,0,6)
    MinBtn.BackgroundColor3 = XsaytUI.Theme.Element
    MinBtn.Text = "—"
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 14
    MinBtn.TextColor3 = XsaytUI.Theme.Text
    Corner(MinBtn, 8)
    Stroke(MinBtn, XsaytUI.Theme.ElementStroke,1)

    -- Sidebar
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 150, 1, -45)
    Sidebar.Position = UDim2.new(0,0,0,45)
    Sidebar.BackgroundColor3 = XsaytUI.Theme.Sidebar
    Corner(Sidebar, 12)
    local sFix = Instance.new("Frame", Sidebar)
    sFix.Size = UDim2.new(1,0,0,12)
    sFix.Position = UDim2.new(0,0,0,0)
    sFix.BackgroundColor3 = XsaytUI.Theme.Sidebar
    sFix.BorderSizePixel = 0
    local sFix2 = Instance.new("Frame", Sidebar)
    sFix2.Size = UDim2.new(0,12,1,0)
    sFix2.Position = UDim2.new(1,-12,0,0)
    sFix2.BackgroundColor3 = XsaytUI.Theme.Sidebar
    sFix2.BorderSizePixel = 0

    local TabList = Instance.new("ScrollingFrame", Sidebar)
    TabList.Size = UDim2.new(1,-10,1,-10)
    TabList.Position = UDim2.new(0,5,0,5)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 0
    TabList.CanvasSize = UDim2.new(0,0,0,0)
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local TabLayout = Instance.new("UIListLayout", TabList)
    TabLayout.Padding = UDim.new(0,6)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local TabPad = Instance.new("UIPadding", TabList)
    TabPad.PaddingTop = UDim.new(0,5); TabPad.PaddingLeft = UDim.new(0,5); TabPad.PaddingRight = UDim.new(0,5)

    -- Container
    local Container = Instance.new("Frame", MainFrame)
    Container.Size = UDim2.new(1,-150,1,-45)
    Container.Position = UDim2.new(0,150,0,45)
    Container.BackgroundTransparency = 1

    -- Key System Frame (if enabled)
    local KeyFrame
    if keySystem then
        KeyFrame = Instance.new("Frame", MainFrame)
        KeyFrame.Size = UDim2.new(1,0,1,0)
        KeyFrame.BackgroundColor3 = XsaytUI.Theme.Background
        KeyFrame.ZIndex = 10
        Corner(KeyFrame,12)
        local kTitle = Instance.new("TextLabel", KeyFrame)
        kTitle.Text = keySettings.Title or "Key System"
        kTitle.Font = Enum.Font.GothamBold
        kTitle.TextSize = 20
        kTitle.TextColor3 = XsaytUI.Theme.Text
        kTitle.BackgroundTransparency = 1
        kTitle.Size = UDim2.new(1,0,0,30)
        kTitle.Position = UDim2.new(0,0,0,40)
        local kSub = Instance.new("TextLabel", KeyFrame)
        kSub.Text = keySettings.Subtitle or "Enter Key"
        kSub.Font = Enum.Font.Gotham
        kSub.TextSize = 13
        kSub.TextColor3 = XsaytUI.Theme.SubText
        kSub.BackgroundTransparency = 1
        kSub.Size = UDim2.new(1,0,0,20)
        kSub.Position = UDim2.new(0,0,0,70)
        local kNote = Instance.new("TextLabel", KeyFrame)
        kNote.Text = keySettings.Note or ""
        kNote.Font = Enum.Font.Gotham
        kNote.TextSize = 12
        kNote.TextColor3 = XsaytUI.Theme.SubText
        kNote.BackgroundTransparency = 1
        kNote.Size = UDim2.new(1,-40,0,30)
        kNote.Position = UDim2.new(0,20,0,95)
        kNote.TextWrapped = true

        local KeyBox = Instance.new("TextBox", KeyFrame)
        KeyBox.Size = UDim2.new(0.8,0,0,38)
        KeyBox.Position = UDim2.new(0.1,0,0,145)
        KeyBox.BackgroundColor3 = XsaytUI.Theme.Element
        KeyBox.PlaceholderText = "Enter Key..."
        KeyBox.Text = ""
        KeyBox.Font = Enum.Font.Gotham
        KeyBox.TextSize = 13
        KeyBox.TextColor3 = XsaytUI.Theme.Text
        Corner(KeyBox,8)
        Stroke(KeyBox, XsaytUI.Theme.ElementStroke,1)
        local KeyPad = Instance.new("UIPadding", KeyBox)
        KeyPad.PaddingLeft = UDim.new(0,10)

        local Submit = Instance.new("TextButton", KeyFrame)
        Submit.Size = UDim2.new(0.8,0,0,38)
        Submit.Position = UDim2.new(0.1,0,0,195)
        Submit.BackgroundColor3 = XsaytUI.Theme.Accent
        Submit.Text = "Submit"
        Submit.Font = Enum.Font.GothamBold
        Submit.TextSize = 14
        Submit.TextColor3 = Color3.new(1,1,1)
        Corner(Submit,8)

        local function CheckKey(k)
            for _,v in ipairs(keySettings.Key or {}) do if k==v then return true end end
            return false
        end

        -- Try load saved key
        if keySettings.SaveKey and keySettings.FileName then
            pcall(function()
                if isfile and isfile(keySettings.FileName..".txt") then
                    local saved = readfile(keySettings.FileName..".txt")
                    if CheckKey(saved) then
                        KeyFrame:Destroy()
                        KeyFrame = nil
                        MainFrame.Visible = true
                        LoadingFrame:Destroy()
                        return
                    end
                end
            end)
        end

        Submit.MouseButton1Click:Connect(function()
            if CheckKey(KeyBox.Text) then
                if keySettings.SaveKey and writefile then pcall(function() writefile(keySettings.FileName..".txt", KeyBox.Text) end) end
                XsaytUI:Notify({Title="Key Correct", Content="Welcome!", Duration=2})
                Tween(KeyFrame, {BackgroundTransparency=1}, 0.3)
                task.wait(0.3)
                KeyFrame:Destroy()
                KeyFrame = nil
            else
                XsaytUI:Notify({Title="Invalid Key", Content="Key salah!", Duration=2})
                Tween(KeyBox, {BackgroundColor3=Color3.fromRGB(80,30,30)},0.2)
                task.wait(0.5)
                Tween(KeyBox, {BackgroundColor3=XsaytUI.Theme.Element},0.2)
            end
        end)
    end

    task.delay(0.9, function()
        Tween(LoadingFrame, {BackgroundTransparency=1},0.3)
        for _,v in ipairs(LoadingFrame:GetDescendants()) do if v:IsA("TextLabel") or v:IsA("Frame") then pcall(function() Tween(v,{BackgroundTransparency=1},0.3) end) end end
        task.wait(0.35)
        LoadingFrame:Destroy()
        if not keySystem or not KeyFrame then
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 560, 0, 400)
            Tween(MainFrame, {Size=UDim2.new(0,580,0,420)},0.3, Enum.EasingStyle.Back)
        end
    end)

    -- Window Object
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil

    function Window:CreateTab(name, iconId)
        local TabButton = Instance.new("TextButton", TabList)
        TabButton.Size = UDim2.new(1,0,0,36)
        TabButton.BackgroundColor3 = XsaytUI.Theme.Element
        TabButton.BackgroundTransparency = 1
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        Corner(TabButton,8)

        local Icon = Instance.new("ImageLabel", TabButton)
        Icon.Size = UDim2.new(0,18,0,18)
        Icon.Position = UDim2.new(0,10,0.5,-9)
        Icon.BackgroundTransparency = 1
        Icon.Image = typeof(iconId)=="number" and "rbxassetid://"..iconId or (iconId or "rbxassetid://4483345998")
        Icon.ImageColor3 = XsaytUI.Theme.SubText

        local Txt = Instance.new("TextLabel", TabButton)
        Txt.Text = name
        Txt.Font = Enum.Font.GothamMedium
        Txt.TextSize = 13
        Txt.TextColor3 = XsaytUI.Theme.SubText
        Txt.BackgroundTransparency = 1
        Txt.Size = UDim2.new(1,-40,1,0)
        Txt.Position = UDim2.new(0,34,0,0)
        Txt.TextXAlignment = Enum.TextXAlignment.Left

        local TabPage = Instance.new("ScrollingFrame", Container)
        TabPage.Size = UDim2.new(1,0,1,0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = XsaytUI.Theme.Accent
        TabPage.CanvasSize = UDim2.new(0,0,0,0)
        TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabPage.Visible = false
        local Layout = Instance.new("UIListLayout", TabPage)
        Layout.Padding = UDim.new(0,8)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        local Pad = Instance.new("UIPadding", TabPage)
        Pad.PaddingTop = UDim.new(0,10); Pad.PaddingLeft = UDim.new(0,10); Pad.PaddingRight = UDim.new(0,10); Pad.PaddingBottom = UDim.new(0,10)

        local function Select()
            for _,t in ipairs(Window.Tabs) do
                t.Page.Visible = false
                Tween(t.Button, {BackgroundColor3=XsaytUI.Theme.Element},0.2)
                t.Button.BackgroundTransparency = 1
                t.Button:FindFirstChildOfClass("TextLabel").TextColor3 = XsaytUI.Theme.SubText
                t.Button:FindFirstChildOfClass("ImageLabel").ImageColor3 = XsaytUI.Theme.SubText
            end
            TabPage.Visible = true
            TabButton.BackgroundTransparency = 0
            Tween(TabButton, {BackgroundColor3=XsaytUI.Theme.Element},0.2)
            Txt.TextColor3 = XsaytUI.Theme.Text
            Icon.ImageColor3 = XsaytUI.Theme.Accent
            Window.CurrentTab = TabPage
        end

        TabButton.MouseButton1Click:Connect(Select)
        TabButton.MouseEnter:Connect(function()
            if TabPage.Visible==false then Tween(TabButton,{BackgroundTransparency=0.5},0.2) end
        end)
        TabButton.MouseLeave:Connect(function()
            if TabPage.Visible==false then Tween(TabButton,{BackgroundTransparency=1},0.2) end
        end)

        if #Window.Tabs==0 then task.defer(Select) end

        local Tab = {}
        Tab.Button = TabButton
        Tab.Page = TabPage

        function Tab:CreateSection(secName)
            local Sec = Instance.new("Frame", TabPage)
            Sec.Size = UDim2.new(1,0,0,28)
            Sec.BackgroundTransparency = 1
            local L = Instance.new("TextLabel", Sec)
            L.Text = secName
            L.Font = Enum.Font.GothamBold
            L.TextSize = 13
            L.TextColor3 = XsaytUI.Theme.Text
            L.BackgroundTransparency = 1
            L.Size = UDim2.new(1,0,1,0)
            L.TextXAlignment = Enum.TextXAlignment.Left
            local Line = Instance.new("Frame", Sec)
            Line.Size = UDim2.new(1,0,0,1)
            Line.Position = UDim2.new(0,0,1,-1)
            Line.BackgroundColor3 = XsaytUI.Theme.ElementStroke
            Line.BackgroundTransparency = 0.5
            Line.BorderSizePixel = 0
            return Sec
        end

        function Tab:CreateLabel(text)
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,30)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = text
            LB.Font = Enum.Font.Gotham
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(1,-20,1,0)
            LB.Position = UDim2.new(0,10,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            LB.TextWrapped = true
            return {Set=function(_,t) LB.Text=t end}
        end

        function Tab:CreateParagraph(cfg)
            cfg=cfg or {}
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,60)
            F.AutomaticSize = Enum.AutomaticSize.Y
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local Title = Instance.new("TextLabel", F)
            Title.Text = cfg.Title or "Paragraph"
            Title.Font = Enum.Font.GothamBold
            Title.TextSize = 14
            Title.TextColor3 = XsaytUI.Theme.Text
            Title.BackgroundTransparency = 1
            Title.Size = UDim2.new(1,-20,0,20)
            Title.Position = UDim2.new(0,10,0,8)
            Title.TextXAlignment = Enum.TextXAlignment.Left
            local Content = Instance.new("TextLabel", F)
            Content.Text = cfg.Content or ""
            Content.Font = Enum.Font.Gotham
            Content.TextSize = 12
            Content.TextColor3 = XsaytUI.Theme.SubText
            Content.BackgroundTransparency = 1
            Content.Size = UDim2.new(1,-20,0,0)
            Content.AutomaticSize = Enum.AutomaticSize.Y
            Content.Position = UDim2.new(0,10,0,28)
            Content.TextXAlignment = Enum.TextXAlignment.Left
            Content.TextWrapped = true
            Instance.new("UIPadding", F).PaddingBottom = UDim.new(0,10)
            return {Set=function(_,t,c) Title.Text=t; Content.Text=c end}
        end

        function Tab:CreateButton(cfg)
            cfg=cfg or {}
            local Btn = Instance.new("TextButton", TabPage)
            Btn.Size = UDim2.new(1,0,0,36)
            Btn.BackgroundColor3 = XsaytUI.Theme.Element
            Btn.Text = ""
            Btn.AutoButtonColor = false
            Corner(Btn,8); Stroke(Btn)
            local LB = Instance.new("TextLabel", Btn)
            LB.Text = cfg.Name or "Button"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(1,-20,1,0)
            LB.Position = UDim2.new(0,10,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local Ico = Instance.new("ImageLabel", Btn)
            Ico.Size = UDim2.new(0,18,0,18)
            Ico.Position = UDim2.new(1,-28,0.5,-9)
            Ico.BackgroundTransparency = 1
            Ico.Image = "rbxassetid://6031090997"
            Ico.ImageColor3 = XsaytUI.Theme.SubText
            Btn.MouseEnter:Connect(function() Tween(Btn,{BackgroundColor3=Color3.fromRGB(34,34,40)},0.2) end)
            Btn.MouseLeave:Connect(function() Tween(Btn,{BackgroundColor3=XsaytUI.Theme.Element},0.2) end)
            Btn.MouseButton1Click:Connect(function()
                Tween(Btn,{BackgroundColor3=XsaytUI.Theme.Accent},0.1)
                task.wait(0.1)
                Tween(Btn,{BackgroundColor3=XsaytUI.Theme.Element},0.2)
                pcall(cfg.Callback)
            end)
            return {Set=function(_,t) LB.Text=t end}
        end

        function Tab:CreateToggle(cfg)
            cfg=cfg or {}
            local flag = cfg.Flag
            local val = cfg.CurrentValue or false
            if flag then XsaytUI.Flags[flag]=val end
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,38)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = cfg.Name or "Toggle"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(1,-60,1,0)
            LB.Position = UDim2.new(0,12,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local SwitchBG = Instance.new("Frame", F)
            SwitchBG.Size = UDim2.new(0,44,0,24)
            SwitchBG.Position = UDim2.new(1,-56,0.5,-12)
            SwitchBG.BackgroundColor3 = val and XsaytUI.Theme.Accent or Color3.fromRGB(45,45,52)
            Corner(SwitchBG,99)
            local Dot = Instance.new("Frame", SwitchBG)
            Dot.Size = UDim2.new(0,18,0,18)
            Dot.Position = val and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,3,0.5,-9)
            Dot.BackgroundColor3 = Color3.new(1,1,1)
            Corner(Dot,99)
            local Btn = Instance.new("TextButton", F)
            Btn.Size = UDim2.new(1,0,1,0)
            Btn.BackgroundTransparency = 1
            Btn.Text = ""
            local function Set(v)
                val=v
                if flag then XsaytUI.Flags[flag]=v end
                Tween(SwitchBG,{BackgroundColor3 = v and XsaytUI.Theme.Accent or Color3.fromRGB(45,45,52)},0.2)
                Tween(Dot,{Position = v and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,3,0.5,-9)},0.2)
                if configSaving.Enabled and flag then SaveConfig(configSaving.FolderName or "XsaytUI", configSaving.FileName or "config", XsaytUI.Flags) end
                pcall(function() cfg.Callback(v) end)
            end
            Btn.MouseButton1Click:Connect(function() Set(not val) end)
            -- load from config
            if configSaving.Enabled and flag then
                local data=LoadConfig(configSaving.FolderName or "XsaytUI", configSaving.FileName or "config")
                if data and data[flag]~=nil then Set(data[flag]) end
            end
            return {Set=Set, Get=function() return val end}
        end

        function Tab:CreateSlider(cfg)
            cfg=cfg or {}
            local flag=cfg.Flag
            local min,max = cfg.Range[1], cfg.Range[2]
            local inc = cfg.Increment or 1
            local val = cfg.CurrentValue or min
            if flag then XsaytUI.Flags[flag]=val end
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,52)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = cfg.Name or "Slider"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(0.7,0,0,20)
            LB.Position = UDim2.new(0,12,0,6)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local ValLB = Instance.new("TextLabel", F)
            ValLB.Text = tostring(val)..(cfg.Suffix and " "..cfg.Suffix or "")
            ValLB.Font = Enum.Font.GothamBold
            ValLB.TextSize = 12
            ValLB.TextColor3 = XsaytUI.Theme.Accent
            ValLB.BackgroundTransparency = 1
            ValLB.Size = UDim2.new(0.3,-12,0,20)
            ValLB.Position = UDim2.new(0.7,0,0,6)
            ValLB.TextXAlignment = Enum.TextXAlignment.Right
            local BG = Instance.new("Frame", F)
            BG.Size = UDim2.new(1,-24,0,6)
            BG.Position = UDim2.new(0,12,0,32)
            BG.BackgroundColor3 = Color3.fromRGB(45,45,52)
            Corner(BG,99)
            local Fill = Instance.new("Frame", BG)
            Fill.Size = UDim2.new((val-min)/(max-min),0,1,0)
            Fill.BackgroundColor3 = XsaytUI.Theme.Accent
            Corner(Fill,99)
            local DragBtn = Instance.new("TextButton", BG)
            DragBtn.Size = UDim2.new(1,0,1,0)
            DragBtn.BackgroundTransparency = 1
            DragBtn.Text = ""
            local dragging=false
            local function Update(input)
                local pos = math.clamp((input.Position.X - BG.AbsolutePosition.X)/BG.AbsoluteSize.X,0,1)
                local raw = min + (max-min)*pos
                local stepped = math.floor(raw/inc+0.5)*inc
                stepped = math.clamp(stepped,min,max)
                val=stepped
                if flag then XsaytUI.Flags[flag]=val end
                Tween(Fill,{Size=UDim2.new((val-min)/(max-min),0,1,0)},0.1)
                ValLB.Text = tostring(val)..(cfg.Suffix and " "..cfg.Suffix or "")
                if configSaving.Enabled and flag then SaveConfig(configSaving.FolderName or "XsaytUI", configSaving.FileName or "config", XsaytUI.Flags) end
                pcall(function() cfg.Callback(val) end)
            end
            DragBtn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; Update(i) end end)
            DragBtn.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
            UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then Update(i) end end)
            return {Set=function(_,v) val=v; Fill.Size=UDim2.new((val-min)/(max-min),0,1,0); ValLB.Text=tostring(val)..(cfg.Suffix and " "..cfg.Suffix or "") end}
        end

        function Tab:CreateDropdown(cfg)
            cfg=cfg or {}
            local flag=cfg.Flag
            local opts=cfg.Options or {}
            local multi=cfg.MultipleOptions or false
            local cur = cfg.CurrentOption or (multi and {} or {opts[1]})
            if typeof(cur)=="string" then cur={cur} end
            if flag then XsaytUI.Flags[flag]= multi and cur or cur[1] end
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,38)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            F.ClipsDescendants = true
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = cfg.Name or "Dropdown"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(0.5,0,0,38)
            LB.Position = UDim2.new(0,12,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local Disp = Instance.new("TextLabel", F)
            Disp.Text = table.concat(cur, ", ")
            Disp.Font = Enum.Font.Gotham
            Disp.TextSize = 12
            Disp.TextColor3 = XsaytUI.Theme.SubText
            Disp.BackgroundTransparency = 1
            Disp.Size = UDim2.new(0.5,-30,0,38)
            Disp.Position = UDim2.new(0.5,0,0,0)
            Disp.TextXAlignment = Enum.TextXAlignment.Right
            Disp.TextTruncate = Enum.TextTruncate.AtEnd
            local Arrow = Instance.new("ImageLabel", F)
            Arrow.Size = UDim2.new(0,16,0,16)
            Arrow.Position = UDim2.new(1,-24,0.5,-8)
            Arrow.BackgroundTransparency = 1
            Arrow.Image = "rbxassetid://6031090997"
            Arrow.Rotation = 90
            Arrow.ImageColor3 = XsaytUI.Theme.SubText
            local Btn = Instance.new("TextButton", F)
            Btn.Size = UDim2.new(1,0,0,38)
            Btn.BackgroundTransparency = 1
            Btn.Text = ""
            local List = Instance.new("Frame", F)
            List.Size = UDim2.new(1,-10,0,0)
            List.Position = UDim2.new(0,5,0,42)
            List.BackgroundTransparency = 1
            local LList = Instance.new("UIListLayout", List)
            LList.Padding = UDim.new(0,4)
            local open=false
            local function Refresh() Disp.Text = multi and table.concat(cur, ", ") or (cur[1] or "") end
            local function Toggle()
                open=not open
                Tween(Arrow,{Rotation = open and 270 or 90},0.2)
                F.ClipsDescendants = true
                Tween(F,{Size = open and UDim2.new(1,0,0,42 + #opts*30 + (#opts-1)*4) or UDim2.new(1,0,0,38)},0.25)
            end
            Btn.MouseButton1Click:Connect(Toggle)
            for _,opt in ipairs(opts) do
                local O = Instance.new("TextButton", List)
                O.Size = UDim2.new(1,0,0,30)
                O.BackgroundColor3 = Color3.fromRGB(34,34,40)
                O.Text = opt
                O.Font = Enum.Font.Gotham
                O.TextSize = 12
                O.TextColor3 = XsaytUI.Theme.Text
                Corner(O,6)
                O.MouseButton1Click:Connect(function()
                    if multi then
                        local idx=table.find(cur, opt)
                        if idx then table.remove(cur, idx) else table.insert(cur, opt) end
                    else
                        cur={opt}; open=false; Tween(F,{Size=UDim2.new(1,0,0,38)},0.2); Tween(Arrow,{Rotation=90},0.2)
                    end
                    Refresh()
                    if flag then XsaytUI.Flags[flag]= multi and cur or cur[1] end
                    if configSaving.Enabled and flag then SaveConfig(configSaving.FolderName or "XsaytUI", configSaving.FileName or "config", XsaytUI.Flags) end
                    pcall(function() cfg.Callback(multi and cur or cur) end)
                    for _,b in ipairs(List:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = (table.find(cur,b.Text) and XsaytUI.Theme.Accent or Color3.fromRGB(34,34,40)) end end
                end)
            end
            -- initial select colors
            task.defer(function()
                for _,b in ipairs(List:GetChildren()) do if b:IsA("TextButton") and table.find(cur,b.Text) then b.BackgroundColor3=XsaytUI.Theme.Accent end end
            end)
            return {Set=function(_,v) cur= typeof(v)=="table" and v or {v}; Refresh() end, Refresh=Refresh}
        end

        function Tab:CreateInput(cfg)
            cfg=cfg or {}
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,38)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = cfg.Name or "Input"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(0.4,0,1,0)
            LB.Position = UDim2.new(0,12,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local Box = Instance.new("TextBox", F)
            Box.Size = UDim2.new(0.55,-10,0,26)
            Box.Position = UDim2.new(0.45,0,0.5,-13)
            Box.BackgroundColor3 = Color3.fromRGB(18,18,22)
            Box.PlaceholderText = cfg.PlaceholderText or "..."
            Box.Text = ""
            Box.Font = Enum.Font.Gotham
            Box.TextSize = 12
            Box.TextColor3 = XsaytUI.Theme.Text
            Box.ClearTextOnFocus = false
            Corner(Box,6); Stroke(Box, Color3.fromRGB(45,45,55),1)
            local Pad = Instance.new("UIPadding", Box); Pad.PaddingLeft=UDim.new(0,8)
            Box.FocusLost:Connect(function(enter)
                if enter or cfg.RemoveTextAfterFocusLost==false then
                    pcall(function() cfg.Callback(Box.Text) end)
                    if cfg.RemoveTextAfterFocusLost then Box.Text="" end
                end
            end)
            return {Set=function(_,v) Box.Text=v end}
        end

        function Tab:CreateColorPicker(cfg)
            cfg=cfg or {}
            local flag=cfg.Flag
            local col=cfg.Color or Color3.fromRGB(255,0,0)
            if flag then XsaytUI.Flags[flag]=col end
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,38)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = cfg.Name or "ColorPicker"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(1,-60,1,0)
            LB.Position = UDim2.new(0,12,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local Prev = Instance.new("Frame", F)
            Prev.Size = UDim2.new(0,28,0,28)
            Prev.Position = UDim2.new(1,-38,0.5,-14)
            Prev.BackgroundColor3 = col
            Corner(Prev,6); Stroke(Prev, Color3.new(1,1,1),1)
            local Btn = Instance.new("TextButton", F)
            Btn.Size = UDim2.new(1,0,1,0)
            Btn.BackgroundTransparency = 1
            Btn.Text = ""
            -- simple: clicking cycles hue (no complex picker to keep lightweight)
            Btn.MouseButton1Click:Connect(function()
                -- open palette simple: random color for demo, real will open HSV
                -- For now use a simple prompt: toggle between red/blue
                col = Color3.fromHSV(math.random(),1,1)
                Prev.BackgroundColor3 = col
                if flag then XsaytUI.Flags[flag]=col end
                pcall(function() cfg.Callback(col) end)
            end)
            return {Set=function(_,c) col=c; Prev.BackgroundColor3=c end}
        end

        function Tab:CreateKeybind(cfg)
            cfg=cfg or {}
            local flag=cfg.Flag
            local cur = cfg.CurrentKeybind or "K"
            if flag then XsaytUI.Flags[flag]=cur end
            local F = Instance.new("Frame", TabPage)
            F.Size = UDim2.new(1,0,0,38)
            F.BackgroundColor3 = XsaytUI.Theme.Element
            Corner(F,8); Stroke(F)
            local LB = Instance.new("TextLabel", F)
            LB.Text = cfg.Name or "Keybind"
            LB.Font = Enum.Font.GothamMedium
            LB.TextSize = 13
            LB.TextColor3 = XsaytUI.Theme.Text
            LB.BackgroundTransparency = 1
            LB.Size = UDim2.new(0.5,0,1,0)
            LB.Position = UDim2.new(0,12,0,0)
            LB.TextXAlignment = Enum.TextXAlignment.Left
            local KeyBtn = Instance.new("TextButton", F)
            KeyBtn.Size = UDim2.new(0,80,0,26)
            KeyBtn.Position = UDim2.new(1,-90,0.5,-13)
            KeyBtn.BackgroundColor3 = Color3.fromRGB(18,18,22)
            KeyBtn.Text = cur
            KeyBtn.Font = Enum.Font.GothamBold
            KeyBtn.TextSize = 12
            KeyBtn.TextColor3 = XsaytUI.Theme.Text
            Corner(KeyBtn,6); Stroke(KeyBtn)
            local listening=false
            KeyBtn.MouseButton1Click:Connect(function()
                listening=true; KeyBtn.Text="..."
            end)
            UserInputService.InputBegan:Connect(function(input, gp)
                if listening and not gp then
                    local key = input.KeyCode.Name ~= "Unknown" and input.KeyCode.Name or input.UserInputType.Name
                    cur=key; KeyBtn.Text=cur
                    if flag then XsaytUI.Flags[flag]=cur end
                    listening=false
                    pcall(function() cfg.Callback(cur) end)
                end
            end)
            return {Set=function(_,k) cur=k; KeyBtn.Text=k end}
        end

        table.insert(Window.Tabs, Tab)
        return Tab
    end

    function Window:Destroy()
        ScreenGui:Destroy()
    end
    function XsaytUI:Destroy() ScreenGui:Destroy() end

    -- Minimize / Close
    local minimized=false
    MinBtn.MouseButton1Click:Connect(function()
        minimized=not minimized
        Tween(Container,{BackgroundTransparency=minimized and 1 or 1},0.2)
        Tween(Sidebar,{BackgroundTransparency=minimized and 1 or 0},0.2)
        for _,v in ipairs(Container:GetDescendants()) do pcall(function() v.Visible = not minimized and true or false end) end
        for _,v in ipairs(Sidebar:GetChildren()) do pcall(function() v.Visible = not minimized end) end
        Tween(MainFrame,{Size = minimized and UDim2.new(0,580,0,45) or UDim2.new(0,580,0,420)},0.25)
    end)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Toggle UI with Key (default K = RightControl alternative)
    local toggleKey = Enum.KeyCode.RightControl
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == toggleKey or input.KeyCode == Enum.KeyCode.K then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    return Window
end

return XsaytUI
