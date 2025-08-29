-- [ MODERN TELEPORT MENU ]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, -231, 122)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Background Frame
local bg = Instance.new("Frame")
bg.Parent = ScreenGui
bg.Size = UDim2.new(0, 200, 0, #checkpoints * 50 + 50)
bg.Position = UDim2.new(0, 20, 0, 100)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 0.2 -- 80% opaque
bg.BorderSizePixel = 0
bg.ClipsDescendants = true

-- Outline
local outline = Instance.new("UIStroke")
outline.Parent = bg
outline.Color = Color3.fromRGB(138,43,226)
outline.Transparency = 0.6
outline.Thickness = 3
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Sudut melengkung
local corner = Instance.new("UICorner")
corner.Parent = bg
corner.CornerRadius = UDim.new(0,12)

-- Fungsi untuk Tween tombol
local function TweenButton(button, goal, time)
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(button, tweenInfo, goal)
    tween:Play()
end

-- Tombol-tombol
local y = 10
for name, cf in pairs(checkpoints) do
    local btn = Instance.new("TextButton")
    btn.Parent = bg
    btn.Size = UDim2.new(0,150,0,40)
    btn.Position = UDim2.new(0,25,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(138,43,226)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = "Teleport "..name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.AutoButtonColor = false -- kita handle sendiri

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenButton(btn, {BackgroundColor3 = Color3.fromRGB(186,85,211)}, 0.2)
    end)
    btn.MouseLeave:Connect(function()
        TweenButton(btn, {BackgroundColor3 = Color3.fromRGB(138,43,226)}, 0.2)
    end)

    -- Click effect & teleport
    btn.MouseButton1Click:Connect(function()
        -- animasi klik
        TweenButton(btn, {Size = UDim2.new(0,140,0,36)}, 0.1)
        wait(0.1)
        TweenButton(btn, {Size = UDim2.new(0,150,0,40)}, 0.1)

        -- teleport player
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
