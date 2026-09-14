-- CatherFI UI - Example Legacy untuk Roblox Platform
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/drcreatordev/CatherFI-UI/main/legacy/CatherFIUI.lua"))()

local CatherFIUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/drcreatordev/CatherFI-UI/main/legacy/CatherFIUI.lua"))()

local Window = CatherFIUI:CreateWindow({
   Name = "CatherFI Hub | Roblox 🔥",
   LoadingTitle = "CatherFI Library",
   LoadingSubtitle = "by CatherFI",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "CatherFIUI",
      FileName = "CatherFIHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "CatherFI Key System",
      Subtitle = "Key System",
      Note = "Join discord untuk key",
      FileName = "CatherFIKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"CatherFI-123"}
   }
})

-- Tab 1 Main
local MainTab = Window:CreateTab("Main", 4483345998)
MainTab:CreateSection("Player Features")

MainTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
       print("AutoFarm:", Value)
   end,
})

MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

MainTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character then
           game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
       end
   end,
})

MainTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

MainTab:CreateDropdown({
   Name = "Select Weapon",
   Options = {"Katana","Gun","Sword","Blox Fruit"},
   CurrentOption = {"Katana"},
   MultipleOptions = false,
   Flag = "WeaponDropdown",
   Callback = function(Option)
       print("Selected:", table.concat(Option, ", "))
   end,
})

-- Tab 2 Settings
local SettingsTab = Window:CreateTab("Settings", 4483345998)
SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateInput({
   Name = "Player Name",
   PlaceholderText = "Masukkan nama player",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       print("Input:", Text)
   end,
})

SettingsTab:CreateColorPicker({
   Name = "Theme Color",
   Color = Color3.fromRGB(255, 0, 0),
   Flag = "ThemeColor",
   Callback = function(Value)
       print("Color:", Value)
   end,
})

SettingsTab:CreateKeybind({
   Name = "Toggle UI",
   CurrentKeybind = "K",
   HoldToInteract = false,
   Flag = "ToggleUI",
   Callback = function(Keybind)
       print("Keybind:", Keybind)
   end,
})

SettingsTab:CreateLabel("CatherFI UI v1.0 - Roblox Edition")
SettingsTab:CreateParagraph({Title = "Info", Content = "UI Library legacy v1, gunakan CatherFI.lua v2 untuk fitur premium."})

SettingsTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
       CatherFIUI:Destroy()
   end,
})

CatherFIUI:Notify({
   Title = "CatherFI Loaded!",
   Content = "UI berhasil dimuat untuk Roblox",
   Duration = 5,
   Image = 4483345998,
})
