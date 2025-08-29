--// Teleport GUI by LOEW4X (versi lengkap dengan Show/Hide)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.Parent = game.CoreGui

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.Text = "Teleport Menu"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = mainFrame

-- Tombol Hide
local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 60, 0, 25)
hideBtn.Position = UDim2.new(1, -70, 0, 5)
hideBtn.Text = "Hide"
hideBtn.TextColor3 = Color3.fromRGB(255,255,255)
hideBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
hideBtn.Parent = mainFrame

-- Tombol Show (icon kecil)
local showBtn = Instance.new("TextButton")
showBtn.Size = UDim2.new(0, 40, 0, 40)
showBtn.Position = UDim2.new(0, 10, 0, 100)
showBtn.Text = "+"
showBtn.TextScaled = true
showBtn.TextColor3 = Color3.fromRGB(255,255,255)
showBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
showBtn.Visible = false
showBtn.Active = true
showBtn.Draggable = true
showBtn.Parent = screenGui

-- Event tombol Hide/Show
hideBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    showBtn.Visible = true
end)

showBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    showBtn.Visible = false
end)

-- Fungsi teleport aman (pakai raycast)
local function safeTeleport(cf)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ray = Ray.new(cf.Position + Vector3.new(0, 50, 0), Vector3.new(0, -500, 0))
    local part, pos = workspace:FindPartOnRay(ray, LocalPlayer.Character)

    if pos then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
    else
        hrp.CFrame = cf
    end
end

-- Fungsi untuk trigger checkpoint (biar summit count nambah)
local function triggerCheckpoint()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("TouchTransmitter") and obj.Parent then
            local part = obj.Parent
            if part:IsA("BasePart") and part.Name:lower():find("checkpoint") then
                firetouchinterest(hrp, part, 0)
                task.wait(0.2)
                firetouchinterest(hrp, part, 1)
            end
        end
    end
end

-- Daftar checkpoint
local checkpoints = {
    ["Puncak"] = CFrame.new(151, 195, 127),
    ["Pilih Mode"] = CFrame.new(114, 231, 122)
}

-- Buat tombol teleport
local i = 0
for name, cf in pairs(checkpoints) do
    i += 1
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, 45 + (i-1)*35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(0,120,200)
    btn.Parent = mainFrame

    btn.MouseButton1Click:Connect(function()
        safeTeleport(cf)
        task.wait(0.3)
        triggerCheckpoint()
    end)
end
