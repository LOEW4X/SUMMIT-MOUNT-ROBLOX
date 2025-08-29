--// Teleport GUI with Checkpoints
-- Dibuat untuk Executor (loadstring)

local player = game.Players.LocalPlayer

-- Daftar checkpoint kamu (isi sesuai hasil catatan)
local checkpoints = {
    ["Puncak"] = CFrame.new(151, 195, 127),
    ["Pilih Mode"] = CFrame.new(114, 231, 122)
}

-- Buat GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, (#checkpoints * 40) + 10)
Frame.Position = UDim2.new(0, 20, 0.5, -Frame.Size.Y.Offset/2)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Fungsi teleport
local function teleportTo(cf)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = cf + Vector3.new(0, 3, 0) -- offset biar nggak nempel tanah
end

-- Generate tombol dari list checkpoint
for name, cf in pairs(checkpoints) do
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(function()
        teleportTo(cf)
    end)
end
