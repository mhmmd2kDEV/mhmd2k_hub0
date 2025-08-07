-- mhmd2k Hub Loader
if game.PlaceId ~= 17663805271 then
    return warn("mhmd2k Hub only works in 'Steal a Brainrot'")
end

local KEY = "MHMMDWSCRIPTS"

-- UI LIBRARY
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "mhmd2kHub"
gui.ResetOnSpawn = false

-- DARK BACKGROUND
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(0, 400, 0, 250)
bg.Position = UDim2.new(0.5, -200, 0.5, -125)
bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bg.BorderSizePixel = 0

-- NEON RAINBOW M LOGO
local logo = Instance.new("TextLabel", bg)
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Text = "M"
logo.Font = Enum.Font.Fantasy
logo.TextColor3 = Color3.fromHSV(tick()%5/5, 1, 1)
logo.TextScaled = true
logo.BackgroundTransparency = 1

-- KEY INPUT
local keyBox = Instance.new("TextBox", bg)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.6, 0)
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.BorderSizePixel = 0
keyBox.TextColor3 = Color3.new(1, 1, 1)

-- SUBMIT BUTTON
local submitBtn = Instance.new("TextButton", bg)
submitBtn.Size = UDim2.new(0.5, 0, 0, 35)
submitBtn.Position = UDim2.new(0.25, 0, 0.8, 0)
submitBtn.Text = "Submit"
submitBtn.TextScaled = true
submitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
submitBtn.BorderSizePixel = 0
submitBtn.TextColor3 = Color3.new(1, 1, 1)

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", bg)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Small M logo (for minimized state)
local miniLogo = Instance.new("TextLabel")
miniLogo.Size = UDim2.new(0, 40, 0, 40)
miniLogo.Position = UDim2.new(0, 10, 0, 10)
miniLogo.Text = "M"
miniLogo.Font = Enum.Font.Fantasy
miniLogo.TextScaled = true
miniLogo.Visible = false
miniLogo.Parent = gui
miniLogo.TextColor3 = Color3.fromHSV(tick()%5/5, 1, 1)
miniLogo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- MINIMIZE FUNCTIONALITY
minimizeBtn.MouseButton1Click:Connect(function()
    bg.Visible = false
    miniLogo.Visible = true
end)

-- Restore on Ctrl
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.LeftControl then
        bg.Visible = true
        miniLogo.Visible = false
    end
end)

-- Submit key and load main
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == KEY then
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mhmmd2kDEV/mhmd2k_hub0/main/mhmd2k_hub.lua"))()
    else
        keyBox.Text = "❌ Wrong Key"
        wait(1)
        keyBox.Text = ""
    end
end)
