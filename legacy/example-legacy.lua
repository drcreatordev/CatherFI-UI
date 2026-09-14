-- XSAYT UI - Example Legacy untuk Delta Executor
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/legacy/XsaytUI.lua"))()

local XsaytUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/myzakonz-gif/UI-LIB-XSAYT/main/legacy/XsaytUI.lua"))()

local Window = XsaytUI:CreateWindow({
   Name = "XSAYT Hub | Delta 🔥",
   LoadingTitle = "XSAYT Library",
   LoadingSubtitle = "by myzakonz",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "XsaytUI",
      FileName = "XsaytHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "XSAYT Key System",
      Subtitle = "Key System",
      Note = "Join discord untuk key",
      FileName = "XsaytKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"XSAYT-123"}
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

SettingsTab:CreateLabel("XSAYT UI v1.0 - Delta Edition")
SettingsTab:CreateParagraph({Title = "Info", Content = "UI Library legacy v1, gunakan XSAYT.lua v2 untuk fitur premium."})

SettingsTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
       XsaytUI:Destroy()
   end,
})

XsaytUI:Notify({
   Title = "XSAYT Loaded!",
   Content = "UI berhasil dimuat untuk Delta",
   Duration = 5,
   Image = 4483345998,
})
