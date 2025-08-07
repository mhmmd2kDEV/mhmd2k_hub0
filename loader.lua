local KEY = "MHMMDWSCRIPTS"
local HUB_URL = "https://raw.githubusercontent.com/mhmmd2kDEV/mhmd2k_hub0/main/mhmd2k_hub.lua"

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
        loadstring(game:HttpGet(HUB_URL))()
    else
        input.Text = ""
        input.PlaceholderText = "Wrong key!"
        input.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
