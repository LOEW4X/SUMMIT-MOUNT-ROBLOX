-- [ AUTO TELEPORT MENU - MINIMAL DRAG ICON ]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local checkpoints = {
    {"CP 1", CFrame.new(171, -213, 74)},
    {"PUNCAK", CFrame.new(151, -195, 127)},
    {"MODE", CFrame.new(114, -231, 122)}
}

local autoTeleport = false

-- ScreenGui utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "TeleportMenu"

-- Menu Frame
local MenuFrame = Instance.new("Frame")
MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0,180,0,80)
MenuFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MenuFrame.Visible = false
MenuFrame.BorderSizePixel = 0
MenuFrame.ClipsDescendants = true

-- Tombol Auto Teleport ON/OFF
local autoBtn = Instance.new("TextButton")
autoBtn.Parent = MenuFrame
autoBtn.Size = UDim2.new(1,0,1,0)
autoBtn.Position = UDim2.new(0,0,0,0)
autoBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
autoBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoBtn.Text = "Auto Teleport: OFF"
autoBtn.Font = Enum.Font.SourceSansBold
autoBtn.TextSize = 18

autoBtn.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    autoBtn.Text = "Auto Teleport: "..(autoTeleport and "ON" or "OFF")
end)

-- Icon draggable
local showIcon = Instance.new("TextButton")
showIcon.Parent = ScreenGui
showIcon.Size = UDim2.new(0,50,0,50)
showIcon.Position = UDim2.new(0,100,0,100)
showIcon.Text = "TP"
showIcon.Font = Enum.Font.SourceSansBold
showIcon.TextSize = 20
showIcon.TextColor3 = Color3.fromRGB(255,255,255)
showIcon.BackgroundColor3 = Color3.fromRGB(0,0,0)
showIcon.BorderSizePixel = 0

-- Drag logic
local dragging, dragInput, dragStart, startPos

showIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = showIcon.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

showIcon.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        showIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        -- Update posisi menu juga saat menu sedang visible
        if MenuFrame.Visible then
            MenuFrame.Position = UDim2.new(0, showIcon.Position.X.Offset, 0, showIcon.Position.Y.Offset)
        end
    end
end)

-- Show/hide menu
showIcon.MouseButton2Click:Connect(function() -- klik kanan untuk toggle menu
    MenuFrame.Visible = not MenuFrame.Visible
    if MenuFrame.Visible then
        MenuFrame.Position = UDim2.new(0, showIcon.Position.X.Offset, 0, showIcon.Position.Y.Offset)
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
