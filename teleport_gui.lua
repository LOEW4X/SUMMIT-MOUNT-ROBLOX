-- [ SIMPLE TELEPORT MENU WITH TOGGLE ]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(150, -197, 126),
    ["MODE"] = CFrame.new(114, -231, 122)
}

-- ScreenGui utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Frame untuk menu teleport
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 200, 0, 0) -- awalnya tinggi 0, nanti berkembang saat show
menuFrame.Position = UDim2.new(0, 20, 0, 60)
menuFrame.BackgroundColor3 = Color3.fromRGB(138,43,226)
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
        -- kalau ke PUNCAK auto tambah Summit
        if name == "PUNCAK" then
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats and leaderstats:FindFirstChild("Summit") then
                leaderstats.Summit.Value = leaderstats.Summit.Value + 1
            end
        end
    end)

    y = y + 50
end

-- tombol toggle (ikon kecil)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = ScreenGui
toggleBtn.Size = UDim2.new(0,50,0,50)
toggleBtn.Position = UDim2.new(0,20,0,10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Text = "≡" -- simbol menu
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 24

toggleBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)
