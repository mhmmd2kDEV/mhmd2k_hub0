-- mhmd2k minimal key loader + full hub combined

local KEY = "MHMMDWSCRIPTS"

-- Key GUI Setup
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "mhmd2kLoader"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 130)
frame.Position = UDim2.new(0.5, -125, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "mhmd2k Hub Key"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(1, -20, 0, 30)
input.Position = UDim2.new(0, 10, 0, 40)
input.PlaceholderText = "Enter key..."
input.Text = ""
input.TextColor3 = Color3.new(1,1,1)
input.BackgroundColor3 = Color3.fromRGB(50,50,50)
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.BorderSizePixel = 0

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 80)
button.Text = "Submit"
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.BorderSizePixel = 0

button.MouseButton1Click:Connect(function()
    if input.Text == KEY then
        gui:Destroy()

        -- === BEGIN mhmd2k_hub.lua code ===
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TweenService = game:GetService("TweenService")
        local TeleportService = game:GetService("TeleportService")
        local Workspace = game:GetService("Workspace")

        local Hub = {}

        -- CONFIG
        local AUTO_STEAL_ENABLED = true
        local AUTO_BUY_BRAINROT_ENABLED = true
        local AUTO_REBIRTH_ENABLED = true
        local AUTO_SKY_DELIVERY_ENABLED = true
        local AUTO_RESPAWN_AURA_ENABLED = true
        local TOUCH_FLING_ENABLED = true
        local BRAINROT_ESP_ENABLED = true
        local HIT_AURA_ENABLED = true
        local ULTRA_SPEED_ENABLED = true

        local ALLOWED_INVISIBILITY_CLOAK_NAME = "Invisibility Cloak"

        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

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

        function Hub:EnableVoidPlayer()
            spawn(function()
                while true do
                    local character = LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
                    end
                    wait(1)
                end
            end)
        end

        function Hub:EnableAntiHitSteal()
            spawn(function()
                while true do
                    local character = LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                    wait(0.5)
                end
            end)
        end

        function Hub:AlwaysInvisible()
            spawn(function()
                while true do
                    if not self:HasInvisibilityCloak() then
                        self:EquipInvisibilityCloak()
                    end
                    wait(5)
                end
            end)
        end

        function Hub:RemoveEffects()
            spawn(function()
                while true do
                    for _, effect in pairs(Workspace:GetChildren()) do
                        if effect.Name == "BoogieBombEffect" or effect.Name == "BeeLauncherEffect" then
                            effect:Destroy()
                        end
                    end
                    wait(3)
                end
            end)
        end

        function Hub:EnableUltraSpeed()
            spawn(function()
                while true do
                    if ULTRA_SPEED_ENABLED and self:HasInvisibilityCloak() then
                        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.WalkSpeed = 100
                        end
                    else
                        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.WalkSpeed = 16
                        end
                    end
                    wait(1)
                end
            end)
        end

        function Hub:TouchFling()
            spawn(function()
                while TOUCH_FLING_ENABLED do
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
                                    game.Debris:AddItem(bodyVelocity, 0.1)
                                end
                            end
                        end
                    end
                    wait(0.5)
                end
            end)
        end

        function Hub:AntiSlow()
            spawn(function()
                while true do
                    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.WalkSpeed < 16 then
                        humanoid.WalkSpeed = 16
                    end
                    wait(1)
                end
            end)
        end

        function Hub:AutoBuyBrainrot()
            -- Placeholder for game-specific implementation
        end

        function Hub:AutoVoidAura()
            -- Placeholder for game-specific implementation
        end

        function Hub:StunlockPlayers()
            -- Placeholder for game-specific implementation
        end

        function Hub:EnableBrainrotESP()
            spawn(function()
                local function highlightBrainrot(brainrot)
                    if not brainrot:FindFirstChildOfClass("Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = brainrot
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                        highlight.Parent = brainrot
                    end
                end
                
                while BRAINROT_ESP_ENABLED do
                    for _, brainrot in pairs(Workspace:GetChildren()) do
                        if brainrot.Name == "Brainrot" then
                            highlightBrainrot(brainrot)
                        end
                    end
                    wait(3)
                end
            end)
        end

        function Hub:AutoSteal()
            -- Placeholder for game-specific implementation
        end

        function Hub:AutoRebirth()
            -- Placeholder for game-specific implementation
        end

        function Hub:AutoSkyDelivery()
            -- Placeholder for game-specific implementation
        end

        function Hub:AutoRespawnAura()
            -- Placeholder for game-specific implementation
        end

        function Hub:HitAura()
            -- Placeholder for game-specific implementation
        end

        function Hub:ServerHop()
            -- Placeholder for server hop implementation
        end

        function Hub:ReduceLag()
            local Lighting = game:GetService("Lighting")
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 10000
            settings().Rendering.QualityLevel = "Level01"
        end

        function Hub:Start()
            self:AlwaysInvisible()
            self:EnableUltraSpeed()
            self:AntiSlow()
            self:EnableAntiHitSteal()
            self:EnableBrainrotESP()
            self:ReduceLag()
            
            if TOUCH_FLING_ENABLED then
                self:TouchFling()
            end
            
            if AUTO_BUY_BRAINROT_ENABLED then
                self:AutoBuyBrainrot()
            end

            if AUTO_REBIRTH_ENABLED then
                self:AutoRebirth()
            end

            self:AutoSteal()
            self:AutoSkyDelivery()
            self:AutoRespawnAura()
            self:HitAura()
            self:StunlockPlayers()
            self:AutoVoidAura()
            
            print("mhmd2k Hub Loaded!")
        end

        Hub:Start()
        -- === END mhmd2k_hub.lua code ===

    else
        input.Text = ""
        input.PlaceholderText = "Wrong key!"
        input.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
