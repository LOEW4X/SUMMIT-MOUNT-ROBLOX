--// Teleport GUI with Auto Teleport On/Off (Delay 1 detik)
-- Dibuat untuk Executor (loadstring)

local player = game.Players.LocalPlayer

-- Daftar checkpoint kamu
local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, -231, 122)
}

-- Urutkan checkpoints sesuai daftar
local checkpointOrder = {"CP 1", "PUNCAK", "MODE"}

-- Buat GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0, 20, 0.5, -25)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0

-- Tombol On/Off
local toggleBtn = Instance.new("TextButton", Frame)
toggleBtn.Size = UDim2.new(1, -10, 1, -10)
toggleBtn.Position = UDim2.new(0, 5, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "Auto Teleport: OFF"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18

local autoTeleport = false
local teleportThread

local function teleportTo(cf)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = cf + Vector3.new(0, 3, 0)
end

local function startAutoTeleport()
    teleportThread = spawn(function()
        while autoTeleport do
            for _, name in ipairs(checkpointOrder) do
                if not autoTeleport then break end
                teleportTo(checkpoints[name])
                wait(1) -- delay 1 detik antar teleport
            end
        end
    end)
end

toggleBtn.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    toggleBtn.Text = autoTeleport and "Auto Teleport: ON" or "Auto Teleport: OFF"
    if autoTeleport then
        startAutoTeleport()
    end
end)
