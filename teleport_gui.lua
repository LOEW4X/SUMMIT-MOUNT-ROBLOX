-- [AUTO TELEPORT MENU ANDROID & PC STABLE]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local checkpoints = {
    {"CP 1", CFrame.new(171, -213, 74)},
    {"PUNCAK", CFrame.new(151, -195, 127)},
    {"MODE", CFrame.new(114, -231, 122)}
}

local autoTeleport = false

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "TeleportMenuGui"

-- Menu Frame
local MenuFrame = Instance.new("Frame")
MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0,180,0,80)
MenuFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false

-- Auto Teleport Button
local AutoBtn = Instance.new("TextButton")
AutoBtn.Parent = MenuFrame
AutoBtn.Size = UDim2.new(1,0,1,0)
AutoBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
AutoBtn.TextColor3 = Color3.fromRGB(255,255,255)
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.TextSize = 18
AutoBtn.Text = "Auto Teleport: OFF"

AutoBtn.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    AutoBtn.Text = "Auto Teleport: "..(autoTeleport and "ON" or "OFF")
end)

-- Icon
local Icon = Instance.new("TextButton")
Icon.Parent = ScreenGui
Icon.Size = UDim2.new(0,50,0,50)
Icon.Position = UDim2.new(0,100,0,100)
Icon.BackgroundColor3 = Color3.fromRGB(0,0,0)
Icon.BorderSizePixel = 0
Icon.Text = "TP"
Icon.Font = Enum.Font.SourceSansBold
Icon.TextSize = 20
Icon.TextColor3 = Color3.fromRGB(255,255,255)

-- Drag logic
local dragging = false
local dragStart, startPos
local dragInput

local function update(input)
    local delta = input.Position - dragStart
    local pos = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
    Icon.Position = pos
    if MenuFrame.Visible then
        MenuFrame.Position = pos
    end
end

Icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Icon.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Icon.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

-- Toggle menu (tap or click)
Icon.Activated:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
    if MenuFrame.Visible then
        MenuFrame.Position = Icon.Position
    end
end)

-- Auto teleport sequence
spawn(function()
    while true do
        wait(1)
        if autoTeleport and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for i, cp in ipairs(checkpoints) do
                if not autoTeleport then break end
                local name, cf = cp[1], cp[2]
                player.Character.HumanoidRootPart.CFrame = cf

                -- Summit update
                if name == "PUNCAK" then
                    local leaderstats = player:FindFirstChild("leaderstats")
                    if leaderstats and leaderstats:FindFirstChild("Summit") then
                        leaderstats.Summit.Value = leaderstats.Summit.Value + 1
                    end
                end
                wait(2)
            end
            if autoTeleport then
                autoTeleport = false
                AutoBtn.Text = "Auto Teleport: OFF"
            end
        end
    end
end)

-- Auto teleport berurutan
spawn(function()
    while true do
        wait(1)
        if autoTeleport and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for i, data in ipairs(checkpoints) do
                if not autoTeleport then break end
                local name, cf = data[1], data[2]
                player.Character.HumanoidRootPart.CFrame = cf

                if name == "PUNCAK" then
                    local leaderstats = player:FindFirstChild("leaderstats")
                    if leaderstats and leaderstats:FindFirstChild("Summit") then
                        leaderstats.Summit.Value = leaderstats.Summit.Value + 1
                    end
                end

                wait(2)
            end
            -- Auto off setelah checkpoint terakhir
            if autoTeleport then
                autoTeleport = false
                autoBtn.Text = "Auto Teleport: OFF"
            end
        end
    end
end)
                local name, cf = data[1], data[2]
                player.Character.HumanoidRootPart.CFrame = cf

                if name == "PUNCAK" then
                    local leaderstats = player:FindFirstChild("leaderstats")
                    if leaderstats and leaderstats:FindFirstChild("Summit") then
                        leaderstats.Summit.Value = leaderstats.Summit.Value + 1
                    end
                end

                wait(2)
            end
            -- Auto off setelah checkpoint terakhir
            if autoTeleport then
                autoTeleport = false
                autoBtn.Text = "Auto Teleport: OFF"
            end
        end
    end
end)
