-- [ EXCELLENT TELEPORT MENU ]
-- Script by EXCELLENT
-- Tinggal copy ke executor

--// Intro saat executor jalan
game.StarterGui:SetCore("SendNotification", {
    Title = "EXCELLENT";
    Text = "Teleport Menu Aktif!";
    Duration = 5;
})

--// Daftar checkpoint
local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, -231, 122)
}

--// UI Buat tombol utama
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Tombol show/hide
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0,120,0,40)
ToggleButton.Position = UDim2.new(0,10,0,200)
ToggleButton.BackgroundColor3 = Color3.fromRGB(80,0,160)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Text = "Teleport Menu"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 18

-- Frame menu
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,150,0,0)
Frame.Position = UDim2.new(0,10,0,250)
Frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Frame.Visible = false

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Bikin tombol tiap checkpoint
for name, cf in pairs(checkpoints) do
    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(100,0,200)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Text = name
