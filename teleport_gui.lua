-- [ SIMPLE TELEPORT MENU ]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, 231, 122)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local y = 100 -- posisi awal Y
for name, cf in pairs(checkpoints) do
    local btn = Instance.new("TextButton")
    btn.Parent = ScreenGui
    btn.Size = UDim2.new(0,150,0,40)
    btn.Position = UDim2.new(0,20,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(138,43,226) -- ungu
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = "Teleport "..name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    
    btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = cf
        end
        -- kalau ke PUNCAK auto tambah Summit
        if name == "PUNCAK" then
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats and leaderstats:FindFirstChild("Summit") then
                leaderstats.Summit.Value = leaderstats.Summit.Value + 1
            end
        end
    end)

    y = y + 50 -- geser ke bawah biar ga numpuk
end
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
end

-- Toggle button
toggleBtn.MouseButton1Click:Connect(function()
    scriptEnabled = not scriptEnabled
    autoTeleport = scriptEnabled
    if scriptEnabled then
        toggleBtn.Text = "Auto Teleport: ON"
        toggleBtn.TextColor3 = Color3.fromRGB(200,0,200)
        startAutoTeleport()
    else
        toggleBtn.Text = "Auto Teleport: OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    end
end)

-- Optimized auto hold ProximityPrompt
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
