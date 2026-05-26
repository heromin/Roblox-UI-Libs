-- Boss Information HUD Module
local BossInfo = {
    Enabled = false,
    Movable = false
}

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local function createHUD()
    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "BossInfoHUD"
    gui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame", gui)
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 180, 0, 100)
    frame.Position = UDim2.new(0.01, 0, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(131, 194, 242)
    frame.Visible = false
    
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "Boss Information"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Code
    title.TextSize = 14

    local function createBossLabel(name, pos)
        local label = Instance.new("TextLabel", frame)
        label.Name = name
        label.Size = UDim2.new(1, 0, 0, 20)
        label.Position = UDim2.new(0, 0, 0, 25 + (pos * 20))
        label.Text = name .. ": Not Found"
        label.TextColor3 = Color3.new(1, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Code
        label.TextSize = 12
        return label
    end

    return gui, frame, {
        Anton = createBossLabel("Anton", 0),
        Dozer = createBossLabel("Dozer", 1),
        Whisper = createBossLabel("Whisper", 2)
    }
end

local hud, mainFrame, labels = createHUD()

function BossInfo:SetEnabled(state)
    self.Enabled = state
    mainFrame.Visible = state
end

function BossInfo:Update()
    if not self.Enabled then return end
    local zones = workspace:FindFirstChild("AiZones")
    if not zones then return end

    local function check(z, b, lbl, attr)
        local boss = zones:FindFirstChild(z) and zones[z]:FindFirstChild(b)
        if boss and boss:FindFirstChild("Humanoid") then
            local hp = attr and boss.Humanoid:GetAttribute(attr) or boss.Humanoid.Health
            lbl.Text = b .. ": Alive (" .. math.floor(hp) .. (attr and "%" or " HP") .. ")"
            lbl.TextColor3 = Color3.new(0, 1, 0)
        else lbl.Text = b .. ": Dead"; lbl.TextColor3 = Color3.new(1, 0, 0) end
    end

    check("Sawmill", "Anton", labels.Anton)
    check("Factory", "Dozer", labels.Dozer)
    check("Whisper", "Whisper", labels.Whisper, "DodgeStamina")
end

RunService.Heartbeat:Connect(function() BossInfo:Update() end)
return BossInfo
