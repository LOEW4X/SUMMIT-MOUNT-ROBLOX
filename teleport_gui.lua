-- [ AUTO TELEPORT + AUTO HOLD PROMPT EFFICIENT ]
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local checkpoints = {
    ["CP 1"] = CFrame.new(171, -213, 74),
    ["PUNCAK"] = CFrame.new(151, -195, 127),
    ["MODE"] = CFrame.new(114, -231, 122)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local y = 50
local autoTeleportEnabled = false

-- Tombol On / Off
local onOffBtn = Instance.new("TextButton")
onOffBtn.Parent = ScreenGui
onOffBtn.Size = UDim2.new(0,150,0,40)
onOffBtn.Position = UDim2.new(0,20,0,y)
onOffBtn.BackgroundColor3 = Color3.fromRGB(255,69,0)
onOffBtn.TextColor3 = Color3.fromRGB(255,255,255)
onOffBtn.Font = Enum.Font.SourceSansBold
onOffBtn.TextSize = 18
onOffBtn.Text = "Auto Teleport OFF"

onOffBtn.MouseButton1Click:Connect(function()
    autoTeleportEnabled = not autoTeleportEnabled
    if autoTeleportEnabled then
        onOffBtn.Text = "Auto Teleport ON"
    else
        onOffBtn.Text = "Auto Teleport OFF"
    end
end)

y = y + 60

-- Fungsi auto hold ProximityPrompt dekat player
local function holdNearbyPrompts(prompt)
    if not prompt or not prompt.Parent then return end
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- hanya hold prompt yang dekat player
    if (prompt.Position - root.Position).Magnitude > 10 then return end

    -- mulai hold
    prompt:InputHoldBegin()
    wait(prompt.HoldDuration)
    prompt:InputHoldEnd() -- otomatis stop saat durasi selesai

    -- matikan auto teleport setelah hold selesai
    autoTeleportEnabled = false
    onOffBtn.Text = "Auto Teleport OFF"
end

-- Auto teleport loop
spawn(function()
    while true do
        wait(1) -- delay utama
        if autoTeleportEnabled then
            for name, cf in pairs(checkpoints) do
                if not autoTeleportEnabled then break end

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

                -- cek prompt dekat player
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and (obj.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        holdNearbyPrompts(obj)
                        break -- hanya hold prompt pertama yang ditemukan
                    end
                end

                wait(1) -- delay 1 detik sebelum checkpoint berikutnya
            end
        end
    end
end)
