--// Teleport GUI + Auto Teleport + Draggable Menu + Stylish Button + Auto Hold ProximityPrompt dengan Pause Teleport
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Daftar checkpoint
local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, -231, 122)
}
local checkpointOrder = {"CP 1", "PUNCAK", "MODE"}

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame utama GUI
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0.5, -100, 0.5, -25)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Visible = true

-- Tombol On/Off Auto Teleport
local toggleBtn = Instance.new("TextButton", Frame)
toggleBtn.Size = UDim2.new(1, -10, 1, -10)
toggleBtn.Position = UDim2.new(0, 5, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.BackgroundTransparency = 0.5
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "Auto Teleport: OFF"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18

local autoTeleport = false
local pauseTeleport = false -- pause saat hold proximity

local function teleportTo(cf)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = cf + Vector3.new(0, 3, 0)
end

local function startAutoTeleport()
    spawn(function()
        while autoTeleport do
            for _, name in ipairs(checkpointOrder) do
                if not autoTeleport then break end
                -- tunggu jika sedang pause
                while pauseTeleport and autoTeleport do
                    wait()
                end
                teleportTo(checkpoints[name])
                wait(1)
            end
        end
    end)
end

toggleBtn.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    if autoTeleport then
        toggleBtn.Text = "Auto Teleport: ON"
        toggleBtn.TextColor3 = Color3.fromRGB(200, 0, 200) -- Ungu
        startAutoTeleport()
    else
        toggleBtn.Text = "Auto Teleport: OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- Tombol icon menu
local iconBtn = Instance.new("TextButton", ScreenGui)
iconBtn.Size = UDim2.new(0, 40, 0, 40)
iconBtn.Position = UDim2.new(0, 10, 0.5, -20)
iconBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
iconBtn.Text = "≡"
iconBtn.Font = Enum.Font.SourceSansBold
iconBtn.TextSize = 24

local guiVisible = true
iconBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    Frame.Visible = guiVisible
end)

-- Drag ikon menu
local dragging, dragInput, dragStart, startPos = false
iconBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = iconBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
iconBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        iconBtn.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        Frame.Position = UDim2.new(
            0,
            iconBtn.Position.X.Offset + 50,
            iconBtn.Position.Y.Scale,
            iconBtn.Position.Y.Offset - 25
        )
    end
end)

-- Auto hold ProximityPrompt dengan pause Auto Teleport
RunService.Heartbeat:Connect(function()
    if not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local distance = (prompt.Parent.Position - hrp.Position).Magnitude
            if distance <= prompt.MaxActivationDistance then
                spawn(function()
                    pauseTeleport = true -- pause auto teleport
                    prompt:InputHoldBegin()
                    wait(prompt.HoldDuration)
                    prompt:InputHoldEnd()
                    pauseTeleport = false -- lanjut auto teleport
                end)
            end
        end
    end
end)
