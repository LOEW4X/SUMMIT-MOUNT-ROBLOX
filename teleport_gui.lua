--// Teleport GUI + Auto Teleport + Draggable Menu + Stylish Button + Optimized Auto Hold ProximityPrompt
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

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0.5, -100, 0.5, -25)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Visible = true

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
local holdingPrompt = false
local pauseAfterPrompt = false

-- Teleport Function
local function teleportTo(cf)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = cf + Vector3.new(0, 3, 0)
end

-- Auto Teleport Loop
local function startAutoTeleport()
    spawn(function()
        while autoTeleport do
            for _, name in ipairs(checkpointOrder) do
                if not autoTeleport then break end
                -- tunggu jika sedang hold prompt atau pause setelah prompt
                while (holdingPrompt or pauseAfterPrompt) and autoTeleport do
                    task.wait(0.1)
                end
                teleportTo(checkpoints[name])
                task.wait(1)
            end
        end
    end)
end

toggleBtn.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    if autoTeleport then
        toggleBtn.Text = "Auto Teleport: ON"
        toggleBtn.TextColor3 = Color3.fromRGB(200, 0, 200)
        startAutoTeleport()
    else
        toggleBtn.Text = "Auto Teleport: OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- Icon Button
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

-- Drag Icon
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

-- Optimized Auto Hold ProximityPrompt
spawn(function()
    while true do
        task.wait(0.2) -- loop ringan, cek tiap 0.2 detik saja
        if not player.Character then continue end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Enabled and not holdingPrompt then
                local distance = (prompt.Parent.Position - hrp.Position).Magnitude
                if distance <= prompt.MaxActivationDistance then
                    spawn(function()
                        holdingPrompt = true
                        prompt:InputHoldBegin()
                        task.wait(prompt.HoldDuration)
                        prompt:InputHoldEnd()
                        holdingPrompt = false
                        pauseAfterPrompt = true
                        task.wait(0.5) -- berhenti sebentar sebelum teleport lanjut
                        pauseAfterPrompt = false
                    end)
                end
            end
        end
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
            if distance <= prompt.MaxActivationDistance and not holdingPrompt then
                spawn(function()
                    holdingPrompt = true -- pause auto teleport
                    prompt:InputHoldBegin()
                    task.wait(prompt.HoldDuration)
                    prompt:InputHoldEnd()
                    holdingPrompt = false -- lanjut auto teleport
                end)
            end
        end
    end
end)
