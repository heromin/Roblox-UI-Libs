-- Target Freezer Module
local FreezeTarget = {
    Registry = {}
}

getgenv().FreezeTargetEnabled = getgenv().FreezeTargetEnabled or false

function FreezeTarget:Set(player, state)
    if not player or not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        if getgenv().FreezeTargetEnabled and state then
            hrp.Anchored = true
            self.Registry[player.Name] = player
        else
            hrp.Anchored = false
            self.Registry[player.Name] = nil
        end
    end
end

function FreezeTarget:UnfreezeAll()
    for _, player in pairs(self.Registry) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = false
        end
    end
    self.Registry = {}
end

return FreezeTarget
