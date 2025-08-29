-- EXCELLENT Teleport GUI
-- Buat dieksekusi lewat executor (bukan Studio)
-- Author: Saputra Aryadi

-- Dapatkan Player
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ExcellentTeleport"
gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- INTRO (Excellent Text)
------------------------------------------------
local intro = Instance.new("TextLabel")
intro.Size = UDim2.new(1, 0, 1, 0)
intro.BackgroundTransparency = 1
intro.Text = "ＥＸＣＥＬＬＥＮＴ"
intro.TextScaled = true
intro.Font = Enum.Font.Arcade
intro.TextColor3 = Color3.fromRGB(128, 0, 128) -- ungu
intro.Parent = gui

-- Animasi intro
intro.TextTransparency = 1
game:GetService("TweenService"):Create(intro, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
task.wait(2)
game:GetService("TweenService"):Create(intro, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
task.wait(1)
intro:Destroy()

------------------------------------------------
-- MENU FRAME
------------------------------------------------
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 300)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.2
frame.Visible = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🏔️ Teleport Gunung"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

-- Scroll untuk tombol gunung
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -40)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = frame

------------------------------------------------
-- DATA GUNUNG
------------------------------------------------
local Teleports = {
    ["Mount Kawah Terjun"] = Vector3.new(100, 50, 200),
    ["Mount Summit"] = Vector3.new(150, 120, 300),
    ["Mount Merapi"] = Vector3.new(-50, 80, 400),
    ["Mount Slamet"] = Vector3.new(250, 200, 100),
    ["Mount Bromo"] = Vector3.new(350, 180, -250),
}

------------------------------------------------
-- GENERATE TOMBOL
------------------------------------------------
local yPos = 0
for name, pos in pairs(Teleports) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(90, 0, 120)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = scroll

    btn.MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(pos)
    end)

    yPos = yPos + 45
end

scroll.CanvasSize = UDim2.new(0,0,0,yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, 45 + (i-1)*35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(0,120,200)
    btn.Parent = mainFrame

    btn.MouseButton1Click:Connect(function()
        safeTeleport(cf)
        task.wait(0.3)
        triggerCheckpoint()
    end)
end
