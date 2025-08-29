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
