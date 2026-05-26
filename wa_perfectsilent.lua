-- Perfect Silent Aim Utility
local PerfectSilent = {}
local Camera = workspace.CurrentCamera

getgenv().PerfectSilentEnabled = getgenv().PerfectSilentEnabled or false

function PerfectSilent:Apply(targetPosition)
    if not getgenv().PerfectSilentEnabled then return end
    
    local viewModel = Camera:FindFirstChild("ViewModel")
    if viewModel and viewModel:FindFirstChild("Item") then
        local attachPoints = viewModel.Item:FindFirstChild("AttachmentPoints")
        -- El exploit utiliza el punto 'Extra' para alinear el cañón directamente al objetivo
        local aimPart = attachPoints and attachPoints:FindFirstChild("Extra")
        
        if aimPart then
            aimPart.CFrame = CFrame.new(aimPart.Position, targetPosition)
        end
    end
end

return PerfectSilent
