--// Auto Teleport + Auto Hold ProximityPrompt + Simple GUI
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Kontrol script
local scriptEnabled = false
local autoTeleport = false
local holdingPrompt = false
local pauseAfterPrompt = false

-- Checkpoints
local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, -231, 122)
}
local checkpointOrder = {"CP 1", "PUNCAK", "MODE"}

-- GUI utama
local pg = player:WaitForChild("PlayerGui")
local sg = Instance.new("ScreenGui", pg)

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0,220,0,60)
frame.Position = UDim2.new(0.5,-110,0.5,-30)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BackgroundTransparency = 0.8
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(200,0,200)
frame.BorderTransparency = 0.5

-- Tombol toggle Auto Teleport
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1,-30,1,-10)
toggle.Position = UDim2.new(0,5,0,5)
toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggle.BackgroundTransparency = 0.8
toggle.BorderSizePixel = 1
toggle.BorderColor3 = Color3.fromRGB(200,0,200)
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Text = "Auto Teleport: OFF"
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 16

-- Tombol Hide/Show
local hideBtn = Instance.new("TextButton", frame)
hideBtn.Size = UDim2.new(0,20,0,20)
hideBtn.Position = UDim2.new(1,-25,0,5)
hideBtn.BackgroundColor3 = Color3.fromRGB(200,0,200)
hideBtn.BackgroundTransparency = 0.5
hideBtn.Text = "X"
hideBtn.TextSize = 14
hideBtn.TextColor3 = Color3.fromRGB(255,255,255)
hideBtn.Font = Enum.Font.SourceSansBold

hideBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Teleport function
local function teleportTo(cf)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = cf + Vector3.new(0,3,0)
end

-- Auto teleport loop
local function startAutoTeleport()
    spawn(function()
        while autoTeleport and scriptEnabled do
            for _,name in ipairs(checkpointOrder) do
                if not autoTeleport or not scriptEnabled then break end
                while (holdingPrompt or pauseAfterPrompt) and autoTeleport and scriptEnabled do
                    task.wait(0.1)
                end
                teleportTo(checkpoints[name])
                task.wait(1)
            end
        end
    end)
end

-- Toggle button
toggle.MouseButton1Click:Connect(function()
    scriptEnabled = not scriptEnabled
    autoTeleport = scriptEnabled
    if scriptEnabled then
        toggle.Text = "Auto Teleport: ON"
        toggle.TextColor3 = Color3.fromRGB(200,0,200)
        startAutoTeleport()
    else
        toggle.Text = "Auto Teleport: OFF"
        toggle.TextColor3 = Color3.fromRGB(255,255,255)
    end
end)

-- Auto hold ProximityPrompt loop
spawn(function()
    while true do
        task.wait(0.2)
        if not scriptEnabled then continue end
        if not player.Character then continue end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        for _,prompt in pairs(workspace:GetDescendants()) do
            if not scriptEnabled then break end
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
                        task.wait(0.5)
                        pauseAfterPrompt = false
                    end)
                end
            end
        end
    end
end)
