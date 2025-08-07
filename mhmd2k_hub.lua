-- mhmd2k_hub.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")

local Hub = {}

-- CONFIG (default toggles)
Hub.Features = {
    AntiHitSteal = true,
    AutoSkyDelivery = true,
    PlayerESP = true,
    BaseLockTimerESP = true,
    AutoSteal = false,
    AutoBuyBrainrot = false,
    AutoRebirth = false,
    AutoRespawnAura = false,
    TouchFling = false,
    HitAura = false,
    UltraSpeed = false,
    NoEffects = false,
    AlwaysInvisible = false,
    VoidPlayer = false,
}

local ALLOWED_INVISIBILITY_CLOAK_NAME = "Invisibility Cloak" -- Adjust as needed

-- UTILITIES

function Hub:HasInvisibilityCloak()
    local character = LocalPlayer.Character
    if not character then return false end
    local cloak = character:FindFirstChild(ALLOWED_INVISIBILITY_CLOAK_NAME) or character:FindFirstChildWhichIsA("Tool") and (character:FindFirstChildWhichIsA("Tool").Name == ALLOWED_INVISIBILITY_CLOAK_NAME)
    return cloak ~= nil
end

function Hub:EquipInvisibilityCloak()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local cloak = backpack:FindFirstChild(ALLOWED_INVISIBILITY_CLOAK_NAME)
    if cloak then
        cloak.Parent = LocalPlayer.Character
    end
end

-- FEATURE THREADS

function Hub:EnableVoidPlayer()
    if self.VoidPlayerThread then return end
    self.VoidPlayerThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.VoidPlayer then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
            end
        end
    end)
end

function Hub:EnableAntiHitSteal()
    if self.AntiHitStealThread then return end
    self.AntiHitStealThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.AntiHitSteal then
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

function Hub:AlwaysInvisible()
    if self.AlwaysInvisibleThread then return end
    self.AlwaysInvisibleThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.AlwaysInvisible and not self:HasInvisibilityCloak() then
            self:EquipInvisibilityCloak()
        end
    end)
end

function Hub:RemoveEffects()
    if self.NoEffectsThread then return end
    self.NoEffectsThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.NoEffects then
            for _, effect in pairs(Workspace:GetChildren()) do
                if effect.Name == "BoogieBombEffect" or effect.Name == "BeeLauncherEffect" then
                    effect:Destroy()
                end
            end
        end
    end)
end

function Hub:EnableUltraSpeed()
    if self.UltraSpeedThread then return end
    self.UltraSpeedThread = RunService.Heartbeat:Connect(function()
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if Hub.Features.UltraSpeed and self:HasInvisibilityCloak() then
                humanoid.WalkSpeed = 100
            else
                humanoid.WalkSpeed = 16
            end
        end
    end)
end

function Hub:TouchFling()
    if self.TouchFlingThread then return end
    self.TouchFlingThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.TouchFling then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 10 then
                            local bodyVelocity = Instance.new("BodyVelocity")
                            bodyVelocity.Velocity = (player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Unit * 100
                            bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
                            bodyVelocity.Parent = character.HumanoidRootPart
                            Debris:AddItem(bodyVelocity, 0.1)
                        end
                    end
                end
            end
        end
    end)
end

function Hub:AntiSlow()
    if self.AntiSlowThread then return end
    self.AntiSlowThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.AutoSteal or Hub.Features.TouchFling then -- example condition to keep speed up during steals
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed < 16 then
                humanoid.WalkSpeed = 16
            end
        end
    end)
end

-- BRAINROT ESP
function Hub:EnableBrainrotESP()
    if self.BrainrotESPThread then return end
    self.BrainrotESPThread = RunService.Heartbeat:Connect(function()
        if Hub.Features.PlayerESP then
            for _, brainrot in pairs(Workspace:GetChildren()) do
                if brainrot.Name == "Brainrot" then
                    if not brainrot:FindFirstChildOfClass("Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = brainrot
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                        highlight.Parent = brainrot
                    end
                end
            end
        end
    end)
end

-- REDUCE LAG
function Hub:ReduceLag()
    if self.ReduceLagDone then return end
    self.ReduceLagDone = true
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 10000
    pcall(function()
        settings().Rendering.QualityLevel = "Level01"
    end)
end

-- Placeholder implementations for others
function Hub:AutoBuyBrainrot()
    -- Implement game specific remote calls if you want
end

function Hub:AutoSteal()
    -- Implement auto steal logic
end

function Hub:AutoRebirth()
    -- Implement auto rebirth logic
end

function Hub:AutoSkyDelivery()
    -- Implement auto sky delivery logic
end

function Hub:AutoRespawnAura()
    -- Implement auto respawn aura logic
end

function Hub:HitAura()
    -- Implement hit aura logic
end

function Hub:StunlockPlayers()
    -- Implement stunlock logic
end

function Hub:AutoVoidAura()
    -- Implement auto void aura logic
end

function Hub:ServerHop()
    -- Implement server hop logic if you want
end

-- GUI CREATION (Dark theme + rainbow neon M logo background)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "mhmd2kHubGui"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 500)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local logoLabel = Instance.new("TextLabel", mainFrame)
logoLabel.Size = UDim2.new(1, 0, 1, 0)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "M"
logoLabel.Font = Enum.Font.GothamBlack
logoLabel.TextSize = 300
logoLabel.TextStrokeTransparency = 0
logoLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
logoLabel.TextTransparency = 0.9

spawn(function()
    local colors = {
        Color3.fromRGB(255,0,0),
        Color3.fromRGB(255,127,0),
        Color3.fromRGB(255,255,0),
        Color3.fromRGB(0,255,0),
        Color3.fromRGB(0,0,255),
        Color3.fromRGB(75,0,130),
        Color3.fromRGB(148,0,211),
    }
    local i = 1
    while true do
        logoLabel.TextColor3 = colors[i]
        i = i + 1
        if i > #colors then i = 1 end
        wait(0.2)
    end
end)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "mhmd2k Hub"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 28

local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Text = "-"
minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
minimizeBtn.Position = UDim2.new(1, -45, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 32
minimizeBtn.BorderSizePixel = 0

local minimizedBtn = Instance.new("TextButton", screenGui)
minimizedBtn.Name = "MinimizedMHMD2K"
minimizedBtn.Text = "M"
minimizedBtn.Font = Enum.Font.GothamBlack
minimizedBtn.TextSize = 48
minimizedBtn.Size = UDim2.new(0, 50, 0, 50)
minimizedBtn.Position = UDim2.new(0, 10, 0, 10)
minimizedBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
minimizedBtn.TextColor3 = Color3.fromRGB(255,0,255)
minimizedBtn.Visible = false
minimizedBtn.BorderSizePixel = 0

local toggleContainer = Instance.new("ScrollingFrame", mainFrame)
toggleContainer.Size = UDim2.new(1, -20, 1, -70)
toggleContainer.Position = UDim2.new(0, 10, 0, 60)
toggleContainer.BackgroundTransparency = 1
toggleContainer.ScrollBarThickness = 5
toggleContainer.CanvasSize = UDim2.new(0, 0, 0, 450)

local function createToggle(name, default)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.Text = name..": "..(default and "ON" or "OFF")

    local enabled = default
    Hub.Features[name] = default

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = name..": "..(enabled and "ON" or "OFF")
        Hub.Features[name] = enabled
    end)

    return btn
end

local toggles = {
    {name = "AntiHitSteal", default = true},
    {name = "AutoSkyDelivery", default = true},
    {name = "PlayerESP", default = true},
    {name = "BaseLockTimerESP", default = true},
    {name = "AutoSteal", default = false},
    {name = "AutoBuyBrainrot", default = false},
    {name = "AutoRebirth", default = false},
    {name = "AutoRespawnAura", default = false},
    {name = "TouchFling", default = false},
    {name = "HitAura", default = false},
    {name = "UltraSpeed", default = false},
    {name = "NoEffects", default = false},
    {name = "AlwaysInvisible", default = false},
    {name = "VoidPlayer", default = false},
}

for i, toggleInfo in ipairs(toggles) do
    local toggle = createToggle(toggleInfo.name, toggleInfo.default)
    toggle.Position = UDim2.new(0, 0, 0, (i-1)*45)
    toggle.Parent = toggleContainer
end

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedBtn.Visible = true
end)

minimizedBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizedBtn.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        mainFrame.Visible = true
        minimizedBtn.Visible = false
    end
end)

-- START ALL THREADS THAT NEED TO RUN (some wait for toggles)

Hub:EnableVoidPlayer()
Hub:EnableAntiHitSteal()
Hub:AlwaysInvisible()
Hub:RemoveEffects()
Hub:EnableUltraSpeed()
Hub:TouchFling()
Hub:AntiSlow()
Hub:EnableBrainrotESP()
Hub:ReduceLag()

print("mhmd2k Hub Loaded!")

return Hub
