-- [ SIMPLE TELEPORT MENU WITH DRAGGABLE ICON ]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(159, -220, 160),
    ["MODE"] = CFrame.new(114, -231, 122)
}

-- ScreenGui utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame untuk menu teleport
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 200, 0, 0) -- awalnya tinggi 0
menuFrame.Position = UDim2.new(0, 20, 0, 60)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- hitam
menuFrame.BackgroundTransparency = 0.8 -- transparan 80%
menuFrame.Visible = false
menuFrame.Parent = ScreenGui

local y = 10 -- posisi awal tombol di dalam frame
for name, cf in pairs(checkpoints) do
    local btn = Instance.new("TextButton")
    btn.Parent = menuFrame
    btn.Size = UDim2.new(0,180,0,40)
    btn.Position = UDim2.new(0,10,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(75,0,130) -- ungu gelap
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = "Teleport "..name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    
    btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = cf
        end
        if name == "PUNCAK" then
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats and leaderstats:FindFirstChild("Summit") then
                leaderstats.Summit.Value = leaderstats.Summit.Value + 1
            end
        end
    end)

    y = y + 50
end

-- tombol toggle (ikon kecil, draggable)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = ScreenGui
toggleBtn.Size = UDim2.new(0,50,0,50)
toggleBtn.Position = UDim2.new(0,20,0,10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(75,0,130) -- ungu gelap
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.BorderColor3 = Color3.fromRGB(75,0,130)
toggleBtn.BorderSizePixel = 2
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 24
toggleBtn.AutoButtonColor = false
toggleBtn.AnchorPoint = Vector2.new(0,0)
toggleBtn.ClipsDescendants = true
toggleBtn.Style = Enum.ButtonStyle.Custom
toggleBtn.Rounding = UDim.new(0,10)

-- UIStroke untuk outline ungu transparan 65%
local stroke = Instance.new("UIStroke")
stroke.Parent = toggleBtn
stroke.Color = Color3.fromRGB(138,43,226)
stroke.Transparency = 0.65
stroke.Thickness = 2

-- toggle menu
toggleBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- drag function (diperbaiki)
local dragging = false
local dragInput, dragStart, startPos

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleBtn.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        toggleBtn.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
