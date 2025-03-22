local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--------------------------------------------------------------------------------------------------------------------------------------------
local Window = Fluent:CreateWindow({
    Title = "Tho Lnoob Hub",
    SubTitle = "Version Beta",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 350),
    Acrylic = false, -- Tắt Blur để tránh bị phát hiện
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.M
})

-- Tabs Menu
local Tabs = {
    Main = Window:AddTab({ Title = "Auto Farm", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Chiến Đấu", Icon = "sword" }),
    Teleport = Window:AddTab({ Title = "Dịch Chuyển", Icon = "map" }),
    Raid = Window:AddTab({ Title = "Auto Raid", Icon = "skull" }),
    Stats = Window:AddTab({ Title = "Chỉ Số", Icon = "plus-circle" }),
    Misc = Window:AddTab({ Title = "Khác", Icon = "cog" }),
}

-- Chức năng chống Ban
function AntiBan()
    for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("LocalScript") and (v.Name == "General" or v.Name == "Shiftlock" or v.Name == "Run") then
            v:Destroy()
        end
    end
end
AntiBan()

-- Auto Farm Quái
local AutoFarm = false
Tabs.Main:AddToggle("AutoFarm", { Text = "Bật/Tắt Auto Farm", Default = false }, function(Value)
    AutoFarm = Value
    while AutoFarm do
        local Player = game.Players.LocalPlayer
        local HumanoidRootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            for _, Mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if Mob:FindFirstChild("HumanoidRootPart") and Mob:FindFirstChild("Humanoid") then
                    HumanoidRootPart.CFrame = Mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Hitbox", Mob)
                end
            end
        end
        wait(0.1)
    end
end)

-- Teleport Đến NPC
Tabs.Teleport:AddDropdown("Chọn NPC", { Text = "Chọn NPC", Values = {"Shop", "Quests", "Bosses"} }, function(Value)
    local Locations = {
        ["Shop"] = CFrame.new(1210, 20, 350),
        ["Quests"] = CFrame.new(-300, 15, 1000),
        ["Bosses"] = CFrame.new(500, 50, -200)
    }
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Locations[Value]
end)

-- Auto Raid An Toàn
local AutoRaid = false
Tabs.Raid:AddToggle("AutoRaid", { Text = "Bật/Tắt Auto Raid", Default = false }, function(Value)
    AutoRaid = Value
    while AutoRaid do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartRaid", "Flame")
        wait(5)
    end
end)

Fluent:Notify({
    Title = "Script Loaded",
    Content = "Script đã được tải thành công!",
    Duration = 3
})
