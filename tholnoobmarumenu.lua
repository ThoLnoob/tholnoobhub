--// Script Auto Farm Blox Fruits - MARU HUB UI

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/UI-Libraries/main/Kavo/Kavo.lua"))()
local Window = Library.CreateLib("Tho Lnoob Hub", "DarkTheme")

-- Tabs
local GeneralTab = Window:NewTab("General")
local CombatTab = Window:NewTab("Combat")
local IslandTab = Window:NewTab("Island")

-- Sections
local GeneralSection = GeneralTab:NewSection("Auto Farm")
local CombatSection = CombatTab:NewSection("Settings")

-- Biến Auto Farm
getgenv().AutoFarm = false

-- Auto Farm Toggle
GeneralSection:NewToggle("Enabled Fast Farm", "Tự động farm quái", function(state)
    getgenv().AutoFarm = state
    if state then
        StartAutoFarm()
    end
end)

-- Dropdown chọn vũ khí
local WeaponSelected = "Melee"
CombatSection:NewDropdown("Select Combat / Weapon", "Chọn vũ khí để farm", {"Melee", "Sword", "Gun"}, function(selected)
    WeaponSelected = selected
end)

-- Auto Farm Function
function StartAutoFarm()
    spawn(function()
        while getgenv().AutoFarm do
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                local MeleeWeapon = nil
                
                -- Tìm vũ khí thuộc loại đã chọn
                for _, tool in ipairs(Character:GetChildren()) do
                    if tool:IsA("Tool") and tool:FindFirstChild("Melee") and WeaponSelected == "Melee" then
                        MeleeWeapon = tool
                        break
                    elseif tool:IsA("Tool") and tool:FindFirstChild("Sword") and WeaponSelected == "Sword" then
                        MeleeWeapon = tool
                        break
                    elseif tool:IsA("Tool") and tool:FindFirstChild("Gun") and WeaponSelected == "Gun" then
                        MeleeWeapon = tool
                        break
                    end
                end
                
                -- Trang bị vũ khí
                if MeleeWeapon then
                    Character.Humanoid:EquipTool(MeleeWeapon)
                end
                
                -- Thực hiện farm quái
                -- (Thêm logic farm quái ở đây)
            end
            wait(1) -- Chờ để tránh lag
        end
    end)
end

-- UI bật/tắt bằng logo "M"
local UserInputService = game:GetService("UserInputService")
local GuiEnabled = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.M and not gameProcessed then
        GuiEnabled = not GuiEnabled
        Window:Toggle(GuiEnabled)
    end
end)
