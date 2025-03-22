local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--------------------------------------------------------------------------------------------------------------------------------------------
local Window = Fluent:CreateWindow({
    Title = "Tho Lnoob Hub",
    SubTitle = "Version Beta Menu",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 350),
    Acrylic = false, -- Tắt Blur để tránh bị phát hiện
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.M
})

local v22 = Instance.new("ScreenGui");
local v23 = Instance.new("ImageButton");
local v24 = Instance.new("UICorner");
local v25 = Instance.new("ParticleEmitter");
local v26 = game:GetService("TweenService");

v22.Parent = game.CoreGui;
v22.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

v23.Parent = v22;
v23.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v23.BorderSizePixel = 0;
v23.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0);
v23.Size = UDim2.new(0, 50, 0, 50);
v23.Draggable = true;
v23.Image = "http://www.roblox.com/asset/?id=89300403770535"; -- change this to your own icon

v24.Parent = v23;
v24.CornerRadius = UDim.new(0, 12);

v25.Parent = v23;
v25.LightEmission = 1;
v25.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.1),
    NumberSequenceKeypoint.new(1, 0)
});
v25.Lifetime = NumberRange.new(0.5, 1);
v25.Rate = 0;
v25.Speed = NumberRange.new(5, 10);
v25.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255));

local v47 = v26:Create(v23, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {});

v23.MouseButton1Down:Connect(function()
    v25.Rate = 100;
    task.delay(1, function()
        v25.Rate = 0;
    end);
    v47:Play();
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game);
end)

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
