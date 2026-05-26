-- Peek Kill / TP Kill Movement
local PeekKill = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

getgenv().PeekKillEnabled = getgenv().PeekKillEnabled or false
getgenv().PeekKillVelocity = getgenv().PeekKillVelocity or 1050

function PeekKill:Jump()
    if not getgenv().PeekKillEnabled then return end
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.new(hrp.Velocity.X, getgenv().PeekKillVelocity + math.random(-15, 15), hrp.Velocity.Z)
    end
end

return PeekKill
