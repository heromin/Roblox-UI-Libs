-- Low Food/Water Detector
local VitalIndicator = { Enabled = false, Threshold = 200 }
local LocalPlayer = game:GetService("Players").LocalPlayer

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local line = Instance.new("Frame", gui)
line.Name = "VitalAlert"; line.Size = UDim2.new(1, 0, 0, 3); line.BorderSizePixel = 0; line.Visible = false

game:GetService("RunService").Heartbeat:Connect(function()
    if not VitalIndicator.Enabled then line.Visible = false; return end
    
    local stats = LocalPlayer.PlayerGui:FindFirstChild("MainGui") 
        and LocalPlayer.PlayerGui.MainGui:FindFirstChild("MainFrame")
        and LocalPlayer.PlayerGui.MainGui.MainFrame:FindFirstChild("BackpackFrame")
        and LocalPlayer.PlayerGui.MainGui.MainFrame.BackpackFrame:FindFirstChild("CharacterFrame")
        and LocalPlayer.PlayerGui.MainGui.MainFrame.BackpackFrame.CharacterFrame:FindFirstChild("VitalSigns")

    if stats then
        local hunger = tonumber(stats.Hunger.Number.Text:match("^(.-)/")) or 1000
        local water = tonumber(stats.Hydration.Number.Text:match("^(.-)/")) or 1000
        
        if hunger <= VitalIndicator.Threshold then
            line.Visible = true; line.BackgroundColor3 = Color3.new(1, 0, 0)
        elseif water <= VitalIndicator.Threshold then
            line.Visible = true; line.BackgroundColor3 = Color3.new(0, 1, 1)
        else
            line.Visible = false
        end
    end
end)

return VitalIndicator
